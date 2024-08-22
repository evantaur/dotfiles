#!/usr/bin/env python3
#
# Simple script to get info from a window
#
#

from subprocess import run
from time import sleep
import json


for i in list(range(1,4))[::-1]:
    print(f"sleeping {i} seconds")
    sleep(1)
print("SNAP!")

CMD = "swaymsg -t get_tree | jq -r '.. | " + \
    "select(.type?) | select(.focused == true)'"

window = run(CMD, shell=True, capture_output=True)
output = json.loads(window.stdout.decode("UTF-8"))

width = 46
for i in [
    "name",
    "title",
    "app_id",
    "class",
    "pid",
    "shell",
    "window_properties"]:
    if i in output:
        print(f"{i.ljust(10)}: {output[i]}")
if "app_id" in output:
    floating = (f'for_window [app_id={output["app_id"]}]'.ljust(46) + 'floating enable')
    run(f'wl-copy {floating}', capture_output=False, shell=True)
    print(floating)

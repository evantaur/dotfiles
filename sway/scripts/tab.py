#!/usr/bin/env python3
'''

    Proto tab switcher until i have time to rewrite it in rust
    It's garbage but it works

'''


from subprocess import call, check_output, run
from json import loads, dumps
from sys import argv

swaymsg="swaymsg"



cmd=f"{swaymsg} -t get_tree"
data = loads(check_output(cmd, shell=True))

line=-1
found_focus=False
first=False
previous=False
last=False

def extract_info(node):
    return  (node['id'], node['focused'])

def switchTo(win_id):
    cmd=f"{swaymsg} '[con_id={win_id}] focus'"
    run(cmd, shell=True)
    exit(0)

def process_nodes(nodes, reverse=False):
    global found_focus, first, previous, last
    global filtered_nodes
    for node in nodes:
        if 'pid' in node and 'visible' in node and node['pid'] and node['visible']:
            window = extract_info(node)
            last = window[0]
            if not first:
                first = window[0]

            if found_focus and not reverse:
                switchTo(window[0])
                break

            if window[1] :
                if reverse and previous:
                    switchTo(previous)
                found_focus=True

            #set previous
            previous=window[0]

        if 'nodes' in node:
            process_nodes(node["nodes"], reverse)
        if "floating_nodes" in node:
            process_nodes(node["floating_nodes"], reverse)

def tab(reverse=False):
    filtered_nodes = process_nodes(data.get('nodes', []), reverse)
    if reverse:
        switchTo(last)
    switchTo(first)

def ellipsis(text):
    return "{:.25}".format(text) + '...' if len(text) > 25 else text

def scratchpad():
    stack = [] # Storage for windows
    nodes = data["nodes"][0]["nodes"][0]["floating_nodes"]
    if not nodes:
        exit(0)
    for i in nodes:
        stack.append({
            "name": ellipsis(i["name"].replace("|","-")),
            "id" : i["id"],
            "appId" : i["app_id"],
            "urgent": "   ● " if i["urgent"] else " "*5
        })
    formatted_items = '|'.join([f"{i['urgent']}{i['name']:<30} {'»':<5} {i['appId']}" for i in stack])
    scrollLimit=str(min(25,len(stack)))
    rofi_output = run(['rofi', '-sep', '|', '-dmenu', '-p', 'Scratchpad', '-l', scrollLimit, '-format', 'i'], input=formatted_items, text=True, capture_output=True)    
    selected_index = rofi_output.stdout.strip()
    if selected_index != "":
        switchTo(stack[int(selected_index)]["id"])
 
    
if __name__ == "__main__":
    if len(argv) < 2:
        tab(False)
    if argv[1] == "reverse":
        tab(True)
    elif argv[1] == "scratchpad":
        scratchpad()


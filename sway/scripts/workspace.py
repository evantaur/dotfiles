#!/usr/bin/env python3
import swayipc
import subprocess

def get_workspace_windows(workspace_name):
    sway = swayipc.Connection()
    try:
        workspace = sway.get_workspace(workspace_name).workspace()
        return len(workspace.nodes)
    except swayipc.SwayIPCError:
        return 0

def switch_workspace_handler(event):
    if event.change == "focus":
        workspace_name = event.current.container.workspace().name
        window_count = get_workspace_windows(workspace_name)

        if window_count == 1:
            # Execute your custom script or command here
            subprocess.run(["your_script.sh"])

def main():
    sway = swayipc.Connection()
    sway.on("workspace", switch_workspace_handler)
    sway.main()

if __name__ == "__main__":
    main()

cwlVersion: v1.2
class: CommandLineTool
baseCommand: art_ifconfig
label: art_ifconfig
doc: "Configure a network interface or display information about network interfaces.\n
  \nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: interface
    type:
      - 'null'
      - string
    doc: The name of the network interface (e.g., eth0, bootnet, lo).
    inputBinding:
      position: 1
  - id: address
    type:
      - 'null'
      - string
    doc: The IP address to assign to the interface.
    inputBinding:
      position: 2
  - id: all_interfaces
    type:
      - 'null'
      - boolean
    doc: Display all interfaces which are currently available, even if down.
    inputBinding:
      position: 103
      prefix: -a
  - id: down
    type:
      - 'null'
      - boolean
    doc: Shut down the interface.
    inputBinding:
      position: 103
  - id: mtu
    type:
      - 'null'
      - int
    doc: Set the Maximum Transfer Unit (MTU) of an interface.
    inputBinding:
      position: 103
      prefix: mtu
  - id: netmask
    type:
      - 'null'
      - string
    doc: Set the IP network mask for this interface.
    inputBinding:
      position: 103
      prefix: netmask
  - id: short_list
    type:
      - 'null'
      - boolean
    doc: Display a short list (similar to netstat -i).
    inputBinding:
      position: 103
      prefix: -s
  - id: up
    type:
      - 'null'
      - boolean
    doc: Activate the interface.
    inputBinding:
      position: 103
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be more verbose for some error conditions.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_ifconfig.out

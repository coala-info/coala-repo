cwlVersion: v1.2
class: CommandLineTool
baseCommand: ip
label: art_ip
doc: "Network configuration tool for managing addresses, routes, links, tunnels, neighbors,
  and rules.\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: object
    type: string
    doc: 'The object to manage: address, route, link, tunnel, neigh, or rule'
    inputBinding:
      position: 1
  - id: command
    type:
      - 'null'
      - string
    doc: The action to perform on the object (e.g., add, del, show, list, set)
    inputBinding:
      position: 2
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments specific to the object and command
    inputBinding:
      position: 3
  - id: address
    type:
      - 'null'
      - string
    doc: Set the MAC address of the device
    inputBinding:
      position: 104
      prefix: address
  - id: device
    type:
      - 'null'
      - string
    doc: Specify the network interface device
    inputBinding:
      position: 104
      prefix: dev
  - id: family
    type:
      - 'null'
      - string
    doc: 'Specifies the protocol family: inet, inet6, or link'
    inputBinding:
      position: 104
      prefix: --family
  - id: local
    type:
      - 'null'
      - string
    doc: Local endpoint address
    inputBinding:
      position: 104
      prefix: local
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Tunnel mode: ipip, gre, or sit'
    inputBinding:
      position: 104
      prefix: mode
  - id: mtu
    type:
      - 'null'
      - int
    doc: Set the Maximum Transmission Unit
    inputBinding:
      position: 104
      prefix: mtu
  - id: name
    type:
      - 'null'
      - string
    doc: Set the name of the device
    inputBinding:
      position: 104
      prefix: name
  - id: netns
    type:
      - 'null'
      - int
    doc: Network namespace PID
    inputBinding:
      position: 104
      prefix: netns
  - id: oneline
    type:
      - 'null'
      - boolean
    doc: Output each record on a single line
    inputBinding:
      position: 104
      prefix: --oneline
  - id: qlen
    type:
      - 'null'
      - int
    doc: Set the transmit queue length
    inputBinding:
      position: 104
      prefix: qlen
  - id: remote
    type:
      - 'null'
      - string
    doc: Remote endpoint address
    inputBinding:
      position: 104
      prefix: remote
  - id: ttl
    type:
      - 'null'
      - int
    doc: Time To Live
    inputBinding:
      position: 104
      prefix: ttl
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_ip.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: ifdata
label: moreutils_ifdata
doc: "Get network interface info without parsing ifconfig output.\n\nTool
  homepage: https://github.com/madx/moreutils"
inputs:
  - id: iface
    type: string
    doc: Network interface name, for example lo.
    inputBinding:
      position: 2
  - id: exists
    type:
      - 'null'
      - boolean
    doc: Reports interface existence via return code.
    inputBinding:
      position: 1
      prefix: -e
  - id: print_all
    type:
      - 'null'
      - boolean
    doc: Print out the whole config of iface.
    inputBinding:
      position: 1
      prefix: -p
  - id: print_exists
    type:
      - 'null'
      - boolean
    doc: Print out yes or no according to existence.
    inputBinding:
      position: 1
      prefix: -pe
  - id: print_address
    type:
      - 'null'
      - boolean
    doc: Print out the address.
    inputBinding:
      position: 1
      prefix: -pa
  - id: print_netmask
    type:
      - 'null'
      - boolean
    doc: Print netmask.
    inputBinding:
      position: 1
      prefix: -pn
  - id: print_network
    type:
      - 'null'
      - boolean
    doc: Print network address.
    inputBinding:
      position: 1
      prefix: -pN
  - id: print_broadcast
    type:
      - 'null'
      - boolean
    doc: Print broadcast.
    inputBinding:
      position: 1
      prefix: -pb
  - id: print_mtu
    type:
      - 'null'
      - boolean
    doc: Print mtu.
    inputBinding:
      position: 1
      prefix: -pm
  - id: print_hardware_address
    type:
      - 'null'
      - boolean
    doc: Print out the hardware address.
    inputBinding:
      position: 1
      prefix: -ph
  - id: print_flags
    type:
      - 'null'
      - boolean
    doc: Print flags.
    inputBinding:
      position: 1
      prefix: -pf
  - id: stats_in
    type:
      - 'null'
      - boolean
    doc: Print all statistics on input.
    inputBinding:
      position: 1
      prefix: -si
  - id: stats_out
    type:
      - 'null'
      - boolean
    doc: Print all statistics on output.
    inputBinding:
      position: 1
      prefix: -so
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_ifdata.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: traceroute
label: art_traceroute
doc: "Trace the route to HOST\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: host
    type: string
    doc: Host to trace route to
    inputBinding:
      position: 1
  - id: bytes
    type:
      - 'null'
      - int
    doc: Size of probe packets
    inputBinding:
      position: 2
  - id: bypass_routing
    type:
      - 'null'
      - boolean
    doc: Bypass routing tables, send directly to HOST
    inputBinding:
      position: 103
      prefix: -r
  - id: display_ttl
    type:
      - 'null'
      - boolean
    doc: Display TTL value of the returned packet
    inputBinding:
      position: 103
      prefix: -l
  - id: dont_fragment
    type:
      - 'null'
      - boolean
    doc: Set don't fragment bit
    inputBinding:
      position: 103
      prefix: -F
  - id: first_ttl
    type:
      - 'null'
      - int
    doc: First number of hops
    inputBinding:
      position: 103
      prefix: -f
  - id: icmp
    type:
      - 'null'
      - boolean
    doc: Use ICMP ECHO instead of UDP datagrams
    inputBinding:
      position: 103
      prefix: -I
  - id: interface
    type:
      - 'null'
      - string
    doc: Source interface
    inputBinding:
      position: 103
      prefix: -i
  - id: ipv4
    type:
      - 'null'
      - boolean
    doc: Force IP name resolution
    inputBinding:
      position: 103
      prefix: '-4'
  - id: ipv6
    type:
      - 'null'
      - boolean
    doc: Force IPv6 name resolution
    inputBinding:
      position: 103
      prefix: '-6'
  - id: max_ttl
    type:
      - 'null'
      - int
    doc: Max number of hops
    inputBinding:
      position: 103
      prefix: -m
  - id: numeric
    type:
      - 'null'
      - boolean
    doc: Print numeric addresses
    inputBinding:
      position: 103
      prefix: -n
  - id: pause_msec
    type:
      - 'null'
      - int
    doc: Wait before each send
    inputBinding:
      position: 103
      prefix: -z
  - id: port
    type:
      - 'null'
      - int
    doc: Base UDP port number used in probes
    inputBinding:
      position: 103
      prefix: -p
  - id: probes
    type:
      - 'null'
      - int
    doc: Number of probes per hop
    inputBinding:
      position: 103
      prefix: -q
  - id: source_ip
    type:
      - 'null'
      - string
    doc: Source address
    inputBinding:
      position: 103
      prefix: -s
  - id: tos
    type:
      - 'null'
      - int
    doc: Type-of-service in probe packets
    inputBinding:
      position: 103
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 103
      prefix: -v
  - id: wait_sec
    type:
      - 'null'
      - int
    doc: Wait for a response
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_traceroute.out

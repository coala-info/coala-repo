cwlVersion: v1.2
class: CommandLineTool
baseCommand: ndisasm
label: nasm_ndisasm
doc: "NDISASM - the Netwide Disassembler for x86 binary files.\n\nTool homepage: https://github.com/netwide-assembler/nasm"
inputs:
  - id: file
    type: File
    doc: Binary file to disassemble.
    inputBinding:
      position: 200
  - id: auto_sync
    type:
      - 'null'
      - boolean
    doc: Activate auto (intelligent) sync (-a or -i).
    inputBinding:
      position: 1
      prefix: -a
  - id: bits32
    type:
      - 'null'
      - boolean
    doc: Same as -b 32.
    inputBinding:
      position: 1
      prefix: -u
  - id: bits
    type:
      - 'null'
      - int
    doc: Set the processor mode to 16, 32 or 64 bits.
    inputBinding:
      position: 1
      prefix: -b
  - id: origin
    type:
      - 'null'
      - int
    doc: Set the origin (start address) of the disassembly.
    inputBinding:
      position: 1
      prefix: -o
  - id: sync
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: -s
    doc: Synchronisation points; the disassembler resumes at these offsets.
  - id: skip_header_bytes
    type:
      - 'null'
      - int
    doc: Skip this many bytes of header (-e).
    inputBinding:
      position: 1
      prefix: -e
  - id: skip_region
    type:
      - 'null'
      - string
    doc: Avoid disassembling bytes from a position, given as start,bytes (-k).
    inputBinding:
      position: 1
      prefix: -k
  - id: vendor
    type:
      - 'null'
      - string
    doc: Preferred vendor instruction set (intel, amd, cyrix, idt).
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: disassembly
    type: stdout
    doc: Disassembly listing.
stdout: ndisasm.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasm:2.11.08--0

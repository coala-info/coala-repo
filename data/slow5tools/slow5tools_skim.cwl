cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - skim
label: slow5tools_skim
doc: "Skims through requested components in a SLOW5/BLOW5 file. If no options are
  provided, all the SLOW5 records except the raw signal will be printed.\n\nTool homepage:
  https://github.com/hasindu2008/slow5tools"
inputs:
  - id: slow5_file
    type:
      - 'null'
      - File
    doc: SLOW5/BLOW5 file to skim
    inputBinding:
      position: 1
  - id: batchsize
    type:
      - 'null'
      - int
    doc: number of records loaded to the memory at once
    default: 4096
    inputBinding:
      position: 102
      prefix: --batchsize
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: print the header only
    inputBinding:
      position: 102
      prefix: --hdr
  - id: print_read_ids
    type:
      - 'null'
      - boolean
    doc: print the list of read ids only
    inputBinding:
      position: 102
      prefix: --rid
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 8
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
stdout: slow5tools_skim.out

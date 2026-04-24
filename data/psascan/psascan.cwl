cwlVersion: v1.2
class: CommandLineTool
baseCommand: psascan
label: psascan
doc: "Construct the suffix array for text stored in FILE.\n\nTool homepage: https://www.cs.helsinki.fi/group/pads/pSAscan.html"
inputs:
  - id: input_file
    type: File
    doc: Text file to construct the suffix array for
    inputBinding:
      position: 1
  - id: gap_file
    type:
      - 'null'
      - File
    doc: 'specify the file holding the gap array (default: FILE.sa5.gap)'
    inputBinding:
      position: 102
      prefix: --gap
  - id: mem_limit
    type:
      - 'null'
      - int
    doc: limit RAM usage to LIMIT MiB
    inputBinding:
      position: 102
      prefix: --mem
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print detailed information during internal sufsort
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'specify the output file (default: FILE.sa5)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psascan:0.1.0--h9948957_5

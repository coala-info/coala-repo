cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - fix
label: dr-disco_fix
doc: "Fixes an alignment file by removing duplicate reads.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: input_alignment_file
    type: File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Path in which temp files are stored
    inputBinding:
      position: 102
      prefix: --temp-dir
outputs:
  - id: output_alignment_file
    type: File
    doc: Output alignment file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0

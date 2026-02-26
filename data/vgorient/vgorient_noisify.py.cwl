cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgorient_noisify.py
label: vgorient_noisify.py
doc: "Adds random transformations to FASTA files.\n\nTool homepage: https://github.com/whelixw/vgOrient"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Directory to save transformed files
    inputBinding:
      position: 2
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Whether to apply reverse transformation
    inputBinding:
      position: 103
  - id: transformation_log
    type:
      - 'null'
      - File
    doc: File to log transformations
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
stdout: vgorient_noisify.py.out

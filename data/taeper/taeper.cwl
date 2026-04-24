cwlVersion: v1.2
class: CommandLineTool
baseCommand: taeper
label: taeper
doc: "taeper: a tool for simulating RNA-seq data by tapering existing data.\n\nTool
  homepage: https://github.com/mbhall88/taeper"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ files to be tapered
    inputBinding:
      position: 1
  - id: name
    type:
      - 'null'
      - string
    doc: Name to prepend to the output files
    inputBinding:
      position: 102
      prefix: --name
  - id: scale
    type:
      - 'null'
      - float
    doc: Scale factor for the number of reads to keep
    inputBinding:
      position: 102
      prefix: --scale
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write the tapered files to
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taeper:0.1.0--py36_0

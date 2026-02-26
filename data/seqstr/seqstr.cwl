cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqstr
label: seqstr
doc: "A tool for sequence string manipulation and analysis.\n\nTool homepage: https://github.com/jzhoulab/Seqstr"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: The input sequence string file.
    inputBinding:
      position: 1
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Specify the directory for operations.
    inputBinding:
      position: 102
      prefix: --dir
  - id: download
    type:
      - 'null'
      - string
    doc: Specify what to download (e.g., 'all', 'databases').
    inputBinding:
      position: 102
      prefix: --download
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Specify the output file path.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqstr:0.1.0--pyhdfd78af_0

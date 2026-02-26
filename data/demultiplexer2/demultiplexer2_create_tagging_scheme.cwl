cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - demultiplexer2
  - create_tagging_scheme
label: demultiplexer2_create_tagging_scheme
doc: "Create a tagging scheme for demultiplexing.\n\nTool homepage: https://github.com/DominikBuchner/demultiplexer2"
inputs:
  - id: data_dir
    type: Directory
    doc: Path to the directory that contains the files to demultiplex.
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: name
    type: string
    doc: Define the name for the tagging scheme to create
    inputBinding:
      position: 101
      prefix: --name
  - id: primerset_path
    type: File
    doc: Path to the primerset to be used for demultiplexing.
    inputBinding:
      position: 101
      prefix: --primerset_path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0
stdout: demultiplexer2_create_tagging_scheme.out

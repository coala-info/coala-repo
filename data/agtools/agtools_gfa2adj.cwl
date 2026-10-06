cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - gfa2adj
label: agtools_gfa2adj
doc: "Get adjacency matrix of the assembly graph\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter for adjacency file. Supports a comma and a tab.
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: graph
    type: File
    doc: path to the assembly graph file (only the first --graph is used by 
      this subcommand)
    inputBinding:
      position: 101
      prefix: --graph
  - id: output_path
    type: string
    doc: path to the output folder  [required]
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.output_path, "listing":
          []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0

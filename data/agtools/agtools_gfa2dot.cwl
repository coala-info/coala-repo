cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - gfa2dot
label: agtools_gfa2dot
doc: "Convert GFA file to DOT format (GraphViz)\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
  - id: abyss
    type:
      - 'null'
      - boolean
    doc: use the ABySS DOT format for the output
    inputBinding:
      position: 101
      prefix: --abyss
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

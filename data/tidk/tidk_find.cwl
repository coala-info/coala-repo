cwlVersion: v1.2
class: CommandLineTool
baseCommand: tidk find
label: tidk_find
doc: "Supply the name of a clade your organsim belongs to, and this submodule will
  find all telomeric repeat matches for that clade.\n\nTool homepage: https://github.com/tolkit/telomeric-identifier"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: The input fasta file
    inputBinding:
      position: 1
  - id: clade
    type: string
    doc: The clade of organism to identify telomeres in
    inputBinding:
      position: 102
      prefix: --clade
  - id: log
    type:
      - 'null'
      - boolean
    doc: Output a log file
    inputBinding:
      position: 102
      prefix: --log
  - id: print
    type:
      - 'null'
      - boolean
    doc: Print a table of clades, along with their telomeric sequences
    inputBinding:
      position: 102
      prefix: --print
  - id: window
    type:
      - 'null'
      - int
    doc: Window size to calculate telomeric repeat counts in
    inputBinding:
      position: 102
      prefix: --window
  - id: dir_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `dir_path`
    inputBinding:
      position: 103
      prefix: --dir
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename for the TSVs (without extension)
    outputBinding:
      glob: $(inputs.output_path)
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Output directory to write files to
    outputBinding:
      glob: $(inputs.dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0

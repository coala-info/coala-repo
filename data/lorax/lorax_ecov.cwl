cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorax
  - ecov
label: lorax_ecov
doc: "Edge coverage of a pan-genome graph from graph alignments (GAF).\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: sample_gaf
    type: File
    doc: sample graph alignments in GAF format
    inputBinding:
      position: 1
  - id: graph
    type: File
    doc: GFA pan-genome graph
    inputBinding:
      position: 101
      prefix: --graph
  - id: name
    type:
      - 'null'
      - string
    doc: sample name
    inputBinding:
      position: 101
      prefix: --name
  - id: outfile_path
    type: string
    doc: output statistics
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output statistics
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0

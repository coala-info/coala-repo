cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorax
  - stats
label: lorax_stats
doc: "Basic statistics of a pan-genome graph (GFA).\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: pangenome_gfa
    type: File
    doc: pan-genome graph in GFA format (gzipped or plain)
    inputBinding:
      position: 1
  - id: outfile_path
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0

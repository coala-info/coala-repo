cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorax
  - components
label: lorax_components
doc: "Connected components of a pan-genome graph.\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: pangenome_gfa
    type: File
    doc: pan-genome graph in GFA format (gzipped or plain)
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: output prefix to split graph into components
    inputBinding:
      position: 101
      prefix: --prefix
  - id: outfile_path
    type: string
    doc: output file
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: component_graphs
    type:
      type: array
      items: File
    doc: Graph files written for each component (prefix.comp<N>.gfa)
    outputBinding:
      glob: "$(inputs.prefix ? inputs.prefix + '.comp*.gfa' : 'no_prefix_given_none')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0

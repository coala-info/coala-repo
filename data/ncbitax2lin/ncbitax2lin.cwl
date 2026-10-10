cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbitax2lin
label: ncbitax2lin
doc: "Converts NCBI taxomony dump into lineages.\n\nTool homepage: https://github.com/zyxue/ncbitax2lin"
inputs:
  - id: nodes_file
    type: File
    doc: path/to/taxdump/nodes.dmp from NCBI taxonomy
    inputBinding:
      position: 1
  - id: names_file
    type: File
    doc: path/to/taxdump/names.dmp from NCBI taxonomy
    inputBinding:
      position: 2
  - id: output
    type:
      - 'null'
      - string
    doc: Output file path
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: lineages
    type:
      type: array
      items: File
    doc: Lineage table (csv.gz); named by --output, otherwise the default file written by the tool.
    outputBinding:
      glob: "$(inputs.output ? [inputs.output] : ['ncbi_lineages_*.csv.gz'])"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbitax2lin:3.0.0--pyhdfd78af_0
stdout: ncbitax2lin.out

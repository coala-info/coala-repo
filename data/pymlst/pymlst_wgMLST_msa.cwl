cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - msa
label: pymlst_wgMLST_msa
doc: "Computes Multiple Sequence Alignment from a wgMLST DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the wgMLST database (SQLite file)"
    inputBinding:
      position: 1
  - id: output_path
    type: ['null', string]
    doc: "Output result in fasta format (default:stdout)."
    inputBinding:
      position: 10
      prefix: --output
  - id: file
    type: ['null', File]
    doc: "file containing list of coregenes to extract (default:all coregenes)."
    inputBinding:
      position: 10
      prefix: --file
  - id: realign
    type: ['null', boolean]
    doc: "Realigns genes with same length (Default:No)."
    inputBinding:
      position: 10
      prefix: --realign
outputs:
  - id: output
    type: ['null', File]
    doc: "Alignment written with output_path"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Alignment (when no output file is given)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_msa.out

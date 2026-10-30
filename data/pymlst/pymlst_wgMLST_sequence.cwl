cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - sequence
label: pymlst_wgMLST_sequence
doc: "Extracts sequences from a wgMLST DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
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
    doc: "File containing list of coregenes to extract (default:all coregenes)."
    inputBinding:
      position: 10
      prefix: --file
  - id: reference
    type: ['null', boolean]
    doc: "Return sequence of the reference instead of strains alleles"
    inputBinding:
      position: 10
      prefix: --reference
outputs:
  - id: output
    type: ['null', File]
    doc: "Sequences in fasta format written with output_path"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output (result when no output file is given)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_sequence.out

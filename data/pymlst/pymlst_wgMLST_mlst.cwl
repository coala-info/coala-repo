cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - mlst
label: pymlst_wgMLST_mlst
doc: "Extracts an MLST table from a wgMLST DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the wgMLST database (SQLite file)"
    inputBinding:
      position: 1
  - id: mincover
    type: ['null', int]
    doc: "Minimum number of strains found to retain a gene (default:0)"
    inputBinding:
      position: 10
      prefix: --mincover
  - id: keep
    type: ['null', boolean]
    doc: "Keeps only gene with different alleles (omit missing)."
    inputBinding:
      position: 10
      prefix: --keep
  - id: duplicate
    type: ['null', boolean]
    doc: "Keeps duplicate genes (default remove)."
    inputBinding:
      position: 10
      prefix: --duplicate
  - id: inverse
    type: ['null', boolean]
    doc: "Keeps only gene that do not match the filter of mincover or keep options."
    inputBinding:
      position: 10
      prefix: --inverse
  - id: form
    type: ['null', string]
    doc: "Specify format of output (default|grapetree)"
    inputBinding:
      position: 10
      prefix: --form
  - id: output_path
    type: ['null', string]
    doc: "Export strain list to (default=stdout)."
    inputBinding:
      position: 10
      prefix: --output
outputs:
  - id: output
    type: ['null', File]
    doc: "MLST table written with output_path"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "MLST table (when no output file is given)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_mlst.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - claMLST
  - info
label: pymlst_claMLST_info
doc: "Output the information about  a classical MLST DATABASE\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the claMLST database (SQLite file)"
    inputBinding:
      position: 1
  - id: output_path
    type: ['null', string]
    doc: "Writes ST search result to (default:stdout)."
    inputBinding:
      position: 10
      prefix: --output
outputs:
  - id: output
    type: ['null', File]
    doc: "Database information written with output_path"
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
stdout: pymlst_claMLST_info.out

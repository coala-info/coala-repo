cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crimson
  - star
label: crimson_star
doc: "Converts STAR Log.final.out file.\n\nTool homepage: https://github.com/bow/crimson"
inputs:
  - id: input
    type: File
    doc: Input STAR Log.final.out file. Use "-" for stdin.
    inputBinding:
      position: 1
  - id: input_linesep
    type:
      - 'null'
      - string
    doc: 'Line separator for input files; used when parsing. Default: native value
      for current operating system.'
    inputBinding:
      position: 102
      prefix: --input-linesep
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file. Use "-" for stdout.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crimson:1.1.1--pyh7cba7a3_0

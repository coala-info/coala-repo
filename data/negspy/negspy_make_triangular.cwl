cwlVersion: v1.2
class: CommandLineTool
baseCommand: [make_triangular.py]
label: negspy_make_triangular
doc: "Make sure that the coordinates passed in are triangular: sorts the first two
  columns of each input line so the first is not larger than the second.\n\nTool homepage: https://github.com/pkerpedjiev/negspy"
inputs:
  - id: input_table
    type: File
    doc: Whitespace-separated table whose first two columns are integer coordinates (read on standard input).
outputs:
  - id: stdout
    type: stdout
    doc: Table with triangular coordinates.
stdin: $(inputs.input_table.path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
stdout: negspy_make_triangular.out

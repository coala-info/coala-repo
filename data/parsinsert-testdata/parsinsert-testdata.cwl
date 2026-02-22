cwlVersion: v1.2
class: CommandLineTool
baseCommand: parsinsert-testdata
label: parsinsert-testdata
doc: 'Test data for the Parsinsert tool. (Note: The provided text contains system
  error messages regarding container image retrieval and disk space, rather than functional
  help text.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/parsinsert-testdata:v1.04-4-deb_cv1
stdout: parsinsert-testdata.out

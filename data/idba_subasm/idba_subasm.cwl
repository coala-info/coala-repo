cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba_subasm
label: idba_subasm
doc: "The provided help text contains only system error messages (environment variable
  warnings and a 'no space left on device' fatal error) and does not contain the actual
  usage information or argument descriptions for the tool idba_subasm.\n\nTool homepage:
  https://github.com/abishara/idba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/idba:v1.1.3-3-deb_cv1
stdout: idba_subasm.out

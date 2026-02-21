cwlVersion: v1.2
class: CommandLineTool
baseCommand: clever-core
label: clever-toolkit_clever-core
doc: "The provided text is an error log from a failed container build/execution and
  does not contain help text or usage information for the tool.\n\nTool homepage:
  https://bitbucket.org/tobiasmarschall/clever-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clever-toolkit:2.4--h077b44d_14
stdout: clever-toolkit_clever-core.out

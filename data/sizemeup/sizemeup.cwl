cwlVersion: v1.2
class: CommandLineTool
baseCommand: sizemeup
label: sizemeup
doc: "The provided text does not contain help information or a description for the
  tool; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/rpetit3/sizemeup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sizemeup:1.3.0--pyhdfd78af_0
stdout: sizemeup.out

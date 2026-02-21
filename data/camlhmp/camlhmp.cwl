cwlVersion: v1.2
class: CommandLineTool
baseCommand: camlhmp
label: camlhmp
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains system error logs related to a container build
  failure.\n\nTool homepage: https://github.com/rpetit3/camlhmp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/camlhmp:1.1.3--pyhdfd78af_0
stdout: camlhmp.out

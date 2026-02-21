cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcflib
label: vcflib
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or usage instructions for the tool.\n\nTool homepage:
  https://github.com/vcflib/vcflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib.out

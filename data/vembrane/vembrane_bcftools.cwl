cwlVersion: v1.2
class: CommandLineTool
baseCommand: vembrane
label: vembrane_bcftools
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or argument definitions for the tool.\n\nTool homepage:
  https://github.com/vembrane/vembrane"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
stdout: vembrane_bcftools.out

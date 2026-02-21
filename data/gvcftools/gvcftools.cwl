cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcftools
label: gvcftools
doc: "The provided text is an error log from a container runtime and does not contain
  help documentation or argument definitions for gvcftools.\n\nTool homepage: https://github.com/sequencing/gvcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcftools:0.17.0--pl5.22.0_2
stdout: gvcftools.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRessoCompare
label: crispresso2_CRISPRessoCompare
doc: "The provided text is an error log indicating a failure to build or fetch the
  Singularity/Docker image (no space left on device) and does not contain help text
  or argument definitions for the tool.\n\nTool homepage: https://github.com/pinellolab/CRISPResso2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0
stdout: crispresso2_CRISPRessoCompare.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRessoWGS
label: crispresso2_CRISPRessoWGS
doc: "The provided text does not contain help information for the tool. It contains
  system log messages indicating a failure to build a Singularity container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/pinellolab/CRISPResso2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0
stdout: crispresso2_CRISPRessoWGS.out

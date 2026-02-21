cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop-umi_samtools
label: scallop-umi_samtools
doc: "The provided text contains container runtime logs and a fatal error message
  rather than tool help text. No arguments or descriptions could be extracted.\n\n
  Tool homepage: https://github.com/Shao-Group/scallop-umi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop-umi:1.1.0--hbce0939_0
stdout: scallop-umi_samtools.out

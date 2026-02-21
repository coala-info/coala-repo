cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-demultiplex
label: illumina-utils_iu-demultiplex
doc: "The provided text does not contain help information or usage instructions. It
  is an error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/meren/illumina-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
stdout: illumina-utils_iu-demultiplex.out

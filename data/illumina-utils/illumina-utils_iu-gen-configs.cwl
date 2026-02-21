cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-gen-configs
label: illumina-utils_iu-gen-configs
doc: "Generate configuration files for illumina-utils. (Note: The provided text is
  a system error log indicating a failure to build the container image due to insufficient
  disk space and does not contain the actual help documentation for the tool.)\n\n
  Tool homepage: https://github.com/meren/illumina-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
stdout: illumina-utils_iu-gen-configs.out

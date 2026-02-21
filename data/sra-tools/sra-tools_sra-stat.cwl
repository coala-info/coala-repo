cwlVersion: v1.2
class: CommandLineTool
baseCommand: sra-stat
label: sra-tools_sra-stat
doc: "The provided help text contains a fatal error from the container runtime (Apptainer/Singularity)
  and does not include usage information for the tool.\n\nTool homepage: https://github.com/ncbi/sra-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools_sra-stat.out

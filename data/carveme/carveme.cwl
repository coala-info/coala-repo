cwlVersion: v1.2
class: CommandLineTool
baseCommand: carveme
label: carveme
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/cdanielmachado/carveme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carveme:1.6.6--pyhdfd78af_1
stdout: carveme.out

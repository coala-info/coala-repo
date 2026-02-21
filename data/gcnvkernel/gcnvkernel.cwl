cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcnvkernel
label: gcnvkernel
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  the image due to insufficient disk space.\n\nTool homepage: https://www.broadinstitute.org/gatk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcnvkernel:0.9--pyhdfd78af_0
stdout: gcnvkernel.out

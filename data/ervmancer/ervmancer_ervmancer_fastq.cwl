cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ervmancer
  - fastq
label: ervmancer_ervmancer_fastq
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/AuslanderLab/ervmancer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ervmancer:0.0.4--pyhdfd78af_0
stdout: ervmancer_ervmancer_fastq.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: aliscore
label: aliscore
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  or extract the container image due to lack of disk space.\n\nTool homepage: https://github.com/AithentALiSQA/ALiSCoreSetup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aliscore:v2.0_cv4
stdout: aliscore.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: pavfinder
label: pavfinder
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull or build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/bcgsc/pavfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pavfinder:1.8.5--pyhdfd78af_0
stdout: pavfinder.out

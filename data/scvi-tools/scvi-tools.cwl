cwlVersion: v1.2
class: CommandLineTool
baseCommand: scvi-tools
label: scvi-tools
doc: "The provided text does not contain help information or usage instructions for
  scvi-tools. It is an error log from a container build process (Singularity/Apptainer)
  indicating a 'no space left on device' failure while extracting a Docker image.\n
  \nTool homepage: https://github.com/YosefLab/scvi-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scvi-tools:0.14.5--pyhdfd78af_1
stdout: scvi-tools.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: shovill
label: shovill
doc: "The provided text does not contain help information; it is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to fetch the shovill
  image. No arguments or descriptions could be parsed from this input.\n\nTool homepage:
  https://github.com/tseemann/shovill"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shovill:1.4.2--hdfd78af_0
stdout: shovill.out

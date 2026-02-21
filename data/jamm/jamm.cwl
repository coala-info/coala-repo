cwlVersion: v1.2
class: CommandLineTool
baseCommand: jamm
label: jamm
doc: "The provided text does not contain help information for the tool 'jamm'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull or build the tool's image due to insufficient disk space.\n\nTool homepage:
  https://github.com/mahmoudibrahim/JAMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jamm:1.0.8.0--hdfd78af_1
stdout: jamm.out

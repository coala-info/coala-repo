cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpal
label: kpal
doc: "The provided text does not contain help information for the tool 'kpal'. It
  contains error messages from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/LUMC/kPAL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpal:2.1.1--py27_0
stdout: kpal.out

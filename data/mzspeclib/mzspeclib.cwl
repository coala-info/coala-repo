cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzspeclib
label: mzspeclib
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the mzspeclib image due to insufficient disk space.\n\nTool homepage:
  https://github.com/HUPO-PSI/mzSpecLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
stdout: mzspeclib.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: pprodigal
label: pprodigal
doc: "The provided text does not contain help information or usage instructions for
  pprodigal. It contains error messages related to a container runtime (Apptainer/Singularity)
  failing to fetch the tool's image.\n\nTool homepage: https://github.com/sjaenick/pprodigal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pprodigal:1.0.1--pyhdfd78af_0
stdout: pprodigal.out

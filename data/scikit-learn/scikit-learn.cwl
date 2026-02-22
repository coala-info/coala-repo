cwlVersion: v1.2
class: CommandLineTool
baseCommand: scikit-learn
label: scikit-learn
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: https://github.com/scikit-learn/scikit-learn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scikit-learn:0.20.2
stdout: scikit-learn.out

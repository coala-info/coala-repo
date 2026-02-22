cwlVersion: v1.2
class: CommandLineTool
baseCommand: scikit-image
label: scikit-image
doc: "The provided text does not contain CLI help information. It consists of system
  error messages (Singularity/Apptainer) indicating a failure to pull or build a container
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/scikit-image/scikit-image"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scikit-image:0.24.0
stdout: scikit-image.out

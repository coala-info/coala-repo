cwlVersion: v1.2
class: CommandLineTool
baseCommand: panpasco
label: panpasco
doc: "The provided text does not contain help documentation or usage instructions.
  It consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull or build the image due to insufficient disk space.\n\nTool homepage:
  https://gitlab.com/rki_bioinformatics/panpasco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panpasco:1.0.1--py38r40_0
stdout: panpasco.out

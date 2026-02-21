cwlVersion: v1.2
class: CommandLineTool
baseCommand: monovar
label: monovar
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Singularity/Apptainer) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://bitbucket.org/hamimzafar/monovar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monovar:v0.0.1--py27_0
stdout: monovar.out

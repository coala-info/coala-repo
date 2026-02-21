cwlVersion: v1.2
class: CommandLineTool
baseCommand: pispino
label: pispino
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process (Apptainer/Singularity).\n\nTool homepage:
  https://github.com/hsgweon/pispino"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pispino:1.1--py35_0
stdout: pispino.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: cegroomer
label: cegroomer
doc: The provided text does not contain help information or a description for the
  tool. It appears to be an error log from a container build process (Apptainer/Singularity)
  failing due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracegroomer:0.1.4--pyhdfd78af_0
stdout: cegroomer.out

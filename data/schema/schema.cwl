cwlVersion: v1.2
class: CommandLineTool
baseCommand: schema
label: schema
doc: "The provided text does not contain help information or usage instructions for
  the tool 'schema'. It consists of error messages related to a container runtime
  (Singularity/Apptainer) failing to pull a Docker image due to insufficient disk
  space.\n\nTool homepage: https://github.com/keleshev/schema"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schema:0.7.0--py_0
stdout: schema.out

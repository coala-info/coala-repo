cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncoils
label: ncoils
doc: The provided text is an error log indicating a failure to run the tool via a
  container due to insufficient disk space. No help text or argument information was
  found in the input.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncoils:v2002-7-deb_cv1
stdout: ncoils.out

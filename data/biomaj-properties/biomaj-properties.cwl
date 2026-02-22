cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj-properties
label: biomaj-properties
doc: "BioMAJ properties management tool. (Note: The provided text is a system error
  log indicating a 'no space left on device' failure during container execution and
  does not contain standard help documentation or argument definitions.)"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj-properties:v1.2.3-11-deb_cv1
stdout: biomaj-properties.out

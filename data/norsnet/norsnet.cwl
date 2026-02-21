cwlVersion: v1.2
class: CommandLineTool
baseCommand: norsnet
label: norsnet
doc: 'NorsNet is a tool for predicting non-regular secondary structure (NORS) regions
  in proteins. (Note: The provided text is a container execution error log and does
  not contain CLI usage information.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/norsnet:v1.0.17-4-deb_cv1
stdout: norsnet.out

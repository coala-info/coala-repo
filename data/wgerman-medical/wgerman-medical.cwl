cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgerman-medical
label: wgerman-medical
doc: 'German medical dictionary (Note: The provided text was a container build error
  log and did not contain usage instructions or argument definitions).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/wgerman-medical:v20160103-3-deb_cv1
stdout: wgerman-medical.out

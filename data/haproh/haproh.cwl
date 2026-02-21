cwlVersion: v1.2
class: CommandLineTool
baseCommand: haproh
label: haproh
doc: "The provided text does not contain help information for the tool 'haproh'. It
  contains system log messages and a fatal error regarding container image creation
  (no space left on device).\n\nTool homepage: https://github.com/hringbauer/hapROH"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haproh:0.64--py310h1fe012e_4
stdout: haproh.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: mars_MARS_step2.py
label: mars_MARS_step2.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: https://github.com/maiziex/MARS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mars:1.2.4--pyhdfd78af_0
stdout: mars_MARS_step2.py.out

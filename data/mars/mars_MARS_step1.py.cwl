cwlVersion: v1.2
class: CommandLineTool
baseCommand: mars_MARS_step1.py
label: mars_MARS_step1.py
doc: "MARS (Meta-omics Analysis Resource and Solutions) step 1 script.\n\nTool homepage:
  https://github.com/maiziex/MARS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mars:1.2.4--pyhdfd78af_0
stdout: mars_MARS_step1.py.out

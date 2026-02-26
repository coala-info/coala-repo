cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nf-test
  - generate
label: nf-test_generate
doc: "Generate nf-test code for different components.\n\nTool homepage: https://code.askimed.com/nf-test/"
inputs:
  - id: command
    type: string
    doc: The type of component to generate (function, pipeline, process, 
      workflow)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
stdout: nf-test_generate.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-test
label: nf-test
doc: "A simple-to-use testing framework for Nextflow pipelines. (Note: The provided
  text appears to be a container runtime error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: https://code.askimed.com/nf-test/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-test:0.9.3--h2a3209d_0
stdout: nf-test.out

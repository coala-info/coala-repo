cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaplatanus
label: metaplatanus
doc: "MetaPlatanus is a metagenome assembler. (Note: The provided text is a container
  execution error log and does not contain CLI help information.)\n\nTool homepage:
  https://github.com/rkajitani/metaplatanus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplatanus:1.3.1--h6a68c12_1
stdout: metaplatanus.out

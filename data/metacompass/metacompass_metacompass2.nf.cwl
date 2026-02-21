cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacompass2.nf
label: metacompass_metacompass2.nf
doc: "A tool for metagenomic assembly and analysis (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/marbl/MetaCompass"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacompass:1.12--h9948957_0
stdout: metacompass_metacompass2.nf.out

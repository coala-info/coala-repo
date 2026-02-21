cwlVersion: v1.2
class: CommandLineTool
baseCommand: jccirc_CircSimu.pl
label: jccirc_CircSimu.pl
doc: "A tool for circular RNA simulation (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/cbbzhang/JCcirc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jccirc:1.0.0--hdfd78af_1
stdout: jccirc_CircSimu.pl.out

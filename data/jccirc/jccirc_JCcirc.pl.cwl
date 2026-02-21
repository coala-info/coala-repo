cwlVersion: v1.2
class: CommandLineTool
baseCommand: jccirc_JCcirc.pl
label: jccirc_JCcirc.pl
doc: "A tool for Junction-based Circular RNA detection (Note: The provided text contains
  container runtime error messages rather than the tool's help documentation).\n\n
  Tool homepage: https://github.com/cbbzhang/JCcirc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jccirc:1.0.0--hdfd78af_1
stdout: jccirc_JCcirc.pl.out

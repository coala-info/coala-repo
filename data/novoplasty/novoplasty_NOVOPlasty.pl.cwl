cwlVersion: v1.2
class: CommandLineTool
baseCommand: NOVOPlasty.pl
label: novoplasty_NOVOPlasty.pl
doc: "NOVOPlasty is a de novo assembler for organelle genomes. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list command-line arguments.)\n\nTool homepage: https://github.com/ndierckx/NOVOPlasty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoplasty:4.3.5--pl5321hdfd78af_0
stdout: novoplasty_NOVOPlasty.pl.out

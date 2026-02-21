cwlVersion: v1.2
class: CommandLineTool
baseCommand: NOVOPlasty4.3.5.pl
label: novoplasty_NOVOPlasty4.3.5.pl
doc: "NOVOPlasty is a de novo assembler for organelle genomes (mitochondria and chloroplasts).
  It reads a configuration file to perform the assembly.\n\nTool homepage: https://github.com/ndierckx/NOVOPlasty"
inputs:
  - id: config_file
    type: File
    doc: Path to the configuration file containing all assembly parameters.
    inputBinding:
      position: 101
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoplasty:4.3.5--pl5321hdfd78af_0
stdout: novoplasty_NOVOPlasty4.3.5.pl.out

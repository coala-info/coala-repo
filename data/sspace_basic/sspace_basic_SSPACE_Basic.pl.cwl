cwlVersion: v1.2
class: CommandLineTool
baseCommand: SSPACE_Basic.pl
label: sspace_basic_SSPACE_Basic.pl
doc: "SSPACE (Scaffolding Pre-Assembled Contigs after Extension) is a script for scaffolding
  pre-assembled contigs using paired-read data.\n\nTool homepage: https://github.com/nsoranzo/sspace_basic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sspace:v2.1.1dfsg-4-deb_cv1
stdout: sspace_basic_SSPACE_Basic.pl.out

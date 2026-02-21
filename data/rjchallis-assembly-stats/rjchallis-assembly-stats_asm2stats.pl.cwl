cwlVersion: v1.2
class: CommandLineTool
baseCommand: asm2stats.pl
label: rjchallis-assembly-stats_asm2stats.pl
doc: "A tool for calculating assembly statistics (Note: The provided text is an error
  log and does not contain help information).\n\nTool homepage: https://github.com/rjchallis/assembly-stats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rjchallis-assembly-stats:17.02--hdfd78af_0
stdout: rjchallis-assembly-stats_asm2stats.pl.out

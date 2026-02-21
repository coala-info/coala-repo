cwlVersion: v1.2
class: CommandLineTool
baseCommand: rjchallis-assembly-stats_asm2stats.minmaxgc.pl
label: rjchallis-assembly-stats_asm2stats.minmaxgc.pl
doc: "A script for calculating assembly statistics including minimum, maximum, and
  GC content. Note: The provided help text contains a fatal error from the container
  runtime and does not list specific usage instructions or arguments.\n\nTool homepage:
  https://github.com/rjchallis/assembly-stats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rjchallis-assembly-stats:17.02--hdfd78af_0
stdout: rjchallis-assembly-stats_asm2stats.minmaxgc.pl.out

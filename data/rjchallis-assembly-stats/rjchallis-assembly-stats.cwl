cwlVersion: v1.2
class: CommandLineTool
baseCommand: assembly-stats
label: rjchallis-assembly-stats
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a failed container build/fetch operation.\n
  \nTool homepage: https://github.com/rjchallis/assembly-stats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rjchallis-assembly-stats:17.02--hdfd78af_0
stdout: rjchallis-assembly-stats.out

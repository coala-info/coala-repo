cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-web_tsv2bam
label: stacks-web_tsv2bam
doc: "The provided text does not contain help or usage information. It consists of
  system logs and a fatal error message regarding a container image build failure.\n
  \nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_tsv2bam.out

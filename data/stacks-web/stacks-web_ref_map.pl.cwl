cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-web_ref_map.pl
label: stacks-web_ref_map.pl
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error related to a container image build failure.\n\nTool
  homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_ref_map.pl.out

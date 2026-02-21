cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-web_denovo_map.pl
label: stacks-web_denovo_map.pl
doc: "The provided text does not contain help documentation for the tool; it contains
  container runtime logs and a fatal error message regarding the OCI image build process.\n
  \nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_denovo_map.pl.out

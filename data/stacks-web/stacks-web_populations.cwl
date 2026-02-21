cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-web_populations
label: stacks-web_populations
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message regarding an OCI image build failure.\n
  \nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_populations.out

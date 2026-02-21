cwlVersion: v1.2
class: CommandLineTool
baseCommand: clone_filter
label: stacks-web_clone_filter
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build/execution. No arguments could be extracted.\n\nTool
  homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_clone_filter.out

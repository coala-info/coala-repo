cwlVersion: v1.2
class: CommandLineTool
baseCommand: biodigest
label: biodigest
doc: "The provided text contains system error messages and logs related to a container
  execution failure rather than the tool's help documentation. Consequently, no command-line
  arguments or descriptions could be extracted.\n\nTool homepage: http://pypi.python.org/pypi/biodigest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biodigest:0.2.16--pyhdfd78af_2
stdout: biodigest.out

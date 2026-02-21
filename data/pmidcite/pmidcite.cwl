cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmidcite
label: pmidcite
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs. No arguments could be extracted.\n
  \nTool homepage: http://github.com/dvklopfenstein/pmidcite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmidcite:0.3.1--pyhdfd78af_0
stdout: pmidcite.out

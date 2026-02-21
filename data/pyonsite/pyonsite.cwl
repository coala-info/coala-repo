cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyonsite
label: pyonsite
doc: "The provided text does not contain help information or usage instructions for
  pyonsite; it contains system logs regarding a container build failure.\n\nTool homepage:
  https://www.github.com/bigbio/onsite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
stdout: pyonsite.out

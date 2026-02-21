cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyonsite
  - onsite
label: pyonsite_onsite
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or fetch operation.\n\nTool homepage: https://www.github.com/bigbio/onsite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
stdout: pyonsite_onsite.out

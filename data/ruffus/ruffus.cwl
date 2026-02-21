cwlVersion: v1.2
class: CommandLineTool
baseCommand: ruffus
label: ruffus
doc: "Ruffus is a Python library for computational pipelines. (Note: The provided
  text appears to be a container build log rather than CLI help text; no arguments
  could be extracted from the input.)\n\nTool homepage: http://www.ruffus.org.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ruffus:2.8.4--pyh864c0ab_1
stdout: ruffus.out

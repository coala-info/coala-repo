cwlVersion: v1.2
class: CommandLineTool
baseCommand: openduck_frag_duck
label: openduck_frag_duck
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/galaxycomputationalchemistry/duck"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openduck:0.1.2--py_0
stdout: openduck_frag_duck.out

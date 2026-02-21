cwlVersion: v1.2
class: CommandLineTool
baseCommand: CassiopeeKnife
label: cassiopee_CassiopeeKnife
doc: "The provided help text contains system log messages indicating a failure to
  build or run the container (no space left on device) and does not contain usage
  information or argument definitions.\n\nTool homepage: https://github.com/osallou/cassiopee-c"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cassiopee:v1.0.9-2-deb_cv1
stdout: cassiopee_CassiopeeKnife.out

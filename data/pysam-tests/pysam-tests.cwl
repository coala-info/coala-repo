cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysam-tests
label: pysam-tests
doc: "A suite of tests for the pysam library. Note: The provided text appears to be
  a container engine log rather than help text, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/pysam-developers/pysam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pysam-tests:v0.15.2ds-2-deb-py2_cv1
stdout: pysam-tests.out

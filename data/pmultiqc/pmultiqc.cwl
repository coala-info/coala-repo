cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmultiqc
label: pmultiqc
doc: "A tool for running MultiQC in parallel. (Note: The provided help text contains
  only container runtime error logs and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/bigbio/pmultiqc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmultiqc:0.0.40--pyhdfd78af_0
stdout: pmultiqc.out

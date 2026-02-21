cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobambam
label: biobambam
doc: "The provided text is a system error log indicating a failure to build or extract
  a container image due to insufficient disk space ('no space left on device'). It
  does not contain CLI help information or argument definitions for the biobambam
  tool.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam.out

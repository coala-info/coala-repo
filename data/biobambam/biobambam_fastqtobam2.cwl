cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqtobam2
label: biobambam_fastqtobam2
doc: "The provided text is an error log indicating a container build failure (no space
  left on device) and does not contain help information or argument definitions for
  the tool.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_fastqtobam2.out

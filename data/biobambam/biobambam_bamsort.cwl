cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsort
label: biobambam_bamsort
doc: "The provided text is a system error log regarding a container build failure
  (no space left on device) and does not contain the help documentation for biobambam_bamsort.
  Consequently, no arguments could be extracted.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bamsort.out

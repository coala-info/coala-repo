cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamadapterhistogram
label: biobambam_bamadapterhistogram
doc: "A tool from the biobambam suite (description not available in the provided text
  due to execution error).\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bamadapterhistogram.out

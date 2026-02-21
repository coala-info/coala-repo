cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair3-illumina
label: clair3-illumina
doc: "Clair3 is a small variant caller for long-reads. This specific version is optimized
  for Illumina data.\n\nTool homepage: https://github.com/HKU-BAL/Clair3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3-illumina:1.2.0--h2987a09_0
stdout: clair3-illumina.out

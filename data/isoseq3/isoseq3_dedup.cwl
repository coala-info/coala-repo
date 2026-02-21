cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq3
  - dedup
label: isoseq3_dedup
doc: "Deduplicate PCR duplicates from Iso-Seq reads\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
stdout: isoseq3_dedup.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_bio
label: haystack_bio
doc: "A software package for integrative analysis of epigenomic data, including modules
  for motif analysis and epigenetic track comparison.\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio.out

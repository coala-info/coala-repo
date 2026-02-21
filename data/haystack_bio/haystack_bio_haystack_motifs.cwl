cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_motifs
label: haystack_bio_haystack_motifs
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_motifs.out

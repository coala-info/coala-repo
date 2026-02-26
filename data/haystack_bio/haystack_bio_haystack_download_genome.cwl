cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_download_genome
label: haystack_bio_haystack_download_genome
doc: "download_genome parameters\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs:
  - id: name
    type: string
    doc: 'genome name. Example: haystack_download_genome hg19.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_download_genome.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_download_genome
label: haystack_bio_haystack_download_genome
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_download_genome.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: genome-uploader
label: genome-uploader_genome_uploader
doc: "A tool for uploading genome data (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/EBI-Metagenomics/genome_uploader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genome-uploader:2.5.1--pyhdfd78af_1
stdout: genome-uploader_genome_uploader.out

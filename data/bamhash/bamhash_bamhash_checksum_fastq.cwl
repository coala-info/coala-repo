cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamhash_checksum_fastq
label: bamhash_bamhash_checksum_fastq
doc: "The provided help text contains only system error messages related to a container
  build failure (No space left on device) and does not include usage information or
  argument descriptions for the tool.\n\nTool homepage: https://github.com/DecodeGenetics/BamHash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
stdout: bamhash_bamhash_checksum_fastq.out

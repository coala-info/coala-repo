cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamhash_checksum_bam
label: bamhash_bamhash_checksum_bam
doc: "A tool for calculating checksums for BAM files. (Note: The provided help text
  contains system error logs rather than usage instructions; no arguments could be
  extracted from the source text.)\n\nTool homepage: https://github.com/DecodeGenetics/BamHash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
stdout: bamhash_bamhash_checksum_bam.out

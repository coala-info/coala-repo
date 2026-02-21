cwlVersion: v1.2
class: CommandLineTool
baseCommand: variants
label: flair_variants
doc: "FLAIR variants module for calling variants from isoform data.\n\nTool homepage:
  https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: bedisoforms
    type:
      - 'null'
      - File
    doc: path to transcriptome bed file
    inputBinding:
      position: 101
      prefix: --bedisoforms
  - id: genome
    type: File
    doc: FastA of reference genome
    inputBinding:
      position: 101
      prefix: --genome
  - id: gtf
    type: File
    doc: GTF annotation file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: isoforms
    type:
      - 'null'
      - File
    doc: path to transcriptome fasta file
    inputBinding:
      position: 101
      prefix: --isoforms
  - id: manifest
    type: File
    doc: path to manifest files that points to sample names + bam files aligned to
      transcriptome. Each line of file should be tab separated.
    inputBinding:
      position: 101
      prefix: --manifest
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: "path to collapsed_output.bed file. default: 'flair'"
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0

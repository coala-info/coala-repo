cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiny-count
label: tiny-count
doc: "A small utility for counting reads in BAM files against genomic features defined
  in a GTF file.\n\nTool homepage: https://github.com/MontgomeryLab/tinyRNA"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file containing alignments
    inputBinding:
      position: 1
  - id: gtf_file
    type: File
    doc: Input GTF file containing genomic features
    inputBinding:
      position: 2
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for a read to be counted
    default: 10
    inputBinding:
      position: 103
      prefix: --min-qual
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Specify if the data is paired-end
    inputBinding:
      position: 103
      prefix: --paired
  - id: strand
    type:
      - 'null'
      - int
    doc: 'Strand specificity: 0 (unstranded), 1 (stranded), 2 (reversely stranded)'
    default: 0
    inputBinding:
      position: 103
      prefix: --strand
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file to write counts to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiny-count:1.5.0--py39h9948957_2

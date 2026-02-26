cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - split
label: alfred_split
doc: "Split unphased BAM files into haplotype-specific BAM files using phased variants.\n\
  \nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: unphased_bam
    type: File
    doc: Input unphased BAM file
    inputBinding:
      position: 1
  - id: assign
    type:
      - 'null'
      - boolean
    doc: assign unphased reads randomly
    inputBinding:
      position: 102
      prefix: --assign
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: single haplotype-tagged BAM
    inputBinding:
      position: 102
      prefix: --interleaved
  - id: map_qual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    default: 10
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: reference
    type: File
    doc: reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
  - id: sample
    type: string
    doc: sample name (as in BCF)
    default: NA12878
    inputBinding:
      position: 102
      prefix: --sample
  - id: vcffile
    type: File
    doc: input phased VCF/BCF file
    inputBinding:
      position: 102
      prefix: --vcffile
outputs:
  - id: hap1
    type:
      - 'null'
      - File
    doc: haplotype1 output file
    outputBinding:
      glob: $(inputs.hap1)
  - id: hap2
    type:
      - 'null'
      - File
    doc: haplotype2 output file
    outputBinding:
      glob: $(inputs.hap2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0

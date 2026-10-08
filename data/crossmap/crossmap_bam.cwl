cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - bam
label: crossmap_bam
doc: "CrossMap converts genome coordinates of alignments in BAM, CRAM or SAM format between assemblies. The input file type is detected from the suffix (.bam, .cram, .sam).\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Input BAM file (https://genome.ucsc.edu/FAQ/FAQformat.html#format5.1). The
      file name must end with .bam, .cram or .sam.
    inputBinding:
      position: 2
  - id: out_bam
    type: string
    default: output
    doc: Prefix of the output alignment file. CrossMap writes <prefix>.bam (or <prefix>.sam
      for SAM input) and, for BAM output, a sorted and indexed <prefix>.sorted.bam.
      If the argument is missing, CrossMap writes to STDOUT.
    inputBinding:
      position: 3
  - id: insert_size
    type:
      - 'null'
      - float
    doc: Average insert size of pair-end sequencing (bp).
    inputBinding:
      position: 104
      prefix: --mean
  - id: insert_size_stdev
    type:
      - 'null'
      - float
    doc: Standard deviation of insert size.
    inputBinding:
      position: 104
      prefix: --stdev
  - id: insert_size_fold
    type:
      - 'null'
      - float
    doc: A mapped pair is considered as "proper pair" if both ends mapped to different
      strand and the distance between them is less then '-t' * stdev from the mean.
    inputBinding:
      position: 104
      prefix: --times
  - id: append_tags
    type:
      - 'null'
      - boolean
    doc: Add tag to each alignment in BAM file (QF, NN, NU, NM, UN, UU, UM, MN, MU, MM
      for pair-end; QF, SN, SM, SU for single-end alignments).
    inputBinding:
      position: 104
      prefix: --append-tags
  - id: chromid
    type:
      - 'null'
      - type: enum
        symbols:
          - a
          - s
          - l
          - n
    doc: 'The style of the output chromosome IDs. "a" = "as-is", "l" = "long style",
      "s" = "short style", and "n" = "no-change".'
    inputBinding:
      position: 104
      prefix: --chromid
outputs:
  - id: output_alignments
    type: File
    doc: Lifted-over alignments (<prefix>.bam or <prefix>.sam).
    outputBinding:
      glob:
        - $(inputs.out_bam).bam
        - $(inputs.out_bam).sam
  - id: sorted_bam
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: Coordinate-sorted and indexed lifted-over BAM file.
    outputBinding:
      glob: $(inputs.out_bam).sorted.bam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0

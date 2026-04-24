cwlVersion: v1.2
class: CommandLineTool
baseCommand: pTrimmer
label: ptrimmer
doc: "pTrimmer is a tool for trimming primer sequences from sequencing data.\n\nTool
  homepage: https://github.com/DMU-lilab/pTrimmer"
inputs:
  - id: ampfile
    type: File
    doc: input amplicon file [.txt]
    inputBinding:
      position: 101
      prefix: --ampfile
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: output trimmed fastq file in Gzip format
    inputBinding:
      position: 101
      prefix: --gzip
  - id: info
    type:
      - 'null'
      - boolean
    doc: add the primer information for each trimmed read
    inputBinding:
      position: 101
      prefix: --info
  - id: keep
    type:
      - 'null'
      - boolean
    doc: 'keep the complete reads if failed to locate primer sequence [default: discard
      the reads]'
    inputBinding:
      position: 101
      prefix: --keep
  - id: kmer
    type:
      - 'null'
      - int
    doc: the kmer length for indexing
    inputBinding:
      position: 101
      prefix: --kmer
  - id: minqual
    type:
      - 'null'
      - int
    doc: the minimum average quality to keep after trimming
    inputBinding:
      position: 101
      prefix: --minqual
  - id: mismatch
    type:
      - 'null'
      - int
    doc: the maximum mismatch for primer seq
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: read1
    type: File
    doc: read1(forward) for fastq file [.fq|.gz]
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: read2(reverse) for fastq file (paired-end seqtype) [.fq|.gz]
    inputBinding:
      position: 101
      prefix: --read2
  - id: seqtype
    type: string
    doc: the sequencing type [single|pair]
    inputBinding:
      position: 101
      prefix: --seqtype
outputs:
  - id: trim1
    type: File
    doc: the trimmed read1 of fastq file
    outputBinding:
      glob: $(inputs.trim1)
  - id: trim2
    type:
      - 'null'
      - File
    doc: the trimmed read2 of fastq file (paired-end seqtype)
    outputBinding:
      glob: $(inputs.trim2)
  - id: summary
    type:
      - 'null'
      - File
    doc: the trimming information of each amplicon
    outputBinding:
      glob: $(inputs.summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptrimmer:1.4.0--h96c455f_1

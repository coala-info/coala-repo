cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-qa
label: htseq_htseq-qa
doc: "This script takes a file with high-throughput sequencing reads and performs
  a simple quality assessment by producing plots showing the distribution of called
  bases and base-call quality scores by position within the reads. The plots are output
  as a PDF file.\n\nTool homepage: https://github.com/htseq/htseq"
inputs:
  - id: read_file_name
    type: File
    doc: The file to count reads in (SAM/BAM or Fastq)
    inputBinding:
      position: 1
  - id: gamma
    type:
      - 'null'
      - float
    doc: the gamma factor for the contrast adjustment of the quality score plot
    inputBinding:
      position: 102
      prefix: --gamma
  - id: max_qual
    type:
      - 'null'
      - int
    doc: the maximum quality score that appears in the data
    default: 41
    inputBinding:
      position: 102
      prefix: --maxqual
  - id: max_records
    type:
      - 'null'
      - int
    doc: Limit the analysis to the first N reads/alignments.
    inputBinding:
      position: 102
      prefix: --max-records
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: do not split reads in unaligned and aligned ones
    inputBinding:
      position: 102
      prefix: --nosplit
  - id: primary_only
    type:
      - 'null'
      - boolean
    doc: For SAM/BAM input files, ignore alignments that are not primary. This 
      only affects 'multimapper' reads that align to several regions in the 
      genome. By choosing this option, each read will only count as one; without
      this option, each of its alignments counts as one.
    inputBinding:
      position: 102
      prefix: --primary-only
  - id: read_length
    type:
      - 'null'
      - int
    doc: the maximum read length (when not specified, the script guesses from 
      the file)
    inputBinding:
      position: 102
      prefix: --readlength
  - id: type
    type:
      - 'null'
      - string
    doc: 'type of read_file (one of: sam [default], bam, solexa-export, fastq, solexa-fastq)'
    default: sam
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output filename (default is <read_file>.pdf)
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq:2.1.2--py311hb6b0eea_0

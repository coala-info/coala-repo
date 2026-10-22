cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualityScores
label: subread_qualityScores
doc: "Retrieve Phred scores for read bases.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: input_file
    type: File
    doc: Name of input file including read data. The default format is FASTQ.
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type: string
    doc: Name of output text file including Phred scores for each read base.
    inputBinding:
      position: 1
      prefix: -o
  - id: gz_fastq_input
    type:
      - 'null'
      - boolean
    doc: Input file is in gzipped FASTQ format.
    inputBinding:
      position: 1
      prefix: --gzFASTQinput
  - id: bam_input
    type:
      - 'null'
      - boolean
    doc: Input file is in BAM format.
    inputBinding:
      position: 1
      prefix: --BAMinput
  - id: sam_input
    type:
      - 'null'
      - boolean
    doc: Input file is in SAM format.
    inputBinding:
      position: 1
      prefix: --SAMinput
  - id: first_end
    type:
      - 'null'
      - boolean
    doc: Use only first reads in paired-end BAM/SAM data.
    inputBinding:
      position: 1
      prefix: --first-end
  - id: second_end
    type:
      - 'null'
      - boolean
    doc: Use only second reads in paired-end BAM/SAM data.
    inputBinding:
      position: 1
      prefix: --second-end
  - id: counted_reads
    type:
      - 'null'
      - int
    doc: "Total number of reads to be extracted from the input file. 10,000 by default."
    inputBinding:
      position: 1
      prefix: --counted-reads
  - id: phred_offset
    type:
      - 'null'
      - int
    doc: "Phred offset, 33 or 64."
    inputBinding:
      position: 1
      prefix: --phred-offset
outputs:
  - id: scores
    type: File
    doc: Phred scores for each read base
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0

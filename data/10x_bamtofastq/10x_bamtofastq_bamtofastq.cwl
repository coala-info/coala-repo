cwlVersion: v1.2
class: CommandLineTool
baseCommand: 10x_bamtofastq_bamtofastq
label: 10x_bamtofastq_bamtofastq
doc: "10x Genomics BAM to FASTQ converter. Tool for converting 10x BAMs produced by
  Cell Ranger or Long Ranger back to FASTQ files that can be used as inputs to re-run
  analysis. The FASTQs will be emitted into a directory structure that is compatible
  with the directories created by the 'mkfastq' tool.\n\nTool homepage: https://github.com/10XGenomics/bamtofastq"
inputs:
  - id: bam
    type: File
    doc: Input 10x BAM file produced by Cell Ranger or Long Ranger
    inputBinding:
      position: 1
  - id: bx_list
    type:
      - 'null'
      - File
    doc: Only include BX values listed in text file L. Requires BX-sorted and index
      BAM file.
    inputBinding:
      position: 102
      prefix: --bx-list
  - id: cr11
    type:
      - 'null'
      - boolean
    doc: Convert a BAM produced by Cell Ranger 1.0-1.1
    inputBinding:
      position: 102
      prefix: --cr11
  - id: gemcode
    type:
      - 'null'
      - boolean
    doc: Convert a BAM produced from GemCode data (Longranger 1.0 - 1.3)
    inputBinding:
      position: 102
      prefix: --gemcode
  - id: locus
    type:
      - 'null'
      - string
    doc: Optional. Only include read pairs mapping to locus. Use chrom:start-end format.
    inputBinding:
      position: 102
      prefix: --locus
  - id: lr20
    type:
      - 'null'
      - boolean
    doc: Convert a BAM produced by Longranger 2.0
    inputBinding:
      position: 102
      prefix: --lr20
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Threads to use for reading BAM file
    default: 4
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: reads_per_fastq
    type:
      - 'null'
      - int
    doc: Number of reads per FASTQ chunk
    default: 50000000
    inputBinding:
      position: 102
      prefix: --reads-per-fastq
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: Skip unpaired or duplicated reads instead of throwing an error.
    inputBinding:
      position: 102
      prefix: --relaxed
  - id: traceback
    type:
      - 'null'
      - boolean
    doc: Print full traceback if an error occurs.
    inputBinding:
      position: 102
      prefix: --traceback
outputs:
  - id: output_path
    type: Directory
    doc: Output directory for the FASTQ files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/10x_bamtofastq:1.4.1--h3ab6199_4

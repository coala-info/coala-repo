cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoquant.py
label: isoquant_isoquant.py
doc: "IsoQuant is a tool for quantifying isoforms from long-read sequencing data.\n\
  \nTool homepage: https://github.com/ablab/IsoQuant"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: sorted and indexed BAM file(s), each file will be treated as a separate
      sample
    inputBinding:
      position: 101
      prefix: --bam
  - id: check_canonical
    type:
      - 'null'
      - boolean
    doc: report whether splice junctions are canonical
    inputBinding:
      position: 101
      prefix: --check_canonical
  - id: complete_genedb
    type:
      - 'null'
      - boolean
    doc: use this flag if gene annotation contains transcript and gene 
      metafeatures, e.g. with official annotations, such as GENCODE; speeds up 
      gene database conversion
    inputBinding:
      position: 101
      prefix: --complete_genedb
  - id: count_exons
    type:
      - 'null'
      - boolean
    doc: perform exon and intron counting
    inputBinding:
      position: 101
      prefix: --count_exons
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'type of data to process, supported types are: pacbio_ccs, pacbio, nanopore,
      ont, assembly, transcripts'
    inputBinding:
      position: 101
      prefix: --data_type
  - id: fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: input FASTQ/FASTA file(s) with reads, each file will be treated as a 
      separate sample; reference genome should be provided when using reads as 
      input
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fl_data
    type:
      - 'null'
      - boolean
    doc: reads represent FL transcripts; both ends of the read are considered to
      be reliable
    inputBinding:
      position: 101
      prefix: --fl_data
  - id: force
    type:
      - 'null'
      - boolean
    doc: force to overwrite the previous run
    inputBinding:
      position: 101
      prefix: --force
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: show full list of options
    inputBinding:
      position: 101
      prefix: --full_help
  - id: genedb
    type:
      - 'null'
      - File
    doc: gene database in gffutils DB format or GTF/GFF format (optional)
    inputBinding:
      position: 101
      prefix: --genedb
  - id: illumina_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: sorted and indexed file(s) with Illumina reads from the same sample
    inputBinding:
      position: 101
      prefix: --illumina_bam
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: sample/replica labels to be used as column names; input file names are 
      used if not set; must be equal to the number of input files given via 
      --fastq/--bam
    inputBinding:
      position: 101
      prefix: --labels
  - id: polya_trimmed
    type:
      - 'null'
      - string
    doc: define reads which had polyA tail trimmed
    inputBinding:
      position: 101
      prefix: --polya_trimmed
  - id: prefix
    type:
      - 'null'
      - string
    doc: experiment name; to be used for folder and file naming; default is OUT
    default: OUT
    inputBinding:
      position: 101
      prefix: --prefix
  - id: read_group
    type:
      - 'null'
      - string
    doc: 'a way to group feature counts (no grouping by default): by BAM file tag
      (tag:TAG); using additional file (file:FILE:READ_COL:GROUP_COL:DELIM); using
      read id (read_id:DELIM); by original file name (file_name)'
    inputBinding:
      position: 101
      prefix: --read_group
  - id: reference
    type:
      - 'null'
      - File
    doc: reference genome in FASTA format (can be gzipped)
    inputBinding:
      position: 101
      prefix: --reference
  - id: resume
    type:
      - 'null'
      - boolean
    doc: resume failed run, specify output folder, input options are not allowed
    inputBinding:
      position: 101
      prefix: --resume
  - id: sqanti_output
    type:
      - 'null'
      - boolean
    doc: produce SQANTI-like TSV output
    inputBinding:
      position: 101
      prefix: --sqanti_output
  - id: stranded
    type:
      - 'null'
      - string
    doc: 'reads strandness type, supported values are: forward, reverse, none'
    inputBinding:
      position: 101
      prefix: --stranded
  - id: test
    type:
      - 'null'
      - boolean
    doc: run IsoQuant on toy dataset
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: unmapped_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: unmapped BAM file(s), each file will be treated as a separate sample
    inputBinding:
      position: 101
      prefix: --unmapped_bam
  - id: yaml
    type:
      - 'null'
      - File
    doc: yaml file containing all input files, one entry per sample, check 
      readme for format info
    inputBinding:
      position: 101
      prefix: --yaml
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: output folder, will be created automatically
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoquant:3.10.0--hdfd78af_0

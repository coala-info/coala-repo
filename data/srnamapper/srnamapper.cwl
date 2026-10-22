cwlVersion: v1.2
class: CommandLineTool
baseCommand: srnaMapper
label: srnamapper
doc: "Map small RNA reads (FASTQ) to a reference genome indexed with bwa, with a 
  user-defined number of errors, and write SAM files.\n\nTool homepage: https://github.com/mzytnicki/srnaMapper"
inputs:
  - id: reads
    type:
      type: array
      items: File
      inputBinding:
        prefix: -r
    doc: Input read files in FASTQ format (one -r per input file)
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: Genome FASTA file; its bwa index files (.amb, .ann, .bwt, .pac, .sa) 
      must sit beside it (prefix of the genome database produced by bwa index)
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    inputBinding:
      position: 2
      prefix: -g
  - id: output_files
    type:
      type: array
      items: string
      inputBinding:
        prefix: -o
    doc: Output files in SAM format (one -o per input file, or a single file with 
      --unique)
    inputBinding:
      position: 3
  - id: max_errors
    type:
      - 'null'
      - int
    doc: Maximum number of errors (default 2)
    inputBinding:
      position: 4
      prefix: -e
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 1)
    inputBinding:
      position: 4
      prefix: -t
  - id: max_hits
    type:
      - 'null'
      - int
    doc: Discard reads when they map more than n times (default 5)
    inputBinding:
      position: 4
      prefix: -n
  - id: low_complexity
    type:
      - 'null'
      - int
    doc: Low complexity threshold, more is more lenient (default 6)
    inputBinding:
      position: 4
      prefix: -f
  - id: unique_sam
    type:
      - 'null'
      - boolean
    doc: Print all the mapped reads in a unique SAM file (with the counts for 
      each sample)
    inputBinding:
      position: 4
      prefix: -u
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed (time otherwise)
    inputBinding:
      position: 4
      prefix: -s
outputs:
  - id: sam_files
    type:
      type: array
      items: File
    doc: Output SAM files
    outputBinding:
      glob: $(inputs.output_files)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srnamapper:1.0.12--h577a1d6_0

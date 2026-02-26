cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmap
label: rmap
doc: "Map fastq reads to a reference genome.\n\nTool homepage: https://github.com/juruen/rmapi"
inputs:
  - id: fastq_reads_file
    type: File
    doc: File containing fastq reads
    inputBinding:
      position: 1
  - id: chrom_suffix
    type:
      - 'null'
      - string
    doc: suffix of chrom files (assumes dir provided)
    inputBinding:
      position: 102
      prefix: -suffix
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: chromosomes in FASTA file or dir
    inputBinding:
      position: 102
      prefix: -chrom
  - id: clip_adaptor
    type:
      - 'null'
      - string
    doc: clip the specified adaptor
    inputBinding:
      position: 102
      prefix: -clip
  - id: max_mappings_per_read
    type:
      - 'null'
      - int
    doc: maximum allowed mappings for a read
    inputBinding:
      position: 102
      prefix: -max-map
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: maximum allowed mismatches
    inputBinding:
      position: 102
      prefix: -mismatch
  - id: number_of_reads
    type:
      - 'null'
      - int
    doc: number of reads to map
    inputBinding:
      position: 102
      prefix: -number
  - id: start_read_index
    type:
      - 'null'
      - int
    doc: index of first read to map
    inputBinding:
      position: 102
      prefix: -start
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
  - id: ambiguous_reads_file
    type:
      - 'null'
      - File
    doc: file to write names of ambiguously mapped reads
    outputBinding:
      glob: $(inputs.ambiguous_reads_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmap:2.1--0

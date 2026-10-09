cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - count-reads
label: hatchet_count_reads
doc: "Count the mapped sequencing reads in bins of the given (variable) length, uniformly for a BAM file of a normal sample and one or more BAM files of tumor samples (WGS or WES).

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: normal
    type: File
    secondaryFiles:
      - '.bai'
    doc: BAM file corresponding to matched normal sample
    inputBinding:
      position: 10
      prefix: -N
  - id: tumor
    type:
      type: array
      items: File
    secondaryFiles:
      - '.bai'
    doc: BAM files corresponding to samples from the same tumor
    inputBinding:
      position: 10
      prefix: -T
  - id: baffile
    type: File
    doc: "1bed file containing SNP information from tumor samples (i.e., baf/bulk.1bed)"
    inputBinding:
      position: 10
      prefix: -b
  - id: refversion
    type: string
    doc: Version of reference genome used in BAM files
    inputBinding:
      position: 10
      prefix: -V
  - id: outdir
    type: string
    doc: Directory for output files (created in the working directory)
    inputBinding:
      position: 10
      prefix: -O
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample names for each BAM, given in the same order where the normal name is first (default: inferred from file names)"
    inputBinding:
      position: 10
      prefix: -S
  - id: samtools
    type:
      - 'null'
      - string
    doc: Path to samtools executable
    inputBinding:
      position: 10
      prefix: -st
  - id: mosdepth
    type:
      - 'null'
      - string
    doc: Path to mosdepth executable
    inputBinding:
      position: 10
      prefix: -md
  - id: tabix
    type:
      - 'null'
      - string
    doc: Path to tabix executable
    inputBinding:
      position: 10
      prefix: -tx
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of available parallel processes (default: 2)"
    inputBinding:
      position: 10
      prefix: -j
  - id: readquality
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality for an aligned read to be considered (default: 11)"
    inputBinding:
      position: 10
      prefix: -q
  - id: intermediates
    type:
      - 'null'
      - boolean
    doc: "Produce intermediate counts files only and do not proceed to forming arrays (default: False)"
    inputBinding:
      position: 10
      prefix: -i
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more chromosomes to process (default: blank to process all chromosomes)"
    inputBinding:
      position: 10
      prefix: --chromosomes
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory with the per-chromosome array files, samples.txt and total.tsv"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({"class": "Directory", "basename": inputs.outdir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0

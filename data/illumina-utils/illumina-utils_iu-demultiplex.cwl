cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-demultiplex
label: illumina-utils_iu-demultiplex
doc: "Demultiplex a paired-end Illumina Run\n\nTool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: index_fastq
    type:
      - 'null'
      - File
    doc: Index file (I1)
    inputBinding:
      position: 101
      prefix: --index
  - id: r1_fastq
    type:
      - 'null'
      - File
    doc: FASTQ file for R1
    inputBinding:
      position: 101
      prefix: --r1
  - id: r2_fastq
    type:
      - 'null'
      - File
    doc: FASTQ file for R2.
    inputBinding:
      position: 101
      prefix: --r2
  - id: rev_comp_barcodes
    type:
      - 'null'
      - boolean
    doc: Reverse-complement barcodes before processing
    inputBinding:
      position: 101
      prefix: --rev-comp-barcodes
  - id: sample_barcode_mapping
    type:
      - 'null'
      - File
    doc: TAB-delimited file of sample-barcode associations
    inputBinding:
      position: 101
      prefix: --sample-barcode-mapping
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory for output storage
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0

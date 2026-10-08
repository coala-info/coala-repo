cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - ASSEMBLY
label: lrtk_ASSEMBLY
doc: "Assemble metagenome-assembled genomes (MAGs) from linked-read metagenomic data with Pangaea, metaSPAdes and Athena contigs.\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
inputs:
  - id: fq1
    type: File
    doc: Input fastq file (uncompressed FASTQ format), the first read of paired linked-read sequencing data (with barcode).
    inputBinding:
      position: 1
      prefix: -FQ1
  - id: fq2
    type: File
    doc: Input fastq file (uncompressed FASTQ format), the first read of paired linked-read sequencing data (with barcode).
    inputBinding:
      position: 1
      prefix: -FQ2
  - id: metaspades
    type: File
    doc: assembled contigs using metaspades.
    inputBinding:
      position: 1
      prefix: -MS
  - id: athena_l
    type: File
    doc: local assembled contigs from athena.
    inputBinding:
      position: 1
      prefix: -AL
  - id: athena_h
    type: File
    doc: hybrid assembled contigs from athena.
    inputBinding:
      position: 1
      prefix: -AH
  - id: low_abd_cut
    type: string
    doc: coverage for low abundance contigs.
    inputBinding:
      position: 1
      prefix: -LT
  - id: outfile
    type: string
    doc: the final assembled contigs.
    inputBinding:
      position: 1
      prefix: -O
  - id: threads
    type: int
    doc: Number of threads.
    inputBinding:
      position: 1
      prefix: -T
outputs:
  - id: assembled_contigs
    type:
      - 'null'
      - File
    doc: The final assembled contigs.
    outputBinding:
      glob: $(inputs.outfile)
  - id: binning_directory
    type:
      - 'null'
      - Directory
    doc: Binning results folder written next to the output file.
    outputBinding:
      glob: binning
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0

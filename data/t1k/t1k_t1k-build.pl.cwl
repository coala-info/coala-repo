cwlVersion: v1.2
class: CommandLineTool
baseCommand: t1k-build.pl
label: t1k_t1k-build.pl
doc: "Builds a T1K database from EMBL-ENA dat files, plain gene sequence files, or
  download links.\n\nTool homepage: https://github.com/mourisl/T1K"
inputs:
  - id: download_dat_file
    type: string
    doc: IPD-IMGT/HLA or IPD-KIR or user-specified dat file download link
    inputBinding:
      position: 101
      prefix: --download
  - id: embl_ena_dat_file
    type: string
    doc: EMBL-ENA dat file
    inputBinding:
      position: 101
      prefix: -d
  - id: file_prefix
    type:
      - 'null'
      - string
    doc: 'file prefix (default: based on --target or -o)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: gene_sequence_file
    type: string
    doc: plain gene sequence file
    inputBinding:
      position: 101
      prefix: -f
  - id: genome_annotation_file
    type:
      - 'null'
      - string
    doc: genome annotation file
    default: not used
    inputBinding:
      position: 101
      prefix: -g
  - id: ignore_partial
    type:
      - 'null'
      - boolean
    doc: 'ignore partial allele at all (default: fill in intron if exons are complete)'
    inputBinding:
      position: 101
      prefix: --ignore-partial
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: output folder
    default: ./
    inputBinding:
      position: 101
      prefix: -o
  - id: partial_intron_noseq
    type:
      - 'null'
      - boolean
    doc: the partial introns and pseudo exons are not present in the sequence of
      the dat file, e.g. IPD-KIR_2.13.0.
    inputBinding:
      position: 101
      prefix: --partial-intron-noseq
  - id: target_gene
    type:
      - 'null'
      - string
    doc: gene name keyword
    default: no filter
    inputBinding:
      position: 101
      prefix: --target
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t1k:1.0.9--h5ca1c30_0
stdout: t1k_t1k-build.pl.out

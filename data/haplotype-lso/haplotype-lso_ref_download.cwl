cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hlso
  - ref_download
label: haplotype-lso_ref_download
doc: "Download the seed sequences and the reference sequences from NCBI (GenBank).\n\nTool homepage: https://github.com/holtgrewe/haplotype-lso"
inputs:
  - id: in_tsv
    type: File
    doc: "Path to input TSV file with the seed accessions."
    inputBinding:
      position: 1
  - id: out_tsv
    type: string
    doc: "Path to output TSV file (its directory receives the downloaded files; the table is written as seeds_paths.tsv)."
    inputBinding:
      position: 2
outputs:
  - id: seeds_paths
    type:
      - 'null'
      - File
    doc: "Table with the paths of the downloaded seed files"
    outputBinding:
      glob: seeds_paths.tsv
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Downloaded seed and reference FASTA files"
    outputBinding:
      glob: '*.fasta'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.in_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4

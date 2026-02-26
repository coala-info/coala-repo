cwlVersion: v1.2
class: CommandLineTool
baseCommand: cthreepo
label: cthreepo
doc: "This script parses input file and converts the seq-id name from one kind to
  the other\n\nTool homepage: https://github.com/vkkodali/cthreepo"
inputs:
  - id: accn
    type:
      - 'null'
      - string
    doc: NCBI Assembly Accession with version
    inputBinding:
      position: 101
      prefix: --accn
  - id: column
    type:
      - 'null'
      - int
    doc: column where the seq-id is located; required for `tsv` format
    inputBinding:
      position: 101
      prefix: --column
  - id: format
    type:
      - 'null'
      - string
    doc: input file format; can be `gff3`, `gtf`, `bedgraph`, `bed`, `sam`, 
      `vcf`, `wig` or `tsv`; default is `gff3`
    default: gff3
    inputBinding:
      position: 101
      prefix: --format
  - id: id_from
    type:
      - 'null'
      - string
    doc: seq-id format in the input file; can be `any`, `ens`, `uc`, `gb`, or 
      `rs`; default is `any`
    default: any
    inputBinding:
      position: 101
      prefix: --id_from
  - id: id_to
    type:
      - 'null'
      - string
    doc: seq-id format in the output file; can be `ens`, `uc`, `gb`, or `rs`; 
      default is `rs`
    default: rs
    inputBinding:
      position: 101
      prefix: --id_to
  - id: infile
    type:
      - 'null'
      - File
    doc: input file
    inputBinding:
      position: 101
      prefix: --infile
  - id: keep_unmapped
    type:
      - 'null'
      - boolean
    doc: keep lines that don't have seq-id matches
    inputBinding:
      position: 101
      prefix: --keep_unmapped
  - id: mapfile
    type:
      - 'null'
      - File
    doc: NCBI style assembly_report file for mapping
    inputBinding:
      position: 101
      prefix: --mapfile
  - id: primary
    type:
      - 'null'
      - boolean
    doc: restrict to primary assembly only
    inputBinding:
      position: 101
      prefix: --primary
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cthreepo:0.1.3--pyh7cba7a3_0

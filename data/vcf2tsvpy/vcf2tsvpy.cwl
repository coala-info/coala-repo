cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2tsvpy
label: vcf2tsvpy
doc: "Convert a VCF (Variant Call Format) file with genomic variants to a file with
  tab-separated values (TSV). One entry (TSV line) per sample genotype.\n\nTool homepage:
  https://github.com/sigven/vcf2tsvpy"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output TSV file with gzip
    inputBinding:
      position: 101
      prefix: --compress
  - id: input_vcf
    type: File
    doc: Bgzipped input VCF file with input variants (SNVs/InDels)
    inputBinding:
      position: 101
      prefix: --input_vcf
  - id: keep_rejected_calls
    type:
      - 'null'
      - boolean
    doc: Output data also for rejected (non-PASS) calls
    inputBinding:
      position: 101
      prefix: --keep_rejected_calls
  - id: print_data_type_header
    type:
      - 'null'
      - boolean
    doc: Output a header line with data types of VCF annotations
    inputBinding:
      position: 101
      prefix: --print_data_type_header
  - id: skip_genotype_data
    type:
      - 'null'
      - boolean
    doc: Skip output of genotype_data (FORMAT columns)
    inputBinding:
      position: 101
      prefix: --skip_genotype_data
  - id: skip_info_data
    type:
      - 'null'
      - boolean
    doc: Skip output of data in INFO column
    inputBinding:
      position: 101
      prefix: --skip_info_data
outputs:
  - id: out_tsv
    type: File
    doc: Output TSV file with one line per non-rejected sample genotype 
      (variant, genotype and annotation data as tab-separated values)
    outputBinding:
      glob: $(inputs.out_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2tsvpy:0.6.1--pyhda70652_0

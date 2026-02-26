cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rhocall
  - annotate
label: rhocall_annotate
doc: "Markup VCF file using rho-calls. Use BED file to mark all variants in AZ\n \
  \ windows. Alternatively, use a bcftools v>=1.4 file with RG entries to mark\n \
  \ all vars. With the --no-v14 flag, use an older bcftools v<=1.2 style roh TSV\n\
  \  to mark only selected AZ variants. Roh is broken in bcftools v1.3 - do not\n\
  \  use.\n\nTool homepage: https://github.com/dnil/rhocall"
inputs:
  - id: vcf
    type: File
    doc: VCF file to markup
    inputBinding:
      position: 1
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file with AZ windows.
    inputBinding:
      position: 102
      prefix: -b
  - id: flag_upd_at_fraction
    type:
      - 'null'
      - float
    doc: "Flag UPD if this fraction of chr quality\n                             \
      \     positions called AZ."
    inputBinding:
      position: 102
      prefix: --flag_upd_at_fraction
  - id: no_v14_roh_file
    type:
      - 'null'
      - boolean
    doc: "use an older bcftools v<=1.2 style roh TSV\n                           \
      \       to mark only selected AZ variants."
    inputBinding:
      position: 102
      prefix: --no-v14
  - id: quality_threshold
    type:
      - 'null'
      - float
    doc: "Minimum quality calls that are imported in\n                           \
      \       region totals."
    inputBinding:
      position: 102
      prefix: --quality_threshold
  - id: roh_tsv_file
    type:
      - 'null'
      - File
    doc: "Bcftools roh style TSV file with\n                                  CHR,POS,AZ,QUAL."
    inputBinding:
      position: 102
      prefix: -r
  - id: use_v14_roh_file
    type:
      - 'null'
      - boolean
    doc: "Bcftools v1.4 or newer roh file including RG\n                         \
      \         calls."
    inputBinding:
      position: 102
      prefix: --v14
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5

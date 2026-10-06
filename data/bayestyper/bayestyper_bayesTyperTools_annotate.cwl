cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bayesTyperTools, annotate]
label: bayestyper_bayesTyperTools_annotate
doc: "BayesTyperTools annotate: annotate alleles\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs:
  - id: variant_file
    type: File
    doc: variant file (vcf format)
    inputBinding:
      position: 1
      prefix: -v
  - id: annotation_file
    type: File
    doc: annotation file (vcf format)
    inputBinding:
      position: 1
      prefix: -a
  - id: output_prefix
    type: string
    doc: output prefix
    inputBinding:
      position: 1
      prefix: -o
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: compress output file(s) using gzip
    inputBinding:
      position: 1
      prefix: -z
  - id: clear_prev_annotation
    type:
      - 'null'
      - boolean
    doc: clear previous annotations (variant id and AAI)
    inputBinding:
      position: 1
      prefix: -c
  - id: match_threshold
    type:
      - 'null'
      - float
    doc: 'minimum sequence overlap between input allele and annotation allele (default: 0.5)'
    inputBinding:
      position: 1
      prefix: --match-threshold
  - id: window_size_scale
    type:
      - 'null'
      - float
    doc: 'window size allele length scaling factor (default: 3)'
    inputBinding:
      position: 1
      prefix: --window-size-scale
outputs:
  - id: output_vcf
    type: File
    doc: Output variant file (vcf or vcf.gz)
    outputBinding:
      glob:
        - $(inputs.output_prefix).vcf
        - $(inputs.output_prefix).vcf.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayestyper:1.5--h077b44d_4

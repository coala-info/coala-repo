cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bayesTyperTools, combine]
requirements:
  - class: InlineJavascriptRequirement
label: bayestyper_bayesTyperTools_combine
doc: "BayesTyperTools combine: combine callsets (vertical)\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs:
  - id: variant_files
    type: File[]
    doc: variant files (vcf format) to combine; each is passed as <name>:<file>
    inputBinding:
      position: 1
      prefix: -v
      itemSeparator: ','
      valueFrom: '${ return self.map(function(f, i) { return (inputs.variant_names ? inputs.variant_names[i]
        : f.nameroot) + '':'' + f.path; }); }'
  - id: variant_names
    type:
      - 'null'
      - string[]
    doc: 'names (callset source tags) for the variant files, in the same order (default: file name without
      extension)'
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
  - id: filter_ambiguous_alleles
    type:
      - 'null'
      - boolean
    doc: filter alleles (including reference) with ambiguous nucleotides (non ACGT)
    inputBinding:
      position: 1
      prefix: --filter-ambiguous-alleles
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

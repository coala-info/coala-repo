cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bayesTyperTools, addAttributes]
label: bayestyper_bayesTyperTools_addAttributes
doc: "BayesTyperTools addAttributes: add variant, allele and/or trio attributes\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs:
  - id: variant_file
    type: File
    doc: variant file (vcf format)
    inputBinding:
      position: 1
      prefix: -v
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
  - id: genome_file
    type:
      - 'null'
      - File
    doc: reference genome file (fasta format) used for homopolymer length (HPL) calculation
    inputBinding:
      position: 1
      prefix: --genome-file
  - id: repeat_file
    type:
      - 'null'
      - File
    doc: repeatmasker file used for repeat annotation (RMA)
    inputBinding:
      position: 1
      prefix: --repeat-file
  - id: independent_samples_regex
    type:
      - 'null'
      - string
    doc: regular expression for matching independent samples (e.g. parents in a trio) used for absolute
      inbreeding coefficient (IBC) calculation
    inputBinding:
      position: 1
      prefix: --independent-samples-regex
  - id: trio_sample_info
    type:
      - 'null'
      - string
    doc: trio sample id information used for concordance (CONC) calculation (<father>,<mother>,<child>:...)
    inputBinding:
      position: 1
      prefix: --trio-sample-info
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

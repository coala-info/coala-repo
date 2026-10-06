cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bayesTyperTools, filter]
label: bayestyper_bayesTyperTools_filter
doc: "BayesTyperTools filter: filter variants, alleles and/or samples\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
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
  - id: min_homozygote_genotypes
    type:
      - 'null'
      - int
    doc: 'filter variants with less than <value> homozygote genotypes (calculated before other filters)
      (default: 0)'
    inputBinding:
      position: 1
      prefix: --min-homozygote-genotypes
  - id: min_genotype_posterior
    type:
      - 'null'
      - float
    doc: 'filter genotypes with a posterior probability (GPP) below <value> (default: 0.99)'
    inputBinding:
      position: 1
      prefix: --min-genotype-posterior
  - id: min_number_of_kmers
    type:
      - 'null'
      - int
    doc: 'filter sampled alleles with less than <value> kmers (NAK) (default: 1)'
    inputBinding:
      position: 1
      prefix: --min-number-of-kmers
  - id: kmer_coverage_file
    type:
      - 'null'
      - File
    doc: 'sample kmer coverage file used for filtering sampled alleles with a low fraction of observed
      kmers (FAK) (default: bayestyper_genomic_parameters.txt)'
    inputBinding:
      position: 1
      prefix: --kmer-coverage-file
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

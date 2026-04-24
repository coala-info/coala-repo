cwlVersion: v1.2
class: CommandLineTool
baseCommand: PanGenie-vcf
label: pangenie_PanGenie-vcf
doc: "Genotyping based on kmer-counting and known haplotype sequences using serialized
  genotyping results.\n\nTool homepage: https://github.com/eblerjana/pangenie"
inputs:
  - id: genotyping_results
    type: File
    doc: serialized genotyping results (produced by PanGenie run with parameter -w).
    inputBinding:
      position: 101
      prefix: -z
  - id: index_prefix
    type: File
    doc: filename prefix of the index files (i.e. option -o used with PanGenie-index).
    inputBinding:
      position: 101
      prefix: -f
  - id: output_missing_genotypes
    type:
      - 'null'
      - boolean
    doc: output genotype ./. for variants not covered by any unique kmers
    inputBinding:
      position: 101
      prefix: -u
  - id: run_genotyping
    type:
      - 'null'
      - boolean
    doc: run genotyping (only set if used with PanGenie genotyping)
    inputBinding:
      position: 101
      prefix: -g
  - id: run_phasing
    type:
      - 'null'
      - boolean
    doc: run phasing (only set if used with PanGenie genotyping)
    inputBinding:
      position: 101
      prefix: -p
  - id: sample_name
    type:
      - 'null'
      - string
    doc: name of the sample (will be used in the output VCFs)
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_prefix
    type: File
    doc: 'prefix of the output files. NOTE: the given path must not include non-existent
      folders.'
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangenie:4.2.1--h077b44d_0

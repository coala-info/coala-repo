cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bayesTyperTools, convertAllele]
label: bayestyper_bayesTyperTools_convertAllele
doc: "BayesTyperTools convertAllele: convert allele IDs to sequence\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs:
  - id: variant_file
    type: File
    doc: variant file (vcf format)
    inputBinding:
      position: 1
      prefix: -v
  - id: genome_file
    type: File
    doc: reference genome file (fasta format)
    inputBinding:
      position: 1
      prefix: -g
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
  - id: alt_file
    type:
      - 'null'
      - File
    doc: alternative allele file (fasta format); sequence name >"name" should match <"name">
    inputBinding:
      position: 1
      prefix: --alt-file
  - id: mei_file
    type:
      - 'null'
      - File
    doc: mobile element insertion(s) file (fasta format); sequence name >"name" should match <INS:ME:"name">
    inputBinding:
      position: 1
      prefix: --mei-file
  - id: keep_imprecise
    type:
      - 'null'
      - boolean
    doc: do not filter imprecise variants
    inputBinding:
      position: 1
      prefix: --keep-imprecise
  - id: keep_partial
    type:
      - 'null'
      - boolean
    doc: keep partial insertions where the center and length is unknown (Manta output supported)
    inputBinding:
      position: 1
      prefix: --keep-partial
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand: cladeomatic
label: cladeomatic_benchmark
doc: "Clade-O-Matic: Benchmarking Genotyping scheme development v. 0.1.1\n\nTool homepage:
  https://github.com/phac-nml/cladeomatic"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: in_genotype
    type: File
    doc: Genotype report made by genotyper
    inputBinding:
      position: 101
      prefix: --in_genotype
  - id: in_scheme
    type: File
    doc: Tab delimited scheme file produced by clade-o-matic
    inputBinding:
      position: 101
      prefix: --in_scheme
  - id: in_var
    type: File
    doc: Either Variant Call SNP data (.vcf) or TSV SNP data (.txt)
    inputBinding:
      position: 101
      prefix: --in_var
  - id: outdir
    type: Directory
    doc: Output Directory to put results
    inputBinding:
      position: 101
      prefix: --outdir
  - id: predicted_genotype_col
    type: string
    doc: Name of column containing predicted genotype
    inputBinding:
      position: 101
      prefix: --predicted_genotype_col
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output Directory to put results
    inputBinding:
      position: 101
      prefix: --prefix
  - id: submitted_genotype_col
    type: string
    doc: Name of column containing submitted genotype
    inputBinding:
      position: 101
      prefix: --submitted_genotype_col
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0
stdout: cladeomatic_benchmark.out

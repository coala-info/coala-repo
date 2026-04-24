cwlVersion: v1.2
class: CommandLineTool
baseCommand: cladeomatic
label: cladeomatic_genotype
doc: "Clade-O-Matic: Genotyping scheme development v. 0.1.1\n\nTool homepage: https://github.com/phac-nml/cladeomatic"
inputs:
  - id: genotype_meta
    type:
      - 'null'
      - File
    doc: Tab delimited genotype metadata
    inputBinding:
      position: 101
      prefix: --genotype_meta
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
  - id: max_missing_positions
    type:
      - 'null'
      - int
    doc: Maximum number of missing positions for the genotype
    inputBinding:
      position: 101
      prefix: --max_missing_positions
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: sample_meta
    type: File
    doc: Tab delimited sample metadata
    inputBinding:
      position: 101
      prefix: --sample_meta
outputs:
  - id: outfile
    type: Directory
    doc: Output Directory to put results
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0

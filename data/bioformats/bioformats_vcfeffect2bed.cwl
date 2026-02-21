cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - vcfeffect2bed
label: bioformats_vcfeffect2bed
doc: "Given an snpEff-annotated VCF file, extract its sample genotype effects.\n\n
  Tool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: vcf_file
    type: File
    doc: an snpEff-annotated VCF file
    inputBinding:
      position: 1
  - id: genotypes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Genotype values: REFHET - a heterozygote with one reference allele, COMHET
      - a heterozygote with both alternative alleles, ALTHOM - an alternative homozygote'
    inputBinding:
      position: 102
      prefix: --genotypes
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: ignore errors in an input file
    inputBinding:
      position: 102
      prefix: --ignore_errors
  - id: impacts
    type:
      - 'null'
      - type: array
        items: string
    doc: 'impacts of effects to be reported (choices: HIGH, MODERATE, LOW, MODIFIER)'
    inputBinding:
      position: 102
      prefix: --impacts
outputs:
  - id: output_file
    type: File
    doc: the output BED3+ file of sample effects
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0

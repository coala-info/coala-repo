cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - vcfgeno2bed
label: bioformats_vcfgeno2bed
doc: "Given a VCF file, extract genotype counts from it and write them to the specified
  file in the BED3+ format.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: vcf_file
    type: File
    doc: a VCF file
    inputBinding:
      position: 1
  - id: individuals
    type:
      - 'null'
      - File
    doc: a file with the list of individuals to be considered for genotype counting
    inputBinding:
      position: 102
      prefix: --individuals
outputs:
  - id: output_file
    type: File
    doc: the output BED3+ file of genotype counts
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0

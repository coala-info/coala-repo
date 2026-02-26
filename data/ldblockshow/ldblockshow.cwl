cwlVersion: v1.2
class: CommandLineTool
baseCommand: LDBlockShow
label: ldblockshow
doc: "A fast and convenient tool for Linkage Disequilibrium (LD) visualization and
  LD block analysis.\n\nTool homepage: https://github.com/BGI-shenzhen/LDBlockShow"
inputs:
  - id: block
    type:
      - 'null'
      - boolean
    doc: Calculate and show LD blocks
    inputBinding:
      position: 101
      prefix: -Block
  - id: in_annos
    type:
      - 'null'
      - File
    doc: Input annotation file for highlighting specific sites
    inputBinding:
      position: 101
      prefix: -InAnnos
  - id: in_gff
    type:
      - 'null'
      - File
    doc: Input GFF file for gene structure visualization
    inputBinding:
      position: 101
      prefix: -InGFF
  - id: in_vcf
    type: File
    doc: Input VCF format file
    inputBinding:
      position: 101
      prefix: -InVCF
  - id: maf
    type:
      - 'null'
      - float
    doc: Minor Allele Frequency filter
    default: 0.05
    inputBinding:
      position: 101
      prefix: -MAF
  - id: region
    type:
      - 'null'
      - string
    doc: Region to plot (e.g., chr1:1-10000)
    inputBinding:
      position: 101
      prefix: -Region
  - id: sele_var
    type:
      - 'null'
      - int
    doc: Select variant type (1:SNP, 2:Indel, 3:Both)
    default: 1
    inputBinding:
      position: 101
      prefix: -SeleVar
  - id: show_all_id
    type:
      - 'null'
      - boolean
    doc: Show all variant IDs in the plot
    inputBinding:
      position: 101
      prefix: -ShowAllID
  - id: sub_pop
    type:
      - 'null'
      - File
    doc: Sub-population sample list file
    inputBinding:
      position: 101
      prefix: -SubPop
outputs:
  - id: output_prefix
    type: File
    doc: Output prefix for result files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldblockshow:1.41--pl5321h077b44d_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [vcf2geno]
label: rvtests_vcf2geno
doc: "Convert a VCF file to a genotype table (one row per variant, 0/1/2 genotype per person, -9 missing); the table is printed on standard output.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: anno_type
    type:
      - 'null'
      - string
    doc: "Specify the type of annotation to extract"
    inputBinding:
      position: 101
      prefix: --annoType
  - id: gene
    type:
      - 'null'
      - string
    doc: "Specify the gene names to extract"
    inputBinding:
      position: 101
      prefix: --gene
  - id: gene_file
    type:
      - 'null'
      - File
    doc: "Specify the gene file (refFlat format), so we know gene start and end."
    inputBinding:
      position: 101
      prefix: --geneFile
  - id: in_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Input VCF file (plain, bgzip, or BCF). Range filters need a tabix index (.tbi) beside it."
    inputBinding:
      position: 101
      prefix: --inVcf
  - id: people_exclude_file
    type:
      - 'null'
      - File
    doc: "From given file, set IDs of people that will be excluded from study"
    inputBinding:
      position: 101
      prefix: --peopleExcludeFile
  - id: people_exclude_id
    type:
      - 'null'
      - type: array
        items: string
    doc: "Give IDs of people that will be excluded from study (comma separated)"
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --peopleExcludeID
  - id: people_include_file
    type:
      - 'null'
      - File
    doc: "From given file, set IDs of people that will be included in study"
    inputBinding:
      position: 101
      prefix: --peopleIncludeFile
  - id: people_include_id
    type:
      - 'null'
      - type: array
        items: string
    doc: "Give IDs of people that will be included in study (comma separated)"
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --peopleIncludeID
  - id: range_file
    type:
      - 'null'
      - File
    doc: "Specify the file containing ranges, please use chr:begin-end format."
    inputBinding:
      position: 101
      prefix: --rangeFile
  - id: range_list
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify some ranges to use, please use chr:begin-end format."
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --rangeList
  - id: update_id
    type:
      - 'null'
      - File
    doc: "Update VCF sample id using given file (column 1 and 2 are old and new id)."
    inputBinding:
      position: 101
      prefix: --update-id
  - id: variant_only
    type:
      - 'null'
      - boolean
    doc: "Only variant sites from the VCF file will be processed."
    inputBinding:
      position: 101
      prefix: --variantOnly
outputs:
  - id: genotype_table
    type: stdout
    doc: "Genotype table printed by the tool"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: $(inputs.in_vcf.basename).geno.txt

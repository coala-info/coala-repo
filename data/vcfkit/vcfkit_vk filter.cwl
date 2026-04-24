cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfkit
  - vk
  - filter
label: vcfkit_vk filter
doc: "Filter VCF based on genotype counts.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: genotype_type
    type: string
    doc: Type of genotype to filter on (REF, HET, ALT, MISSING)
    inputBinding:
      position: 1
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 2
  - id: max_count
    type:
      - 'null'
      - int
    doc: Maximum count for the specified genotype type
    inputBinding:
      position: 103
      prefix: --max
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum count for the specified genotype type
    inputBinding:
      position: 103
      prefix: --min
  - id: mode
    type:
      - 'null'
      - string
    doc: "Mode for filtering: '+' for inclusive, 'x' for exclusive"
    inputBinding:
      position: 103
      prefix: --mode
  - id: soft_filter
    type:
      - 'null'
      - string
    doc: Apply soft filter with the given name
    inputBinding:
      position: 103
      prefix: --soft-filter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk filter.out

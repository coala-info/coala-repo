cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallr_longcallR-ase
label: longcallr_longcallR-ase
doc: "Performs allele-specific expression analysis using LongcallR.\n\nTool homepage:
  https://github.com/huangnengCSU/longcallR"
inputs:
  - id: annotation
    type: File
    doc: Annotation file
    inputBinding:
      position: 101
      prefix: --annotation
  - id: bam
    type: File
    doc: phased BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: gene_types
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene types to be analyzed. Default is ["protein_coding", "lncRNA"]
      - protein_coding
      - lncRNA
    inputBinding:
      position: 101
      prefix: --gene_types
  - id: min_support
    type:
      - 'null'
      - int
    doc: 'Minimum support reads for counting event (default: 10)'
    inputBinding:
      position: 101
      prefix: --min_support
  - id: overdispersion
    type:
      - 'null'
      - float
    doc: Overdispersion parameter
    inputBinding:
      position: 101
      prefix: --overdispersion
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf1
    type:
      - 'null'
      - File
    doc: LongcallR phased vcf file
    inputBinding:
      position: 101
      prefix: --vcf1
  - id: vcf2
    type:
      - 'null'
      - File
    doc: Whole genome haplotype phased DNA vcf file
    inputBinding:
      position: 101
      prefix: --vcf2
  - id: vcf3
    type:
      - 'null'
      - File
    doc: DNA vcf file
    inputBinding:
      position: 101
      prefix: --vcf3
outputs:
  - id: output
    type: File
    doc: prefix of output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py313ha45639b_1

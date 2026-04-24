cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallr_longcallR-asj
label: longcallr_longcallR-asj
doc: "longcallR-asj\n\nTool homepage: https://github.com/huangnengCSU/longcallR"
inputs:
  - id: annotation_file
    type: File
    doc: Annotation file in GFF3 or GTF format
    inputBinding:
      position: 101
      prefix: --annotation_file
  - id: bam_file
    type: File
    doc: BAM file
    inputBinding:
      position: 101
      prefix: --bam_file
  - id: cluster_with_exons
    type:
      - 'null'
      - boolean
    doc: Cluster junctions with exons
    inputBinding:
      position: 101
      prefix: --cluster_with_exons
  - id: dna_vcf
    type:
      - 'null'
      - File
    doc: DNA VCF file
    inputBinding:
      position: 101
      prefix: --dna_vcf
  - id: gene_types
    type:
      - 'null'
      - type: array
        items: string
    doc: "Gene types to be analyzed. Default is\n[\"protein_coding\", \"lncRNA\"]"
      - protein_coding
      - lncRNA
    inputBinding:
      position: 101
      prefix: --gene_types
  - id: min_junctions
    type:
      - 'null'
      - int
    doc: Minimum number of junctions to be considered
    inputBinding:
      position: 101
      prefix: --min_junctions
  - id: min_sup
    type:
      - 'null'
      - int
    doc: Minimum support of phased reads for exon or junction
    inputBinding:
      position: 101
      prefix: --min_sup
  - id: no_gtag
    type:
      - 'null'
      - boolean
    doc: Do not filter read junction with GT-AG signal
    inputBinding:
      position: 101
      prefix: --no_gtag
  - id: output_prefix
    type: string
    doc: "prefix of output differential splicing file and\nallele-specific junctions
      file"
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: reference
    type: File
    doc: Reference genome file
    inputBinding:
      position: 101
      prefix: --reference
  - id: rna_vcf
    type:
      - 'null'
      - File
    doc: RNA VCF file
    inputBinding:
      position: 101
      prefix: --rna_vcf
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py313ha45639b_1
stdout: longcallr_longcallR-asj.out

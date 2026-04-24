cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitorsaw_haplotype
label: mitorsaw_haplotype
doc: "Run the haplotyper on a dataset\n\nTool homepage: https://github.com/PacificBiosciences/mitorsaw"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: Input alignment file in BAM format, can be specified multiple times
    inputBinding:
      position: 101
      prefix: --bam
  - id: database
    type:
      - 'null'
      - string
    doc: Input database file (Optional, JSON)
    inputBinding:
      position: 101
      prefix: --database
  - id: minimum_maf
    type:
      - 'null'
      - float
    doc: Minimum allele frequency to consider a heteroplasmic variant
    inputBinding:
      position: 101
      prefix: --minimum-maf
  - id: minimum_map_frac
    type:
      - 'null'
      - float
    doc: Minimum fraction of read that must map to pass filters
    inputBinding:
      position: 101
      prefix: --minimum-map-frac
  - id: minimum_read_count
    type:
      - 'null'
      - int
    doc: Minimum read count to consider a heteroplasmic variant
    inputBinding:
      position: 101
      prefix: --minimum-read-count
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample_name
    type:
      - 'null'
      - string
    doc: 'Sample name to use in VCF output (default: BAM RG tag or "SAMPLE")'
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_vcf
    type: File
    doc: Output variant call file (VCF)
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: output_hap_stats
    type:
      - 'null'
      - File
    doc: Optional haplotype stats
    outputBinding:
      glob: $(inputs.output_hap_stats)
  - id: output_debug
    type:
      - 'null'
      - Directory
    doc: Optional output debug folder
    outputBinding:
      glob: $(inputs.output_debug)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitorsaw:0.2.7--h9ee0642_0

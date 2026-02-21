cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpyexpress
label: lumpy-sv_lumpyexpress
doc: "An automated script for running the LUMPY structural variant caller.\n\nTool
  homepage: https://github.com/arq5x/lumpy-sv"
inputs:
  - id: bam_files
    type: string
    doc: Full BAM file(s) (comma separated)
    inputBinding:
      position: 101
      prefix: -B
  - id: discordant_bam_files
    type: string
    doc: Discordant reads BAM file(s) (comma separated)
    inputBinding:
      position: 101
      prefix: -D
  - id: exclude_bed
    type:
      - 'null'
      - File
    doc: BED file of regions to exclude
    inputBinding:
      position: 101
      prefix: -x
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files
    inputBinding:
      position: 101
      prefix: -k
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    default: 20
    inputBinding:
      position: 101
      prefix: -q
  - id: min_sample_weight
    type:
      - 'null'
      - int
    doc: Minimum sample weight
    default: 4
    inputBinding:
      position: 101
      prefix: -m
  - id: phred_threshold
    type:
      - 'null'
      - float
    doc: Phred threshold
    default: 0.9
    inputBinding:
      position: 101
      prefix: -P
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length
    default: 101
    inputBinding:
      position: 101
      prefix: -r
  - id: split_bam_files
    type: string
    doc: Split reads BAM file(s) (comma separated)
    inputBinding:
      position: 101
      prefix: -S
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    inputBinding:
      position: 101
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3

cwlVersion: v1.2
class: CommandLineTool
baseCommand: minipileup
label: minipileup
doc: "Generates a pileup of aligned sequencing reads, with options for variant calling
  and filtering.\n\nTool homepage: https://github.com/lh3/minipileup"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: drop_allele_if_fraction_below
    type:
      - 'null'
      - float
    doc: drop an allele if the allele fraction is below FLOAT
    default: 0.0
    inputBinding:
      position: 102
      prefix: -p
  - id: drop_alleles_with_depth_less_than
    type:
      - 'null'
      - int
    doc: drop alleles with depth<INT
    default: 1
    inputBinding:
      position: 102
      prefix: -s
  - id: drop_alleles_with_depth_less_than_both_strands
    type:
      - 'null'
      - int
    doc: drop alleles with depth<INT on either strand
    default: 0
    inputBinding:
      position: 102
      prefix: -a
  - id: include_bed_file
    type:
      - 'null'
      - File
    doc: BED or position list file to include
    default: 'null'
    inputBinding:
      position: 102
      prefix: -b
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: minimum alignment length
    default: 0
    inputBinding:
      position: 102
      prefix: -l
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: minimum base quality
    default: 0
    inputBinding:
      position: 102
      prefix: -Q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 0
    inputBinding:
      position: 102
      prefix: -q
  - id: min_supplementary_alignment_length
    type:
      - 'null'
      - int
    doc: minimum supplementary alignment length
    default: 0
    inputBinding:
      position: 102
      prefix: -S
  - id: only_properly_paired_reads
    type:
      - 'null'
      - boolean
    doc: only consider properly paired reads for paired-end reads
    inputBinding:
      position: 102
      prefix: -P
  - id: output_vcf
    type:
      - 'null'
      - boolean
    doc: output in the VCF format (force -v)
    inputBinding:
      position: 102
      prefix: -c
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: reference genome
    default: 'null'
    inputBinding:
      position: 102
      prefix: -f
  - id: region
    type:
      - 'null'
      - string
    doc: region in format of 'ctg:start-end'
    default: 'null'
    inputBinding:
      position: 102
      prefix: -r
  - id: show_allele_counts_both_strands
    type:
      - 'null'
      - boolean
    doc: show count of each allele on both strands
    inputBinding:
      position: 102
      prefix: -C
  - id: show_variants_only
    type:
      - 'null'
      - boolean
    doc: show variants only
    inputBinding:
      position: 102
      prefix: -v
  - id: skip_bases_near_ends
    type:
      - 'null'
      - int
    doc: skip bases within INT-bp from either end of a read
    default: 0
    inputBinding:
      position: 102
      prefix: -T
  - id: use_star_for_deleted_bases
    type:
      - 'null'
      - boolean
    doc: use '*' to mark deleted bases
    inputBinding:
      position: 102
      prefix: -e
  - id: variant_calling_mode
    type:
      - 'null'
      - boolean
    doc: variant calling mode (-vcC -a2 -s5 -q30 -Q20)
    inputBinding:
      position: 102
      prefix: -y
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minipileup:1.4b--h577a1d6_0
stdout: minipileup.out

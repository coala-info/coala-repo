cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - var2vcf_valid.pl
label: vardict-java_var2vcf_valid.pl
doc: Convert VarDict output to VCF format with validation filtering
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input VarDict variant file(s)
    inputBinding:
      position: 1
  - id: p_mean_end_distance
    type:
      - 'null'
      - float
    doc: The mean distance to the nearest 5 or 3 prime read end filter
    inputBinding:
      position: 102
      prefix: -P
  - id: min_total_depth
    type:
      - 'null'
      - int
    doc: Minimum total depth
    inputBinding:
      position: 102
      prefix: -d
  - id: min_variant_depth
    type:
      - 'null'
      - int
    doc: Minimum variant depth
    inputBinding:
      position: 102
      prefix: -v
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    inputBinding:
      position: 102
      prefix: -f
  - id: min_mean_position
    type:
      - 'null'
      - float
    doc: Minimum mean position in reads
    inputBinding:
      position: 102
      prefix: -p
  - id: min_mean_base_quality
    type:
      - 'null'
      - float
    doc: Minimum mean base quality
    inputBinding:
      position: 102
      prefix: -q
  - id: min_strand_bias_p_value
    type:
      - 'null'
      - float
    doc: Strand bias Fisher p-value filter threshold
    inputBinding:
      position: 102
      prefix: -F
  - id: min_mapping_quality
    type:
      - 'null'
      - float
    doc: Minimum mean mapping quality
    inputBinding:
      position: 102
      prefix: -Q
  - id: strand_bias_odds_ratio
    type:
      - 'null'
      - float
    doc: Strand bias odds ratio threshold
    inputBinding:
      position: 102
      prefix: -o
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name
    inputBinding:
      position: 102
      prefix: -N
  - id: min_mismatches
    type:
      - 'null'
      - float
    doc: Mean mismatches in reads threshold
    inputBinding:
      position: 102
      prefix: -m
  - id: max_msi
    type:
      - 'null'
      - int
    doc: Microsatellite (MSI) filter threshold
    inputBinding:
      position: 102
      prefix: -I
  - id: cluster_distance
    type:
      - 'null'
      - int
    doc: Distance between variants for clustering filter
    inputBinding:
      position: 102
      prefix: -c
  - id: min_ref_reads
    type:
      - 'null'
      - int
    doc: Minimum reference reads threshold
    inputBinding:
      position: 102
      prefix: -r
  - id: min_sn_ratio
    type:
      - 'null'
      - float
    doc: Signal to noise threshold
    inputBinding:
      position: 102
      prefix: -O
  - id: max_extension
    type:
      - 'null'
      - int
    doc: Extension threshold
    inputBinding:
      position: 102
      prefix: -X
  - id: keep_flag
    type:
      - 'null'
      - string
    doc: Key/filter option
    inputBinding:
      position: 102
      prefix: -k
  - id: strict_var_depth
    type:
      - 'null'
      - int
    doc: Strict variant depth filter
    inputBinding:
      position: 102
      prefix: -V
  - id: max_homopolymer
    type:
      - 'null'
      - int
    doc: Maximum homopolymer length
    inputBinding:
      position: 102
      prefix: -M
  - id: max_nm
    type:
      - 'null'
      - float
    doc: Maximum mismatches in reads
    inputBinding:
      position: 102
      prefix: -x
  - id: amplicon_threshold
    type:
      - 'null'
      - int
    doc: Amplicon filter threshold
    inputBinding:
      position: 102
      prefix: -T
  - id: bed_overlap
    type:
      - 'null'
      - int
    doc: Bed overlap buffer
    inputBinding:
      position: 102
      prefix: -b
  - id: filter_gt
    type:
      - 'null'
      - string
    doc: Genotype filter option
    inputBinding:
      position: 102
      prefix: -G
  - id: filter_unmapped
    type:
      - 'null'
      - boolean
    doc: Indicate unmapped/unique filter
    inputBinding:
      position: 102
      prefix: -u
  - id: trim_bases
    type:
      - 'null'
      - boolean
    doc: Trim bases
    inputBinding:
      position: 102
      prefix: -t
  - id: amplicon_mode
    type:
      - 'null'
      - boolean
    doc: Indicate amplicon-based sequencing
    inputBinding:
      position: 102
      prefix: -a
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print header only
    inputBinding:
      position: 102
      prefix: -H
  - id: filter_somatic
    type:
      - 'null'
      - boolean
    doc: Filter strictly for somatic variants
    inputBinding:
      position: 102
      prefix: -S
  - id: compress_complex
    type:
      - 'null'
      - boolean
    doc: Indicate if complex variants should be compressed
    inputBinding:
      position: 102
      prefix: -C
  - id: extended_output
    type:
      - 'null'
      - boolean
    doc: Extended output info
    inputBinding:
      position: 102
      prefix: -E
  - id: all_variants
    type:
      - 'null'
      - boolean
    doc: Output all variants including those failing filters
    inputBinding:
      position: 102
      prefix: -A
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdout: var2vcf_valid.pl.out
s:url: https://github.com/joachimwolff/VarDictJava
$namespaces:
  s: https://schema.org/

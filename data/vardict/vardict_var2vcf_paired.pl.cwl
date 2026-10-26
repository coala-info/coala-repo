cwlVersion: v1.2
class: CommandLineTool
baseCommand: var2vcf_paired.pl
label: vardict_var2vcf_paired.pl
doc: 'Convert paired VarDict output (after testsomatic.R) into a validated VCF file.


  Tool homepage: https://github.com/AstraZeneca-NGS/VarDict'
inputs:
  - id: input_file
    type: File
    doc: Variant table from the VarDict paired pipeline (output of testsomatic.R).
    inputBinding:
      position: 200
  - id: chr_numbers
    type:
      - 'null'
      - boolean
    doc: If set, chromosomes will have names of 1,2,3,...,X,Y, instead of chr1, chr2,
      ..., chrX, chrY
    inputBinding:
      position: 102
      prefix: -C
  - id: somatic_filter_only
    type:
      - 'null'
      - boolean
    doc: If set, variants that didn't pass filters will not be present in VCF file
    inputBinding:
      position: 102
      prefix: -S
  - id: only_somatic
    type:
      - 'null'
      - boolean
    doc: If set, output only candidate somatic
    inputBinding:
      position: 102
      prefix: -M
  - id: all_variants
    type:
      - 'null'
      - boolean
    doc: Indicate to output all variants at the same position. By default, only the
      variant with the highest allele frequency is converted to VCF.
    inputBinding:
      position: 102
      prefix: -A
  - id: min_af_difference
    type:
      - 'null'
      - float
    doc: (Deprecated) The minimum allele frequency difference between two samples
      required in addition to p-value (0-1). Not compatible with -M.
    inputBinding:
      position: 102
      prefix: -D
  - id: cluster_distance
    type:
      - 'null'
      - int
    doc: 'If two somatic candidates are within {int} bp, they are both filtered. Default:
      0 or no filtering'
    inputBinding:
      position: 102
      prefix: -c
  - id: max_msi
    type:
      - 'null'
      - int
    doc: The maximum non-monomer MSI allowed for a HT variant with AF < 0.6. By default,
      12.
    inputBinding:
      position: 102
      prefix: -I
  - id: max_mean_mismatches
    type:
      - 'null'
      - int
    doc: 'The maximum mean mismatches allowed. Default: 5.25'
    inputBinding:
      position: 102
      prefix: -m
  - id: sample_names
    type:
      - 'null'
      - string
    doc: The sample name(s). If only one name is given, the matched will be named
      "name-match". Two names are given separated by "|", such as "tumor|blood".
    inputBinding:
      position: 102
      prefix: -N
  - id: max_pvalue
    type:
      - 'null'
      - float
    doc: The maximum p-value. Default to 0.05.
    inputBinding:
      position: 102
      prefix: -P
  - id: min_mean_position
    type:
      - 'null'
      - float
    doc: 'The minimum mean position of variants in the read. Default: 5.'
    inputBinding:
      position: 102
      prefix: -p
  - id: min_mean_base_quality
    type:
      - 'null'
      - float
    doc: The minimum mean base quality. Default to 22.5 for Illumina sequencing
    inputBinding:
      position: 102
      prefix: -q
  - id: min_mapping_quality
    type:
      - 'null'
      - float
    doc: The minimum mapping quality. Default to 0 for Illumina sequencing
    inputBinding:
      position: 102
      prefix: -Q
  - id: min_total_depth
    type:
      - 'null'
      - int
    doc: The minimum total depth. Default to 5
    inputBinding:
      position: 102
      prefix: -d
  - id: min_variant_depth
    type:
      - 'null'
      - int
    doc: The minimum variant depth. Default to 3
    inputBinding:
      position: 102
      prefix: -v
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: The minimum allele frequency. Default to 0.02
    inputBinding:
      position: 102
      prefix: -f
  - id: min_signal_noise
    type:
      - 'null'
      - float
    doc: The minimum signal to noise, or the ratio of hi/(lo+0.5). Default to 1.5.
    inputBinding:
      position: 102
      prefix: -o
  - id: min_homozygous_frequency
    type:
      - 'null'
      - float
    doc: The minimum allele frequency to consider to be homozygous. Default to 0.2.
    inputBinding:
      position: 102
      prefix: -F
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: var2vcf_paired.pl.out

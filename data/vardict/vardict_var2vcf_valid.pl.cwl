cwlVersion: v1.2
class: CommandLineTool
baseCommand: var2vcf_valid.pl
label: vardict_var2vcf_valid.pl
doc: 'Convert VarDict output (after teststrandbias.R) into a validated VCF file.


  Tool homepage: https://github.com/AstraZeneca-NGS/VarDict'
inputs:
  - id: input_file
    type: File
    doc: Variant table from the VarDict pipeline (output of teststrandbias.R).
    inputBinding:
      position: 200
  - id: somatic_filter_only
    type:
      - 'null'
      - boolean
    doc: If set, variants that didn't pass filters will not be present in VCF file
    inputBinding:
      position: 102
      prefix: -S
  - id: amplicon
    type:
      - 'null'
      - boolean
    doc: For amplicon based variant calling. Variant not supported by all amplicons
      will be considered false positive, with filter set to "AMPBIAS".
    inputBinding:
      position: 102
      prefix: -a
  - id: all_variants
    type:
      - 'null'
      - boolean
    doc: Indicate to output all variants at the same position. By default, only the
      variant with the highest allele frequency is converted to VCF.
    inputBinding:
      position: 102
      prefix: -A
  - id: cluster_distance
    type:
      - 'null'
      - int
    doc: 'If two seemingly high quality SNV variants are within {int} bp, they''re
      both filtered. Default: 0, or no filtering'
    inputBinding:
      position: 102
      prefix: -c
  - id: max_msi
    type:
      - 'null'
      - int
    doc: The maximum non-monomer MSI allowed for a HT variant with AF < 0.5. By default,
      12.
    inputBinding:
      position: 102
      prefix: -I
  - id: max_mean_mismatches
    type:
      - 'null'
      - float
    doc: 'The maximum mean mismatches allowed. Default: 5.25'
    inputBinding:
      position: 102
      prefix: -m
  - id: min_mean_position
    type:
      - 'null'
      - float
    doc: 'The minimum mean position of variants in the read. Default: 8.'
    inputBinding:
      position: 102
      prefix: -p
  - id: filter_pstd
    type:
      - 'null'
      - int
    doc: 'Whether to filter variants with pstd = 0 (0 or 1). Default: 1 or yes. Set
      it to 0 for targeted PCR based sequencing.'
    inputBinding:
      position: 102
      prefix: -P
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
    doc: The minimum mapping quality. Default to 10.0 for Illumina sequencing.
    inputBinding:
      position: 102
      prefix: -Q
  - id: min_total_depth
    type:
      - 'null'
      - int
    doc: The minimum total depth. Default to 3
    inputBinding:
      position: 102
      prefix: -d
  - id: min_variant_depth
    type:
      - 'null'
      - int
    doc: The minimum high quality variant depth. Default to 2.
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
  - id: sample_name
    type:
      - 'null'
      - string
    doc: The sample name to be used directly.
    inputBinding:
      position: 102
      prefix: -N
  - id: no_end_tag
    type:
      - 'null'
      - boolean
    doc: If set, do not print END tag
    inputBinding:
      position: 102
      prefix: -E
  - id: min_split_reads
    type:
      - 'null'
      - int
    doc: 'The minimum number of split reads for SV. Default: 1.'
    inputBinding:
      position: 102
      prefix: -T
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Path to the *.bed file which is used to generate contigs in the header
    inputBinding:
      position: 102
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: var2vcf_valid.pl.out

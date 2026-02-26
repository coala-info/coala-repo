cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimac4
label: minimac4_update-m3vcf
doc: "Performs imputation using reference panels.\n\nTool homepage: https://github.com/statgen/Minimac4"
inputs:
  - id: reference_msav
    type: File
    doc: Reference panel in MSAV format
    inputBinding:
      position: 1
  - id: target_file
    type: File
    doc: Target file in SAV, BCF, or VCF.gz format
    inputBinding:
      position: 2
  - id: all_typed_sites
    type:
      - 'null'
      - boolean
    doc: Include in the output sites that exist only in target VCF
    inputBinding:
      position: 103
      prefix: --all-typed-sites
  - id: chunk
    type:
      - 'null'
      - int
    doc: Maximum chunk length in base pairs to impute at once
    default: 20000000
    inputBinding:
      position: 103
      prefix: --chunk
  - id: compress_reference
    type:
      - 'null'
      - boolean
    doc: 'Compresses VCF to MVCF (default output: /dev/stdout)'
    inputBinding:
      position: 103
      prefix: --compress-reference
  - id: decay
    type:
      - 'null'
      - float
    doc: 'Decay rate for dosages in flanking regions (default: disabled with 0)'
    default: 0.0
    inputBinding:
      position: 103
      prefix: --decay
  - id: diff_threshold
    type:
      - 'null'
      - float
    doc: Probability diff threshold used in template selection
    inputBinding:
      position: 103
      prefix: --diff-threshold
  - id: empirical_output
    type:
      - 'null'
      - File
    doc: Output path for empirical dosages
    inputBinding:
      position: 103
      prefix: --empirical-output
  - id: format
    type:
      - 'null'
      - string
    doc: Comma-separated list of format fields to generate (GT, HDS, DS, GP, or 
      SD)
    default: HDS
    inputBinding:
      position: 103
      prefix: --format
  - id: map
    type:
      - 'null'
      - File
    doc: Genetic map file
    inputBinding:
      position: 103
      prefix: --map
  - id: match_error
    type:
      - 'null'
      - float
    doc: Error parameter for HMM match probabilities
    default: 0.01
    inputBinding:
      position: 103
      prefix: --match-error
  - id: max_block_size
    type:
      - 'null'
      - int
    doc: Maximum block size for unique haplotype compression
    default: 65535
    inputBinding:
      position: 103
      prefix: --max-block-size
  - id: min_block_size
    type:
      - 'null'
      - int
    doc: Minimium block size for unique haplotype compression
    default: 10
    inputBinding:
      position: 103
      prefix: --min-block-size
  - id: min_r2
    type:
      - 'null'
      - float
    doc: Minimum estimated r-square for output variants
    inputBinding:
      position: 103
      prefix: --min-r2
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio of number of target sites to reference sites
    default: '1e-4'
    inputBinding:
      position: 103
      prefix: --min-ratio
  - id: min_ratio_behavior
    type:
      - 'null'
      - string
    doc: Behavior for when --min-ratio is not met ("skip" or "fail")
    default: fail
    inputBinding:
      position: 103
      prefix: --min-ratio-behavior
  - id: min_recom
    type:
      - 'null'
      - float
    doc: Minimum recombination probability
    default: '1e-5'
    inputBinding:
      position: 103
      prefix: --min-recom
  - id: output_format
    type:
      - 'null'
      - string
    doc: Default output file format used for ambiguous filenames (bcf, sav, 
      vcf.gz, ubcf, usav, or vcf)
    default: sav
    inputBinding:
      position: 103
      prefix: --output-format
  - id: overlap
    type:
      - 'null'
      - int
    doc: Size (in base pairs) of overlap before and after impute region to use 
      as input to HMM
    default: 3000000
    inputBinding:
      position: 103
      prefix: --overlap
  - id: prob_threshold
    type:
      - 'null'
      - float
    doc: Probability threshold used for template selection
    inputBinding:
      position: 103
      prefix: --prob-threshold
  - id: prob_threshold_s1
    type:
      - 'null'
      - float
    doc: Probability threshold used for template selection in original state 
      space
    inputBinding:
      position: 103
      prefix: --prob-threshold-s1
  - id: region
    type:
      - 'null'
      - string
    doc: Genomic region to impute
    inputBinding:
      position: 103
      prefix: --region
  - id: sample_ids
    type:
      - 'null'
      - string
    doc: Comma-separated list of sample IDs to subset from reference panel
    inputBinding:
      position: 103
      prefix: --sample-ids
  - id: sample_ids_file
    type:
      - 'null'
      - File
    doc: Text file containing sample IDs to subset from reference panel (one ID 
      per line)
    inputBinding:
      position: 103
      prefix: --sample-ids-file
  - id: sites
    type:
      - 'null'
      - File
    doc: Output path for sites-only file
    inputBinding:
      position: 103
      prefix: --sites
  - id: slope_unit
    type:
      - 'null'
      - int
    doc: Parameter for unique haplotype compression heuristic
    default: 10
    inputBinding:
      position: 103
      prefix: --slope-unit
  - id: temp_buffer
    type:
      - 'null'
      - int
    doc: Number of samples to impute before writing to temporary files
    default: 200
    inputBinding:
      position: 103
      prefix: --temp-buffer
  - id: temp_prefix
    type:
      - 'null'
      - string
    doc: Prefix path for temporary output files
    default: ${TMPDIR}/m4_
    inputBinding:
      position: 103
      prefix: --temp-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: update_m3vcf
    type:
      - 'null'
      - boolean
    doc: 'Converts M3VCF to MVCF (default output: /dev/stdout)'
    inputBinding:
      position: 103
      prefix: --update-m3vcf
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimac4:4.1.6--hcb620b3_1

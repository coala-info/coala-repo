cwlVersion: v1.2
class: CommandLineTool
baseCommand: rseg
label: rseg
doc: "rseg [OPTIONS] <mapped-read-locations>\n\nTool homepage: https://github.com/yzhang/rseg"
inputs:
  - id: mapped_read_locations
    type: File
    doc: mapped-read-locations
    inputBinding:
      position: 1
  - id: background_distribution
    type:
      - 'null'
      - string
    doc: background emission distribution
    inputBinding:
      position: 102
      prefix: -bg
  - id: bin_size
    type:
      - 'null'
      - int
    doc: 'bin size (default: based on data)'
    inputBinding:
      position: 102
      prefix: -bin-size
  - id: cdf_cutoff
    type:
      - 'null'
      - float
    doc: cutoff in cdf for identified domains
    inputBinding:
      position: 102
      prefix: -cutoff
  - id: chromosome_sizes_file
    type:
      - 'null'
      - File
    doc: file with chromosome sizes (BED format)
    inputBinding:
      position: 102
      prefix: -chrom
  - id: deadezones_file
    type:
      - 'null'
      - File
    doc: file of deadzones (BED format)
    inputBinding:
      position: 102
      prefix: -deadzones
  - id: desert_size
    type:
      - 'null'
      - int
    doc: 'desert size (default: 20000)'
    inputBinding:
      position: 102
      prefix: -desert
  - id: expected_domain_size
    type:
      - 'null'
      - int
    doc: 'expected domain size (default: 20000)'
    inputBinding:
      position: 102
      prefix: -domain-size
  - id: extend_to_fragment_length
    type:
      - 'null'
      - boolean
    doc: Extend reads to fragment length (default not to extend)
    inputBinding:
      position: 102
      prefix: -fragment_length
  - id: foreground_distribution
    type:
      - 'null'
      - string
    doc: foreground emission distribution
    inputBinding:
      position: 102
      prefix: -fg
  - id: hideaki_empirical_method
    type:
      - 'null'
      - boolean
    doc: use Hideaki's empirical method (default)
    inputBinding:
      position: 102
      prefix: -Hideaki-emp
  - id: hideaki_method
    type:
      - 'null'
      - boolean
    doc: use Hideaki's method for bin size
    inputBinding:
      position: 102
      prefix: -Hideaki
  - id: input_bam
    type:
      - 'null'
      - boolean
    doc: Input reads file is BAM format
    inputBinding:
      position: 102
      prefix: -bam
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: keep duplicate reads
    inputBinding:
      position: 102
      prefix: -duplicates
  - id: max_deadzone_proportion
    type:
      - 'null'
      - float
    doc: max deadzone proportion for retained bins
    inputBinding:
      position: 102
      prefix: -max-dead
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: maximum iterations for training
    inputBinding:
      position: 102
      prefix: -maxitr
  - id: min_bin_size
    type:
      - 'null'
      - int
    doc: 'minimum bin size (default: 50)'
    inputBinding:
      position: 102
      prefix: -bin-step
  - id: min_unmappable_region_size
    type:
      - 'null'
      - int
    doc: min size of unmappable region
    inputBinding:
      position: 102
      prefix: -undefined
  - id: param_in_file
    type:
      - 'null'
      - File
    doc: Input parameters file
    inputBinding:
      position: 102
      prefix: -param-in
  - id: posterior_cutoff_significance
    type:
      - 'null'
      - float
    doc: posterior cutoff significance
    inputBinding:
      position: 102
      prefix: -posterior-cutoff
  - id: smooth_rate_curve
    type:
      - 'null'
      - boolean
    doc: Indicate whether the rate curve is assumed smooth
    inputBinding:
      position: 102
      prefix: -smooth
  - id: use_posterior_decoding
    type:
      - 'null'
      - boolean
    doc: 'use posterior decoding (default: Viterbi)'
    inputBinding:
      position: 102
      prefix: -posterior
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run information
    inputBinding:
      position: 102
      prefix: -verbose
  - id: waterman_method
    type:
      - 'null'
      - boolean
    doc: use Waterman's method for bin size
    inputBinding:
      position: 102
      prefix: -Waterman
  - id: boundary_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `boundary_file_path`
    inputBinding:
      position: 103
      prefix: --boundary-file
  - id: boundary_score_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `boundary_score_file_path`
    inputBinding:
      position: 104
      prefix: --boundary-score-file
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 105
      prefix: --output-file
  - id: param_out_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `param_out_file_path`
    inputBinding:
      position: 106
      prefix: --param-out-file
  - id: readcount_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `readcount_file_path`
    inputBinding:
      position: 107
      prefix: --readcount-file
  - id: score_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `score_file_path`
    inputBinding:
      position: 108
      prefix: --score-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: domain output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: score_file
    type:
      - 'null'
      - File
    doc: Posterior scores file
    outputBinding:
      glob: $(inputs.score_file_path)
  - id: readcount_file
    type:
      - 'null'
      - File
    doc: readcounts file
    outputBinding:
      glob: $(inputs.readcount_file_path)
  - id: boundary_file
    type:
      - 'null'
      - File
    doc: domain boundary file
    outputBinding:
      glob: $(inputs.boundary_file_path)
  - id: boundary_score_file
    type:
      - 'null'
      - File
    doc: boundary transition scores file
    outputBinding:
      glob: $(inputs.boundary_score_file_path)
  - id: param_out_file
    type:
      - 'null'
      - File
    doc: Output parameters file
    outputBinding:
      glob: $(inputs.param_out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseg:0.4.9--he941832_1

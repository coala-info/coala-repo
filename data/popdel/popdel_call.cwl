cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popdel, call]
label: popdel_call
doc: "Performs joint-calling of deletions using a list of profile-files previously created using the 'popdel profile' command. The input profiles are either specified directly as arguments or listed in PROFILE-LIST-FILE (one filename per line).\n\nTool homepage: https://github.com/kehrlab/PopDel"
inputs:
  - id: active_coverage_file
    type:
      - 'null'
      - File
    doc: "File with lines consisting of \"ReadGroup maxCov\". If this value is reached no more new reads are loaded for this read group until the coverage drops again. A value of 0 disables the filter for the read group."
    inputBinding:
      position: 1
      prefix: --active-coverage-file
  - id: active_coverage
    type:
      - 'null'
      - int
    doc: "Maximum number of active read pairs (~coverage). Taken for all read groups not listed in 'active-coverage-file'. Setting it to 0 disables the filter. In range [0..inf]. Default: 100."
    inputBinding:
      position: 1
      prefix: --active-coverage
  - id: max_deletion_size
    type:
      - 'null'
      - int
    doc: "Maximum size of deletions. Default: 10000."
    inputBinding:
      position: 1
      prefix: --max-deletion-size
  - id: per_sample_rgid
    type:
      - 'null'
      - boolean
    doc: "Internally modify each read group ID by adding the filename. Use if read groups across different samples have conflicting IDs."
    inputBinding:
      position: 1
      prefix: --per-sample-rgid
  - id: min_init_length
    type:
      - 'null'
      - int
    doc: "Minimal deletion length at initialization of iteration. Default: 4 * standard deviation."
    inputBinding:
      position: 1
      prefix: --min-init-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimal deletion length during iteration. Default: 95th percentile of min-init-lengths."
    inputBinding:
      position: 1
      prefix: --min-length
  - id: out_path
    type: string
    doc: "Output file name (VCF)."
    inputBinding:
      position: 1
      prefix: --out
  - id: region_of_interest
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --region-of-interest
    doc: "Genomic region 'chr:start-end' (closed interval, 1-based index). Calling is limited to this region."
    inputBinding:
      position: 1
  - id: roi_file
    type:
      - 'null'
      - File
    doc: "File listing one or more regions of interest, one region per line."
    inputBinding:
      position: 1
      prefix: --ROI-file
  - id: min_sample_fraction
    type:
      - 'null'
      - float
    doc: "Minimum fraction of samples which is required to have enough data in the window. In range [0.0..1.0]. Default: 0.1."
    inputBinding:
      position: 1
      prefix: --min-sample-fraction
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: "Number of buffered windows. In range [10000..inf]. Default: 200000."
    inputBinding:
      position: 1
      prefix: --buffer-size
  - id: min_relative_window_cover
    type:
      - 'null'
      - float
    doc: "Fraction of a deletion that has to be covered by significant windows. In range [0.0..2.0]. Default: 0.5."
    inputBinding:
      position: 1
      prefix: --min-relative-window-cover
  - id: pseudocount_fraction
    type:
      - 'null'
      - int
    doc: "The biggest likelihood of the background distribution is divided by this value to determine the pseudocounts of the histogram. In range [50..inf]. Default: 500."
    inputBinding:
      position: 1
      prefix: --pseudocount-fraction
  - id: output_failed
    type:
      - 'null'
      - boolean
    doc: "Also output calls which did not pass the filters."
    inputBinding:
      position: 1
      prefix: --output-failed
  - id: no_regenotyping
    type:
      - 'null'
      - boolean
    doc: "Outputs every potential variant window without re-genotyping and merging."
    inputBinding:
      position: 1
      prefix: --no-regenotyping
  - id: prior_probability
    type:
      - 'null'
      - float
    doc: "Prior probability of a deletion. In range [0.0..0.9999]. Default: 0.0001."
    inputBinding:
      position: 1
      prefix: --prior-probability
  - id: iterations
    type:
      - 'null'
      - int
    doc: "Number of iterations in EM for length estimation. Default: 15."
    inputBinding:
      position: 1
      prefix: --iterations
  - id: unsmoothed
    type:
      - 'null'
      - boolean
    doc: "Disable the smoothing of the insert size histogram."
    inputBinding:
      position: 1
      prefix: --unsmoothed
  - id: uncompressed_in
    type:
      - 'null'
      - boolean
    doc: "Read uncompressed PopDel profiles."
    inputBinding:
      position: 1
      prefix: --uncompressed-in
  - id: profile_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Profile files created by popdel profile (two or more)"
    inputBinding:
      position: 100
  - id: profile_list_file
    type:
      - 'null'
      - File
    doc: "File listing one profile file name per line (use instead of profile_files)"
    inputBinding:
      position: 101
  - id: listed_profiles
    type:
      - 'null'
      - type: array
        items: File
    doc: "Profile files named in profile_list_file; staged next to it so the names resolve"
outputs:
  - id: vcf
    type: File
    doc: "VCF file with the deletion calls"
    outputBinding:
      glob: "$(inputs.out_path)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.listed_profiles || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1

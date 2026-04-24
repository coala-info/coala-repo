cwlVersion: v1.2
class: CommandLineTool
baseCommand: PopDel
label: popdel_call
doc: "Performs joint-calling of deletions using a list of profile-files previously
  created using the 'popdel profile' command. The input profiles are either specified
  directly as arguments or listed in PROFILE-LIST-FILE (one filename per line).\n\n\
  Tool homepage: https://github.com/kehrlab/PopDel"
inputs:
  - id: profile_files
    type:
      type: array
      items: File
    doc: Profile files to process
    inputBinding:
      position: 1
  - id: rofile_list_file
    type: File
    doc: File containing a list of profile files
    inputBinding:
      position: 2
  - id: active_coverage
    type:
      - 'null'
      - float
    doc: Maximum number of active read pairs (~coverage). This value is taken 
      for all read groups that are not listed in 'active-coverage-file'. Setting
      it to 0 disables the filter for all read groups that are not specified in 
      'active-coverage-file'. In range [0..inf].
    inputBinding:
      position: 103
      prefix: --active-coverage
  - id: active_coverage_file
    type:
      - 'null'
      - File
    doc: File with lines consisting of "ReadGroup maxCov". If this value is 
      reached no more new reads are loaded for this read group until the 
      coverage drops again. Further, the sample will be excluded from calling in
      high-coverage windows. A value of 0 disables the filter for the read 
      group.
    inputBinding:
      position: 103
      prefix: --active-coverage-file
  - id: max_deletion_size
    type:
      - 'null'
      - int
    doc: Maximum size of deletions.
    inputBinding:
      position: 103
      prefix: --max-deletion-size
  - id: min_init_length
    type:
      - 'null'
      - string
    doc: 'Minimal deletion length at initialization of iteration. Default: 4 * standard
      deviation.'
    inputBinding:
      position: 103
      prefix: --min-init-length
  - id: min_length
    type:
      - 'null'
      - string
    doc: 'Minimal deletion length during iteration. Default: 95th percentile of min-init-lengths.'
    inputBinding:
      position: 103
      prefix: --min-length
  - id: min_sample_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction of samples which is required to have enough data in 
      the window. In range [0.0..1.0].
    inputBinding:
      position: 103
      prefix: --min-sample-fraction
  - id: per_sample_rgid
    type:
      - 'null'
      - boolean
    doc: Internally modify each read group ID by adding the filename. This can 
      be used if read groups across different samples have conflicting IDs.
    inputBinding:
      position: 103
      prefix: --per-sample-rgid
  - id: region_of_interest
    type:
      - 'null'
      - type: array
        items: string
    doc: Genomic region 'chr:start-end' (closed interval, 1-based index). 
      Calling is limited to this region. Multiple regions can be defined by 
      using the parameter -r multiple times.
    inputBinding:
      position: 103
      prefix: --region-of-interest
  - id: roi_file
    type:
      - 'null'
      - File
    doc: File listing one or more regions of interest, one region per line. See 
      parameter -r.
    inputBinding:
      position: 103
      prefix: --ROI-file
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1

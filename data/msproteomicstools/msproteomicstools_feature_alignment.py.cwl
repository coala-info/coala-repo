cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - feature_alignment.py
label: msproteomicstools_feature_alignment.py
doc: "Select all peakgroups below the FDR cutoff in all files and align them to each other. With one file it acts as peakgroup selector (best by m_score) and applies the FDR cutoff.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infiles
    type: 'File[]'
    doc: "A list of mProphet output files containing all peakgroups"
    inputBinding:
      prefix: --in
      valueFrom: $(self.map(function(f){return f.basename;}))
  - id: file_format
    type: ['null', string]
    doc: "Input file format (openswath, mprophet or peakview)"
    inputBinding:
      prefix: --file_format
  - id: output_path
    type: string
    doc: "Output file with filtered peakgroups"
    inputBinding:
      prefix: --out
  - id: out_matrix
    type: ['null', string]
    doc: "Matrix containing one peak group per row (supports .csv, .tsv or .xlsx)"
    inputBinding:
      prefix: --out_matrix
  - id: out_ids
    type: ['null', string]
    doc: "Id file only containing the ids"
    inputBinding:
      prefix: --out_ids
  - id: out_meta
    type: ['null', string]
    doc: "Outfile containing meta information"
    inputBinding:
      prefix: --out_meta
  - id: fdr_cutoff
    type: ['null', float]
    doc: "Fixed FDR cutoff used for seeding (default 0.01)"
    inputBinding:
      prefix: --fdr_cutoff
  - id: target_fdr
    type: ['null', float]
    doc: "If parameter estimation is used, which target FDR should be optimized for; lower than 0 turns it off (default -1)"
    inputBinding:
      prefix: --target_fdr
  - id: max_fdr_quality
    type: ['null', float]
    doc: "Extension m-score cutoff, peakgroups of this quality are still considered for alignment during extension (default -1)"
    inputBinding:
      prefix: --max_fdr_quality
  - id: max_rt_diff
    type: ['null', float]
    doc: "Maximal difference in RT (in seconds) for two aligned features (default 30)"
    inputBinding:
      prefix: --max_rt_diff
  - id: iso_max_rt_diff
    type: ['null', float]
    doc: "Maximal difference in RT (in seconds) for two isotopic channels in the same run"
    inputBinding:
      prefix: --iso_max_rt_diff
  - id: frac_selected
    type: ['null', float]
    doc: "Do not write peakgroup if selected in less than this fraction of runs (range 0 to 1)"
    inputBinding:
      prefix: --frac_selected
  - id: method
    type: ['null', string]
    doc: "Method to use for the clustering (best_overall, best_cluster_score, global_best_cluster_score, global_best_overall, LocalMST, LocalMSTAllCluster)"
    inputBinding:
      prefix: --method
  - id: verbosity
    type: ['null', int]
    doc: "Verbosity (0 = little)"
    inputBinding:
      prefix: --verbosity
  - id: matrix_output_method
    type: ['null', string]
    doc: "Which columns are written besides Intensity (none, RT, score, source or full)"
    inputBinding:
      prefix: --matrix_output_method
  - id: realign_method
    type: ['null', string]
    doc: "RT alignment method (diRT, linear, splineR, splineR_external, splinePy, lowess, lowess_biostats, lowess_statsmodels, lowess_cython, nonCVSpline, CVSpline, Earth, WeightedNearestNeighbour, SmoothLLDMedian, None)"
    inputBinding:
      prefix: --realign_method
  - id: force
    type: ['null', boolean]
    doc: "Force alignment"
    inputBinding:
      prefix: --force
  - id: mst_use_rt_correction
    type: ['null', string]
    doc: "Use aligned peakgroup RT to continue threading (True or False)"
    inputBinding:
      prefix: --mst:useRTCorrection
  - id: mst_stdev_multiplier
    type: ['null', float]
    doc: "How many standard deviations the peakgroup can deviate in RT during the alignment"
    inputBinding:
      prefix: --mst:Stdev_multiplier
  - id: mst_use_local_stdev
    type: ['null', string]
    doc: "Use local standard deviation of the alignment (True or False)"
    inputBinding:
      prefix: --mst:useLocalStdev
  - id: mst_use_reference
    type: ['null', string]
    doc: "Use a reference-based tree for alignment (True or False)"
    inputBinding:
      prefix: --mst:useReference
  - id: disable_isotopic_grouping
    type: ['null', boolean]
    doc: "Disable grouping of isotopic variants by peptide_group_label"
    inputBinding:
      prefix: --disable_isotopic_grouping
  - id: use_dscore_filter
    type: ['null', boolean]
    doc: "Use the d-score filter"
    inputBinding:
      prefix: --use_dscore_filter
  - id: dscore_cutoff
    type: ['null', float]
    doc: "Discard all peakgroups below this d-score (default 1.96)"
    inputBinding:
      prefix: --dscore_cutoff
  - id: nr_high_conf_exp
    type: ['null', int]
    doc: "Number of experiments in which the peptide needs to be identified with confidence above fdr_cutoff"
    inputBinding:
      prefix: --nr_high_conf_exp
  - id: readmethod
    type: ['null', string]
    doc: "Read full or minimal transition groups (cminimal, minimal, full)"
    inputBinding:
      prefix: --readmethod
  - id: tmpdir
    type: ['null', string]
    doc: "Temporary directory"
    inputBinding:
      prefix: --tmpdir
  - id: alignment_score
    type: ['null', float]
    doc: "Minimal score needed for a feature to be considered for alignment between runs (default 0.0001)"
    inputBinding:
      prefix: --alignment_score
  - id: realign_runs
    type: ['null', boolean]
    doc: "Deprecated option (equals --realign_method external_r)"
    inputBinding:
      prefix: --realign_runs
  - id: use_external_r
    type: ['null', boolean]
    doc: "Deprecated option (equals --realign_method external_r)"
    inputBinding:
      prefix: --use_external_r
outputs:
  - id: output
    type: File
    doc: "Output file with filtered peakgroups"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: matrix
    type: ['null', File]
    doc: "Matrix with one peak group per row"
    outputBinding:
      glob: "$(inputs.out_matrix)"
  - id: ids
    type: ['null', File]
    doc: "Id file"
    outputBinding:
      glob: "$(inputs.out_ids)"
  - id: meta
    type: ['null', File]
    doc: "Meta information file"
    outputBinding:
      glob: "$(inputs.out_meta)"
  - id: transformation_files
    type: 'File[]'
    doc: "Transformation files written for each run"
    outputBinding:
      glob: "*.tr"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.infiles)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_feature_alignment.py.out

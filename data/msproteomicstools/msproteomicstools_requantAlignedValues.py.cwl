cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - requantAlignedValues.py
label: msproteomicstools_requantAlignedValues.py
doc: "Impute missing values: requantify aligned peakgroups in the chromatogram files of all runs.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: transformation_files
    type: ['null', 'File[]']
    doc: "Transformation files (.tr) in the same folder as the .chrom.mzML files"
    inputBinding:
      prefix: --in
      valueFrom: $(self.map(function(f){return f.basename;}))
  - id: chromatogram_files
    type: ['null', 'File[]']
    doc: "Chromatogram files (.chrom.mzML or .sqMass) that belong to the transformation files"
  - id: peakgroups_infile
    type: File
    doc: "Infile containing peakgroups (outfile from feature_alignment.py)"
    inputBinding:
      prefix: --peakgroups_infile
  - id: output_path
    type: string
    doc: "Output file with imputed values"
    inputBinding:
      prefix: --out
  - id: file_format
    type: ['null', string]
    doc: "Which input file format is used (openswath, mprophet or peakview)"
    inputBinding:
      prefix: --file_format
  - id: out_matrix
    type: ['null', string]
    doc: "Matrix containing one peak group per row (supports .csv, .tsv or .xls)"
    inputBinding:
      prefix: --out_matrix
  - id: matrix_output_method
    type: ['null', string]
    doc: "Which columns are written besides Intensity (none, RT, score, source or full)"
    inputBinding:
      prefix: --matrix_output_method
  - id: border_option
    type: ['null', string]
    doc: "How to determine integration border (max_width, mean, median)"
    inputBinding:
      prefix: --border_option
  - id: dry_run
    type: ['null', boolean]
    doc: "Perform a dry run only"
    inputBinding:
      prefix: --dry_run
  - id: test
    type: ['null', boolean]
    doc: "For running the tests (does not add a random id to the results)"
    inputBinding:
      prefix: --test
  - id: cache_in_memory
    type: ['null', boolean]
    doc: "Cache data from a single run in memory"
    inputBinding:
      prefix: --cache_in_memory
  - id: method
    type: ['null', string]
    doc: "Which method to use (singleShortestPath, singleClosestRun, reference)"
    inputBinding:
      prefix: --method
  - id: realign_runs
    type: ['null', string]
    doc: "How to re-align runs in retention time (diRT, linear, splineR, splineR_external, splinePy, lowess, nonCVSpline, CVSpline, Earth, None)"
    inputBinding:
      prefix: --realign_runs
  - id: verbosity
    type: ['null', int]
    doc: "Verbosity"
    inputBinding:
      prefix: --verbosity
  - id: do_single_run
    type: ['null', File]
    doc: "Only do a single run (a .chrom.mzML or .sqMass file)"
    inputBinding:
      prefix: --do_single_run
      valueFrom: $(self.basename)
  - id: alignment_score
    type: ['null', float]
    doc: "Minimal score needed for a feature to be considered for alignment between runs"
    inputBinding:
      prefix: --alignment_score
  - id: disable_isotopic_grouping
    type: ['null', boolean]
    doc: "Disable grouping of isotopic variants by peptide_group_label"
    inputBinding:
      prefix: --disable_isotopic_grouping
  - id: disable_isotopic_transfer
    type: ['null', boolean]
    doc: "Disable the transfer of isotopic boundaries in all cases"
    inputBinding:
      prefix: --disable_isotopic_transfer
outputs:
  - id: output
    type: File
    doc: "Output file with imputed values"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: matrix
    type: ['null', File]
    doc: "Matrix with one peak group per row"
    outputBinding:
      glob: "$(inputs.out_matrix)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.transformation_files)
        writable: true
      - entry: $(inputs.chromatogram_files)
        writable: true
      - entry: $(inputs.do_single_run)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_requantAlignedValues.py.out

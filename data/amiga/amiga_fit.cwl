cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amiga
  - fit
label: amiga_fit
doc: "Fit growth curves\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: input
    type: Directory
    doc: "AMiGA working directory with data (and optional mapping) folders, or a data file inside it"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: ['null', string]
    doc: "Base name for the output summary and GP data files"
    inputBinding:
      position: 1
      prefix: --output
  - id: flag
    type: ['null', string]
    doc: "Wells or plates to flag and exclude (e.g. 'Plate_ID:A1,B1')"
    inputBinding:
      position: 1
      prefix: --flag
  - id: subset
    type: ['null', string]
    doc: "Subset of samples to analyze (e.g. 'Substrate:Glucose;Ribotype:RT027')"
    inputBinding:
      position: 1
      prefix: --subset
  - id: interval
    type: ['null', string]
    doc: "Time interval between measurements, in seconds (single value or per-plate 'Plate_ID:600')"
    inputBinding:
      position: 1
      prefix: --interval
  - id: time_step_size
    type: ['null', int]
    doc: "Use every n-th time point (thinning); default 1"
    inputBinding:
      position: 1
      prefix: --time-step-size
  - id: skip_first_n
    type: ['null', int]
    doc: "Skip the first n time points; default 0"
    inputBinding:
      position: 1
      prefix: --skip-first-n
  - id: do_not_log_transform
    type: ['null', boolean]
    doc: "Do not log-transform the optical density"
    inputBinding:
      position: 1
      prefix: --do-not-log-transform
  - id: subtract_blanks
    type: ['null', boolean]
    doc: "Subtract blank wells from the data"
    inputBinding:
      position: 1
      prefix: --subtract-blanks
  - id: subtract_control
    type: ['null', boolean]
    doc: "Subtract control wells from the data"
    inputBinding:
      position: 1
      prefix: --subtract-control
  - id: keep_missing_time_points
    type: ['null', boolean]
    doc: "Keep time points with missing values"
    inputBinding:
      position: 1
      prefix: --keep-missing-time-points
  - id: verbose
    type: ['null', boolean]
    doc: "Print verbose messages"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: plot
    type: ['null', boolean]
    doc: "Plot the fitted curves"
    inputBinding:
      position: 1
      prefix: --plot
  - id: plot_derivative
    type: ['null', boolean]
    doc: "Plot the derivative of the fitted curves"
    inputBinding:
      position: 1
      prefix: --plot-derivative
  - id: pool_by
    type: ['null', string]
    doc: "Meta-data variables used to pool replicates (e.g. 'Isolate,Substrate')"
    inputBinding:
      position: 1
      prefix: --pool-by
  - id: save_cleaned_data
    type: ['null', boolean]
    doc: "Save the cleaned data to the derived folder"
    inputBinding:
      position: 1
      prefix: --save-cleaned-data
  - id: save_mapping_tables
    type: ['null', boolean]
    doc: "Save the mapping tables to the mapping folder"
    inputBinding:
      position: 1
      prefix: --save-mapping-tables
  - id: save_gp_data
    type: ['null', boolean]
    doc: "Save GP-predicted curves to the derived folder"
    inputBinding:
      position: 1
      prefix: --save-gp-data
  - id: merge_summary
    type: ['null', boolean]
    doc: "Merge summaries of all plates into one file"
    inputBinding:
      position: 1
      prefix: --merge-summary
  - id: fix_noise
    type: ['null', boolean]
    doc: "Fix the measurement noise to the empirically estimated value"
    inputBinding:
      position: 1
      prefix: --fix-noise
  - id: sample_posterior
    type: ['null', boolean]
    doc: "Sample the posterior to estimate parameter confidence"
    inputBinding:
      position: 1
      prefix: --sample-posterior
outputs:
  - id: working_dir
    type: Directory
    doc: The AMiGA working directory with the new summary, derived, figures and models folders
    outputBinding:
      glob: $(inputs.input.basename)
  - id: summary_files
    type: File[]
    doc: Summary tables written to the summary folder
    outputBinding:
      glob: $(inputs.input.basename)/summary/*
  - id: figures
    type: File[]
    doc: Figures written to the figures folder
    outputBinding:
      glob: $(inputs.input.basename)/figures/*
  - id: derived_files
    type: File[]
    doc: GP data and cleaned data written to the derived folder
    outputBinding:
      glob: $(inputs.input.basename)/derived/*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1

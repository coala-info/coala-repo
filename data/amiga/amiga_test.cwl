cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amiga
  - test
label: amiga_test
doc: "Test for differential growth between two conditions\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: input
    type: Directory
    doc: "AMiGA working directory with data and mapping folders, or a data file inside it"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: ['null', string]
    doc: "Base name for the model results folder and files"
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
  - id: hypothesis
    type: string
    doc: "Hypothesis to test (e.g. 'H0:Time;H1:Time+Substrate')"
    inputBinding:
      position: 1
      prefix: --hypothesis
  - id: skip_first_n
    type: ['null', int]
    doc: "Skip the first n time points; default 0"
    inputBinding:
      position: 1
      prefix: --skip-first-n
  - id: time_step_size
    type: ['null', int]
    doc: "Use every n-th time point (thinning); default 1"
    inputBinding:
      position: 1
      prefix: --time-step-size
  - id: number_permutations
    type: ['null', int]
    doc: "Number of permutations for the null distribution; default 0"
    inputBinding:
      position: 1
      prefix: --number-permutations
  - id: false_discovery_rate
    type: ['null', int]
    doc: "False discovery rate, in percent; default 10"
    inputBinding:
      position: 1
      prefix: --false-discovery-rate
  - id: confidence
    type: ['null', float]
    doc: "Must be between 80 and 100. Default is 95."
    inputBinding:
      position: 1
      prefix: --confidence
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
  - id: verbose
    type: ['null', boolean]
    doc: "Print verbose messages"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: fix_noise
    type: ['null', boolean]
    doc: "Fix the measurement noise to the empirically estimated value"
    inputBinding:
      position: 1
      prefix: --fix-noise
  - id: include_gaussian_noise
    type: ['null', boolean]
    doc: "Include Gaussian noise in the predicted curves"
    inputBinding:
      position: 1
      prefix: --include-gaussian-noise
  - id: sample_posterior
    type: ['null', boolean]
    doc: "Sample the posterior to estimate parameter confidence"
    inputBinding:
      position: 1
      prefix: --sample-posterior
  - id: dont_plot
    type: ['null', boolean]
    doc: "Do not plot the test results"
    inputBinding:
      position: 1
      prefix: --dont-plot
  - id: dont_plot_delta_od
    type: ['null', boolean]
    doc: "Do not plot the difference in OD"
    inputBinding:
      position: 1
      prefix: --dont-plot-delta-od
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
  - id: do_not_log_transform
    type: ['null', boolean]
    doc: "Do not log-transform the optical density"
    inputBinding:
      position: 1
      prefix: --do-not-log-transform
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
  - id: model_files
    type: File[]
    doc: Test results written to the models folder (log, report and plots)
    outputBinding:
      glob: $(inputs.input.basename)/models/*/*
successCodes: [0, 1]
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1

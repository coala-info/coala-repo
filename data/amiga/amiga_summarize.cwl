cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amiga
  - summarize
label: amiga_summarize
doc: "Perform a basic summary and plot curves\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: input
    type: Directory
    doc: "AMiGA working directory with data (and optional mapping) folders, or a data file inside it"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: ['null', string]
    doc: "Base name for the merged summary file"
    inputBinding:
      position: 1
      prefix: --output
  - id: dont_plot
    type: ['null', boolean]
    doc: "Do not plot the plates"
    inputBinding:
      position: 1
      prefix: --dont-plot
  - id: merge_summary
    type: ['null', boolean]
    doc: "Merge summaries of all plates into one file"
    inputBinding:
      position: 1
      prefix: --merge-summary
  - id: verbose
    type: ['null', boolean]
    doc: "Print verbose messages"
    inputBinding:
      position: 1
      prefix: --verbose
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
  - id: hypothesis
    type: ['null', string]
    doc: "Hypothesis used to select the variables to summarize (e.g. 'H0:Time;H1:Time+Substrate')"
    inputBinding:
      position: 1
      prefix: --hypothesis
  - id: interval
    type: ['null', string]
    doc: "Time interval between measurements, in seconds (single value or per-plate 'Plate_ID:600')"
    inputBinding:
      position: 1
      prefix: --interval
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
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1

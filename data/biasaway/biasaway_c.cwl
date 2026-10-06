cwlVersion: v1.2
class: CommandLineTool
baseCommand: [biasaway, c]
requirements:
  - class: InlineJavascriptRequirement
label: biasaway_c
doc: "%GC distribution and %GC composition within a sliding window background chooser\n\nTool homepage:\
  \ https://github.com/asntech/biasaway"
inputs:
  - id: foreground
    type: File
    doc: Foreground file in fasta format
    inputBinding:
      position: 1
      prefix: --foreground
  - id: bgdirectory
    type:
      - 'null'
      - string
    doc: Name of a new background directory to create from --background (must be empty or absent)
    inputBinding:
      position: 1
      prefix: --bgdirectory
  - id: precomputed_bgdirectory
    type:
      - 'null'
      - Directory
    doc: Background directory computed by a previous run (use instead of --background and bgdirectory)
    inputBinding:
      position: 1
      prefix: --bgdirectory
  - id: background
    type:
      - 'null'
      - File
    doc: Background file in fasta format. Not necessary if a background directory has already been computed
      previously.
    inputBinding:
      position: 1
      prefix: --background
  - id: winlen
    type:
      - 'null'
      - int
    doc: 'Window length (default: 100)'
    inputBinding:
      position: 1
      prefix: --winlen
  - id: step
    type:
      - 'null'
      - int
    doc: 'Sliding step (default: 50)'
    inputBinding:
      position: 1
      prefix: --step
  - id: deviation
    type:
      - 'null'
      - float
    doc: 'Deviation from the mean (default: 2.6 for a threshold of mean + 2.6 * stdev)'
    inputBinding:
      position: 1
      prefix: --deviation
  - id: nfold
    type:
      - 'null'
      - int
    doc: 'How many background sequences per each foreground sequence will be choosen (default: 1)'
    inputBinding:
      position: 1
      prefix: --nfold
  - id: length
    type:
      - 'null'
      - boolean
    doc: Try to match the length as closely as possible
    inputBinding:
      position: 1
      prefix: --length
  - id: plot_filename
    type:
      - 'null'
      - string
    doc: 'Basename for the QC plot and metric files (default: no QC plot created)'
    inputBinding:
      position: 1
      prefix: --plot_filename
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed number to initialize the random number generator
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: background_sequences
    type: stdout
    doc: Background sequences in fasta format
  - id: qc_plots
    type:
      - 'null'
      - File[]
    doc: QC plots (png) and metric files (txt)
    outputBinding:
      glob:
        - '$(inputs.plot_filename ? inputs.plot_filename + ''*.png'' : [])'
        - '$(inputs.plot_filename ? inputs.plot_filename + ''*.txt'' : [])'
  - id: bgdirectory_out
    type:
      - 'null'
      - Directory
    doc: Background directory computed from --background (reusable with precomputed_bgdirectory)
    outputBinding:
      glob: $(inputs.bgdirectory)
stdout: $(inputs.foreground.nameroot)_background.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biasaway:3.3.0--py_0

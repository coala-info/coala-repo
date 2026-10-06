cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barseqcount
  - analyze
label: barseqcount_analyze
doc: "Analyze barseqcount results\n\nTool homepage: https://github.com/damienmarsic/barseqcount"
inputs:
  - id: configuration_file
    type:
      - 'null'
      - File
    doc: 'Configuration file for the barseqcount analyze program (default: barseqcount_analyze.conf),
      will be created if absent'
    inputBinding:
      position: 101
      prefix: --configuration_file
  - id: file_format
    type:
      - 'null'
      - string
    doc: 'Save each figure in separate file with choice of format instead of the default
      single multipage pdf file. Choices: svg, png, jpg, pdf, ps, eps, pgf, raw, rgba,
      tif'
    inputBinding:
      position: 101
      prefix: --file_format
  - id: new
    type:
      - 'null'
      - boolean
    doc: Create new configuration file and rename existing one
    inputBinding:
      position: 101
      prefix: --new
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files from barseqcount count (<project>_count_report.txt and <project>_count.csv)
      staged in the working directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: figures
    type:
      type: array
      items: File
    doc: Plots (multipage PDF, or one file per figure with --file_format)
    outputBinding:
      glob:
        - '*.pdf'
        - '*.svg'
        - '*.png'
        - '*.jpg'
        - '*.ps'
        - '*.eps'
        - '*.pgf'
        - '*.raw'
        - '*.rgba'
        - '*.tif'
  - id: tables
    type:
      type: array
      items: File
    doc: Data behind each plot (CSV)
    outputBinding:
      glob: '*.csv'
  - id: new_configuration_file
    type:
      - 'null'
      - File
    doc: Configuration file created when none was given
    outputBinding:
      glob: barseqcount_analyze.conf
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barseqcount:0.1.5--pyhdfd78af_0
stdout: barseqcount_analyze.out

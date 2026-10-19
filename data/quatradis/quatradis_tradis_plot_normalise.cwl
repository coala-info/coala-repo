cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - plot
  - normalise
label: quatradis_tradis_plot_normalise
doc: "Given a set of plot files, find the one with the highest number of reads and normalise all the rest into new files.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: plot_files
    type:
      type: array
      items: File
    doc: "One or more paths to transposon insertion site plot files."
    inputBinding:
      position: 1
  - id: minimum_proportion_insertions
    type:
      - 'null'
      - float
    doc: "If the proportion of insertions is too low compared to control, do not call decreased insertions below this level."
    inputBinding:
      position: 102
      prefix: --minimum_proportion_insertions
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "The directory in which to put all output files."
    inputBinding:
      position: 103
      prefix: --output_dir
  - id: output_filename
    type:
      - 'null'
      - string
    doc: "The name for the normalised output files. Normalised files are distinguished by directory."
    inputBinding:
      position: 104
      prefix: --output_filename
  - id: profile
    type:
      - 'null'
      - boolean
    doc: "Turn on profiling."
    inputBinding:
      position: 100
      prefix: --profile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print out extra information about the process while it runs."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_out
    type:
      - 'null'
      - Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: '${ return inputs.output_dir ? inputs.output_dir : "_unused_o"; }'
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_plot_normalise.out

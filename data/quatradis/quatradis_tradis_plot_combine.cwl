cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - plot
  - combine
label: quatradis_tradis_plot_combine
doc: "Combine multiple TraDIS plot files into one, optionally in groups, controlled by a tab-delimited list file.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: plot_file_list
    type: File
    doc: "Tab delimited file with an id in the first column followed by a list of plot files."
    inputBinding:
      position: 1
  - id: plot_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Plot files named in the list file, staged in the working directory."
  - id: combined_dir
    type:
      - 'null'
      - string
    doc: "The directory in which to store the combined output files (default: combined)."
    inputBinding:
      position: 102
      prefix: --combined_dir
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
  - id: combined_out
    type:
      - 'null'
      - Directory
    doc: "Combined output directory"
    outputBinding:
      glob: $(inputs.combined_dir)
  - id: combined_files
    type:
      type: array
      items: File
    doc: "Combined plot and stats files"
    outputBinding:
      glob: |
        ${ return (inputs.combined_dir ? inputs.combined_dir : "combined") + "/*"; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.plot_file_list)
      - $(inputs.plot_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_plot_combine.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rebar
  - plot
label: rebar_plot
doc: "Plot recombination from rebar run output.

Tool homepage: https://github.com/phac-nml/rebar"
inputs:
  - id: run_dir
    type: Directory
    doc: "Output directory from rebar run; all TSV files under barcodes/ are plotted"
    inputBinding:
      position: 1
      prefix: --run-dir
  - id: barcodes_file
    type:
      - 'null'
      - File
    doc: "A single barcodes TSV file to plot"
    inputBinding:
      position: 2
      prefix: --barcodes-file
  - id: annotations
    type:
      - 'null'
      - File
    doc: "Dataset genome annotations"
    inputBinding:
      position: 3
      prefix: --annotations
  - id: output_dir
    type: string
    doc: "Output directory for plots (required here: the default plots/ under the run directory is read-only when the run directory is staged)"
    inputBinding:
      position: 4
      prefix: --output-dir
  - id: all_coords
    type:
      - 'null'
      - boolean
    doc: "Draw all coordinates in the barcodes file"
    inputBinding:
      position: 5
      prefix: --all-coords
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Control output verbosity level (info, warn, debug, error). Default is info"
    inputBinding:
      position: 90
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: plots_dir
    type: Directory
    doc: "Directory with the plots"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
stdout: rebar_plot.out

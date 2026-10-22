cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SigProfilerPlotting
  - plotDBS
label: sigprofilerplotting_plotDBS
doc: "Generate DBS plots.\n\nTool homepage: https://github.com/alexandrovlab/SigProfilerPlotting"
inputs:
  - id: percentage
    type:
      - 'null'
      - boolean
    doc: Display percentages in the plot.
    inputBinding:
      position: 1
      prefix: --percentage
  - id: custom_text_upper
    type:
      - 'null'
      - string
    doc: Custom text to display top of the plot.
    inputBinding:
      position: 1
      prefix: --custom_text_upper
  - id: custom_text_middle
    type:
      - 'null'
      - string
    doc: Custom text to display in the middle of the plot.
    inputBinding:
      position: 1
      prefix: --custom_text_middle
  - id: custom_text_bottom
    type:
      - 'null'
      - string
    doc: Custom text to display at the bottom of the plot.
    inputBinding:
      position: 1
      prefix: --custom_text_bottom
  - id: savefig_format
    type:
      - 'null'
      - type: enum
        name: plotDBS_savefig_format
        symbols: [pdf, png, pil_image]
    doc: The file format for saving the plot.
    inputBinding:
      position: 1
      prefix: --savefig_format
  - id: volume
    type:
      - 'null'
      - string
    doc: Specify a volume for Docker container usage. A writable directory for
      the plot templates; needed because the container file system is read-only.
    default: templates
    inputBinding:
      position: 1
      prefix: --volume
  - id: dpi
    type:
      - 'null'
      - int
    doc: The resolution of the plot in dots per inch.
    inputBinding:
      position: 1
      prefix: --dpi
  - id: matrix_path
    type: File
    doc: The path to the input matrix file.
    inputBinding:
      position: 3
  - id: output_path
    type: string
    doc: The directory where the plots will be saved.
    inputBinding:
      position: 4
  - id: project
    type: string
    doc: The name of the project.
    inputBinding:
      position: 5
  - id: plot_type
    type: string
    doc: The type of plot to generate.
    inputBinding:
      position: 6
outputs:
  - id: plots
    type: Directory
    doc: Directory with the plots
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_path, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilerplotting:1.4.3--pyhdfd78af_0
stdout: sigprofilerplotting_plotDBS.out

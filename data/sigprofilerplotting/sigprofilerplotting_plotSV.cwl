cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SigProfilerPlotting
  - plotSV
label: sigprofilerplotting_plotSV
doc: "Generate SV plots.\n\nTool homepage: https://github.com/alexandrovlab/SigProfilerPlotting"
inputs:
  - id: percentage
    type:
      - 'null'
      - boolean
    doc: Display percentages in the plot.
    inputBinding:
      position: 1
      prefix: --percentage
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: Aggregate all samples.
    inputBinding:
      position: 1
      prefix: --aggregate
  - id: savefig_format
    type:
      - 'null'
      - type: enum
        name: plotSV_savefig_format
        symbols: [pdf, png, pil_image]
    doc: The file format for saving the plot.
    inputBinding:
      position: 1
      prefix: --savefig_format
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
stdout: sigprofilerplotting_plotSV.out

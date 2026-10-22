cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - plot-tensor-dist
label: transcov_plot-tensor-dist
doc: "Plot the end-length and fragment-start distribution of a tensor\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: input_tensor
    type: File
    doc: "Input end-length tensor (.npy)"
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - string
    default: plot.png
    doc: "Output plot file name"
    inputBinding:
      prefix: --output-file
outputs:
  - id: plot
    type: File
    doc: "Plot image (PNG)"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0

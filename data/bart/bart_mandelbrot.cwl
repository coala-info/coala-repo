cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, mandelbrot]
requirements:
  - class: InlineJavascriptRequirement
label: bart_mandelbrot
doc: "Compute mandelbrot set.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 10
  - id: image_size
    type:
      - 'null'
      - int
    doc: image size
    inputBinding:
      position: 1
      prefix: -s
  - id: nr_of_iterations
    type:
      - 'null'
      - int
    doc: nr. of iterations
    inputBinding:
      position: 1
      prefix: -n
  - id: offset_imag
    type:
      - 'null'
      - float
    doc: offset imag
    inputBinding:
      position: 1
      prefix: -i
  - id: offset_real
    type:
      - 'null'
      - float
    doc: offset real
    inputBinding:
      position: 1
      prefix: -r
  - id: threshold_for_divergence
    type:
      - 'null'
      - float
    doc: threshold for divergence
    inputBinding:
      position: 1
      prefix: -t
  - id: zoom
    type:
      - 'null'
      - float
    doc: zoom
    inputBinding:
      position: 1
      prefix: -z
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

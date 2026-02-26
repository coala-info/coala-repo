cwlVersion: v1.2
class: CommandLineTool
baseCommand: mandelbrot
label: bart_mandelbrot
doc: "Compute mandelbrot set.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 1
  - id: image_size
    type:
      - 'null'
      - string
    doc: image size
    inputBinding:
      position: 102
      prefix: -s
  - id: nr_of_iterations
    type:
      - 'null'
      - string
    doc: nr. of iterations
    inputBinding:
      position: 102
      prefix: -n
  - id: offset_imag
    type:
      - 'null'
      - float
    doc: offset imag
    inputBinding:
      position: 102
      prefix: -i
  - id: offset_real
    type:
      - 'null'
      - float
    doc: offset real
    inputBinding:
      position: 102
      prefix: -r
  - id: threshold_for_divergence
    type:
      - 'null'
      - float
    doc: threshold for divergence
    inputBinding:
      position: 102
      prefix: -t
  - id: zoom
    type:
      - 'null'
      - float
    doc: zoom
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_mandelbrot.out

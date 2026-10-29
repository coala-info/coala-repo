cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_taper
label: relion_relion_tomo_taper
doc: "Taper the edges of an image or map with a soft raised-cosine edge.\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: input
    type: File
    doc: Image to be tapered
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type: string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: --o
  - id: edge_width
    type:
      - 'null'
      - float
    doc: 'Filter edge width (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --w
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --j
outputs:
  - id: tapered
    type: File
    doc: Tapered image
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_taper.out

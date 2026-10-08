cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainge
  - plot
label: strainge_plot
doc: 'Generate plots for a given k-mer set.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
  - id: kmerset
    type: File
    doc: The k-mer set to load
    inputBinding:
      position: 100
  - id: output
    type: string
    doc: Output filename (PNG preferred).
    inputBinding:
      position: 1
      prefix: --output
    default: spectrum.png
  - id: plot_type
    type:
      - 'null'
      - type: enum
        symbols:
          - spectrum
    doc: The kind of plot to generate.
    inputBinding:
      position: 1
      prefix: --plot-type
    default: spectrum
outputs:
  - id: output_result
    type: File
    doc: Output filename (PNG preferred).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0

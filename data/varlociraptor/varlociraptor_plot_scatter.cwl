cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - plot
  - scatter
label: varlociraptor_plot_scatter
doc: 'Plot variant allelic fraction scatter plot overlayed with a contour plot between
  two sample groups. The Vega-lite JSON goes to standard output.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: calls
    type: File
    doc: Varlociraptor calls in BCF format (standard input).
  - id: sample_x
    type:
      - 'null'
      - string
    doc: Name of the first sample in the given VCF/BCF.
    inputBinding:
      position: 100
      prefix: --sample-x
  - id: sample_y
    type:
      type: array
      items: string
    doc: Name(s) of the alternative sample(s) in the given VCF/BCF. Multiple samples
      can be given.
    inputBinding:
      position: 100
      prefix: --sample-y
outputs:
  - id: plot
    type: stdout
    doc: Vega-lite plot
stdin: $(inputs.calls.path)
stdout: scatter.vl.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0

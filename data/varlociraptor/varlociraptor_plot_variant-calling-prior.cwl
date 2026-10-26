cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - plot
  - variant-calling-prior
label: varlociraptor_plot_variant-calling-prior
doc: 'Plot variant calling prior given a scenario. Plot is printed to standard output
  in Vega-lite format.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: contig
    type:
      - 'null'
      - string
    doc: Contig to consider for ploidy information.
    inputBinding:
      position: 100
      prefix: --contig
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample to plot.
    inputBinding:
      position: 100
      prefix: --sample
  - id: scenario
    type:
      - 'null'
      - File
    doc: Variant calling scenario that configures the prior.
    inputBinding:
      position: 100
      prefix: --scenario
outputs:
  - id: plot
    type: stdout
    doc: Vega-lite plot
stdout: variant-calling-prior.vl.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0

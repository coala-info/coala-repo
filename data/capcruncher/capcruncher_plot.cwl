cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - plot
label: capcruncher_plot
doc: "Generates plots for the outputs produced by CapCruncher\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: region
    type: string
    doc: Genomic coordinates of the region to plot
    inputBinding:
      position: 101
      prefix: --region
  - id: template
    type: string
    doc: TOML file containing the template for the plot
    inputBinding:
      position: 101
      prefix: --template
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path. The file extension determines the output format.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1

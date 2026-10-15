cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_rocplot
label: ppanini_rocplot
doc: "PPANINI plotting tool: ROC curves of the priority score for known essential genes.\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: ppanini_output
    type:
      - 'null'
      - File
    doc: "PPANINI output table"
    inputBinding:
      position: 101
      prefix: -i
  - id: essential_genes1
    type:
      - 'null'
      - File
    doc: "A list of essential genes"
    inputBinding:
      position: 101
      prefix: -e1
  - id: essential_genes2
    type:
      - 'null'
      - File
    doc: "A list of essential genes"
    inputBinding:
      position: 101
      prefix: -e2
  - id: master_plot
    type:
      - 'null'
      - boolean
    doc: "Plotting master figure of the paper"
    inputBinding:
      position: 101
      prefix: --master-plot
  - id: plot_metagenomics
    type:
      - 'null'
      - boolean
    doc: "Plotting based of metagenomics priority score"
    inputBinding:
      position: 101
      prefix: --plot-metagenomics
  - id: plot_genomics
    type:
      - 'null'
      - boolean
    doc: "Plotting based of genomics priority score"
    inputBinding:
      position: 101
      prefix: --plot-genomics
  - id: path
    type:
      - 'null'
      - Directory
    doc: "Path for inputs (the niche table <niche>.txt is read from it)"
    inputBinding:
      position: 101
      prefix: --path
  - id: outfile
    type:
      - 'null'
      - string
    doc: "Output file name (prefix of the .png file)"
    inputBinding:
      position: 101
      prefix: --outfile
  - id: beta
    type:
      - 'null'
      - float
    doc: "Beta is a weight of contribution, B * prevalence and (1-B) * abundance"
    inputBinding:
      position: 101
      prefix: --beta
  - id: size
    type:
      - 'null'
      - float
    doc: "Size of the plot in inches"
    inputBinding:
      position: 101
      prefix: --size
  - id: output
    type:
      - 'null'
      - string
    doc: "A name or output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: niche
    type:
      - 'null'
      - string
    doc: "Niche name"
    inputBinding:
      position: 101
      prefix: --niche
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: plots
    type:
      type: array
      items: File
    doc: "Plot images written in the working directory"
    outputBinding:
      glob: "*.png"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini_rocplot.out

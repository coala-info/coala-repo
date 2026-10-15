cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_scatterplot
label: ppanini_scatterplot
doc: "PPANINI plotting tool: scatter plot of priority scores against the number of genomes carrying a gene.\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: ppanini_output
    type:
      - 'null'
      - File
    doc: "PPANINI output table"
    inputBinding:
      position: 101
      prefix: -i
  - id: diamond_output
    type:
      - 'null'
      - File
    doc: "A mapping file of gene-metagenome (DIAMOND output)"
    inputBinding:
      position: 101
      prefix: -m8
  - id: master_plot
    type:
      - 'null'
      - boolean
    doc: "Plotting master figure of the paper"
    inputBinding:
      position: 101
      prefix: --master-plot
  - id: outfile
    type:
      - 'null'
      - string
    doc: "Output file name"
    inputBinding:
      position: 101
      prefix: --outfile
  - id: size
    type:
      - 'null'
      - float
    doc: "Size of the plot in inches"
    inputBinding:
      position: 101
      prefix: --size
  - id: path
    type: string
    doc: "Output directory for the plot files (created before the run)"
    inputBinding:
      position: 102
      prefix: --path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: "Directory with the plot files (.pdf, .png, .svgz)"
    outputBinding:
      glob: $(inputs.path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini_scatterplot.out

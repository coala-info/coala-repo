cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_barplot
label: ppanini_barplot
doc: "PPANINI plotting tool: stacked bar plot of the characterization (unannotated, NCBI gene, UniRef, GO) of the gene families of each sample.\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: ppanini_input
    type:
      - 'null'
      - File
    doc: "Gene abundance table"
    inputBinding:
      position: 101
      prefix: -i1
  - id: ppanini_output
    type:
      - 'null'
      - File
    doc: "PPANINI output table"
    inputBinding:
      position: 101
      prefix: -i2
  - id: summary_table
    type:
      - 'null'
      - File
    doc: "Summary table"
    inputBinding:
      position: 101
      prefix: --summary-table
  - id: scale
    type:
      - 'null'
      - string
    doc: "Scale: abundance or counts [default: abundance]"
    inputBinding:
      position: 101
      prefix: --scale
  - id: output_path
    type: string
    doc: "Output directory for the plot files (created before the run)"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: "Directory with ppanini_barplot.txt, .pdf, .png and .svgz"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini_barplot.out

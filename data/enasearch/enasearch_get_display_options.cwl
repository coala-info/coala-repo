cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch_get_display_options
label: enasearch_get_display_options
doc: "Get display options for ENA search results.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs:
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Results are displayed in fasta format. Supported by assembled and 
      annotated sequence and Trace data classes.
    inputBinding:
      position: 101
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Results are displayed in fastq format. Supported only by Trace data 
      class.
    inputBinding:
      position: 101
  - id: format
    type:
      - 'null'
      - string
    doc: The desired format for displaying results. Supported formats are xml, 
      text, fastq, html, report, and fasta. HTML is the default if no format is 
      specified.
    inputBinding:
      position: 101
  - id: html
    type:
      - 'null'
      - boolean
    doc: Results are displayed in HTML format. Supported by all ENA data 
      classes. HTML is the default display format if no other display option has
      been specified.
    inputBinding:
      position: 101
  - id: report
    type:
      - 'null'
      - boolean
    doc: Results are displayed as a tab separated report
    inputBinding:
      position: 101
  - id: text
    type:
      - 'null'
      - boolean
    doc: Results are displayed in text format. Supported only by assembled and 
      annotated sequence data classes.
    inputBinding:
      position: 101
  - id: xml
    type:
      - 'null'
      - boolean
    doc: Results are displayed in XML format. Supported by all ENA data classes.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_display_options.out

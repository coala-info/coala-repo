cwlVersion: v1.2
class: CommandLineTool
baseCommand: mavis overlay
label: mavis_overlay
doc: "Draws a gene and its surrounding genomic context, including read depth plots
  and markers.\n\nTool homepage: https://github.com/bcgsc/mavis.git"
inputs:
  - id: gene_name
    type: string
    doc: Gene ID or gene alias to be drawn
    inputBinding:
      position: 1
  - id: buffer_length
    type:
      - 'null'
      - int
    doc: minimum genomic length to plot on either side of the target gene
    default: 0
    inputBinding:
      position: 102
  - id: config
    type: File
    doc: path to the JSON config file
    inputBinding:
      position: 102
      prefix: --config
  - id: log
    type:
      - 'null'
      - File
    doc: redirect stdout to a log file
    default: None
    inputBinding:
      position: 102
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of logging to output
    default: INFO
    inputBinding:
      position: 102
      prefix: --log_level
  - id: marker
    type:
      - 'null'
      - type: array
        items: string
    doc: Marker on the diagram given by genomic position, May be a single 
      position or a range. The label should be a short descriptor to avoid 
      overlapping labels on the diagram
    default: '[]'
    inputBinding:
      position: 102
      prefix: --marker
  - id: read_depth_plot
    type:
      - 'null'
      - type: array
        items: string
    doc: bam file to use as data for plotting read_depth
    default: '[]'
    inputBinding:
      position: 102
      prefix: --read_depth_plot
outputs:
  - id: output
    type: Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0

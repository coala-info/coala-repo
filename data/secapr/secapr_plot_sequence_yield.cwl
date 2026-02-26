cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr plot_sequence_yield
label: secapr_plot_sequence_yield
doc: "Plot overview of extracted sequences\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: alignments
    type:
      - 'null'
      - Directory
    doc: The directory containing the contig alignments. Provide this path if 
      you want to add a line to the plot showing for which loci alignments could
      be created.
    inputBinding:
      position: 101
      prefix: --alignments
  - id: coverage_norm
    type:
      - 'null'
      - string
    doc: Here you can adjust the color scale of the read-coverage plot. This 
      value will define the maximum of the color scale, e.g. if set to '10' 
      read-coverage of 10 and above will be colored black, while everything 
      below (0-10) will be stretched across the color spectrum from yellow, red 
      to black.
    inputBinding:
      position: 101
      prefix: --coverage_norm
  - id: extracted_contigs
    type: Directory
    doc: The directory containing the extracted target contigs (output from 
      find_target_contigs function).
    inputBinding:
      position: 101
      prefix: --extracted_contigs
  - id: read_cov
    type:
      - 'null'
      - Directory
    doc: The directory containing the reference assembly results. Provide this 
      path if you want to display the read coverage for each locus and sample.
    inputBinding:
      position: 101
      prefix: --read_cov
outputs:
  - id: output
    type: Directory
    doc: The directory in which to store the plots.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0

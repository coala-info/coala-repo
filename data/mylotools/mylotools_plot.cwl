cwlVersion: v1.2
class: CommandLineTool
baseCommand: mylotools plot
label: mylotools_plot
doc: "Plot contig analysis results.\n\nTool homepage: https://github.com/bluenote-1577/mylotools"
inputs:
  - id: contig_ids
    type:
      type: array
      items: string
    doc: ID of the contig to analyze
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to the assembly FASTA file
    default: assembly_primary.fa
    inputBinding:
      position: 102
      prefix: --fasta
  - id: gfa
    type:
      - 'null'
      - File
    doc: Path to the GFA file
    default: final_contig_graph.gfa
    inputBinding:
      position: 102
      prefix: --gfa
  - id: marker_size
    type:
      - 'null'
      - int
    doc: Size of marker points in the coverage plot
    default: 8
    inputBinding:
      position: 102
      prefix: --marker-size
  - id: overlap_marker_size
    type:
      - 'null'
      - int
    doc: Size of marker points in the overlap plot
    default: 12
    inputBinding:
      position: 102
      prefix: --overlap-marker-size
  - id: step_size
    type:
      - 'null'
      - string
    doc: Step size for the sliding window
    default: window_size/2
    inputBinding:
      position: 102
      prefix: --step-size
  - id: window_size
    type:
      - 'null'
      - int
    doc: Sliding window size in base pairs for GC content
    default: 1000
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output HTML file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0

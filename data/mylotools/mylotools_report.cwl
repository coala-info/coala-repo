cwlVersion: v1.2
class: CommandLineTool
baseCommand: mylotools report
label: mylotools_report
doc: "Generate a report from Myloasm assembly files.\n\nTool homepage: https://github.com/bluenote-1577/mylotools"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Myloasm fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gfa
    type:
      - 'null'
      - File
    doc: Path to the GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum contig length to include
    inputBinding:
      position: 101
      prefix: --min-length
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for GC content calculation
    inputBinding:
      position: 101
      prefix: --window-size
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of parallel workers for plot generation
    inputBinding:
      position: 101
      prefix: --workers
  - id: x_axis
    type:
      - 'null'
      - string
    doc: 'X-axis for summary plot: gc (GC content) or length (contig length)'
    inputBinding:
      position: 101
      prefix: --x-axis
outputs:
  - id: output
    type: Directory
    doc: Output directory for report files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0

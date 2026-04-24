cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - plot-bam
label: rust-bio-tools_plot-bam
doc: "Creates a html file with a vega visualization of the given bam region that is
  then written to stdout.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: bam_path
    type:
      type: array
      items: File
    doc: BAM file to be visualized
    inputBinding:
      position: 101
      prefix: --bam-path
  - id: max_read_depth
    type:
      - 'null'
      - int
    doc: Set the maximum rows that will be shown in the alignment plots
    inputBinding:
      position: 101
      prefix: --max-read-depth
  - id: reference
    type: File
    doc: Path to the reference fasta file
    inputBinding:
      position: 101
      prefix: --reference
  - id: region
    type: string
    doc: 'Chromosome and region for the visualization. Example: 2:132424-132924'
    inputBinding:
      position: 101
      prefix: --region
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdout: rust-bio-tools_plot-bam.out

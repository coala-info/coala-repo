cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - distance
label: ska2_distance
doc: "Calculate SNP distances and k-mer mismatches\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: skf_file
    type: File
    doc: 'Split-kmer (.skf) file to operate on'
    inputBinding:
      position: 1
  - id: min_freq
    type:
      - 'null'
      - float
    doc: 'Minimum fraction of samples a k-mer has to appear in across the entire alignment [default: 0]'
    inputBinding:
      position: 101
      prefix: --min-freq
  - id: allow_ambiguous
    type:
      - 'null'
      - boolean
    doc: 'Don''t filter out ambiguous bases and compute fractional distances'
    inputBinding:
      position: 101
      prefix: --allow-ambiguous
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_path
    type: string
    doc: 'Output filename'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: distances
    type: File
    doc: 'Distance table'
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0

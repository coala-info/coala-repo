cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - qc
label: alfred_qc
doc: "Quality control for aligned sequencing reads\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: aligned_bam
    type: File
    doc: Input aligned BAM file
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: bed file with target regions (optional)
    inputBinding:
      position: 102
      prefix: --bed
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: ignore read-groups
    inputBinding:
      position: 102
      prefix: --ignore
  - id: mean_coverage
    type:
      - 'null'
      - boolean
    doc: report mean coverage as float instead of median integer coverage
    inputBinding:
      position: 102
      prefix: --meancov
  - id: read_group
    type:
      - 'null'
      - string
    doc: only analyze this read group (optional)
    inputBinding:
      position: 102
      prefix: --rg
  - id: reference
    type: File
    doc: reference fasta file (required)
    inputBinding:
      position: 102
      prefix: --reference
  - id: sample_name
    type:
      - 'null'
      - string
    doc: sample name (optional, otherwise SM tag is used)
    inputBinding:
      position: 102
      prefix: --name
  - id: secondary
    type:
      - 'null'
      - boolean
    doc: evaluate secondary alignments
    inputBinding:
      position: 102
      prefix: --secondary
  - id: supplementary
    type:
      - 'null'
      - boolean
    doc: evaluate supplementary alignments
    inputBinding:
      position: 102
      prefix: --supplementary
outputs:
  - id: json_output
    type: File
    doc: gzipped json output file
    outputBinding:
      glob: $(inputs.json_output)
  - id: tsv_output
    type:
      - 'null'
      - File
    doc: gzipped tsv output file
    outputBinding:
      glob: $(inputs.tsv_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0

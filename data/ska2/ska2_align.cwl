cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - align
label: ska2_align
doc: "Write an unordered alignment\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'A .skf file, or list of .fasta files'
    inputBinding:
      position: 1
  - id: min_freq
    type:
      - 'null'
      - float
    doc: 'Minimum fraction of samples a k-mer has to appear in [default: 0.9]'
    inputBinding:
      position: 101
      prefix: --min-freq
  - id: filter_ambig_as_missing
    type:
      - 'null'
      - boolean
    doc: 'With min_freq, only count non-ambiguous sites'
    inputBinding:
      position: 101
      prefix: --filter-ambig-as-missing
  - id: filter
    type:
      - 'null'
      - string
    doc: 'Filter for constant middle base sites: no-filter (output all variants), no-const (filter constant bases), no-ambig (filter any site with an ambiguous base), no-ambig-or-const'
    inputBinding:
      position: 101
      prefix: --filter
  - id: ambig_mask
    type:
      - 'null'
      - boolean
    doc: 'Mask any ambiguous bases in the alignment with ''N'''
    inputBinding:
      position: 101
      prefix: --ambig-mask
  - id: no_gap_only_sites
    type:
      - 'null'
      - boolean
    doc: 'Ignore gaps ''-'' in constant sites (for low coverage samples)'
    inputBinding:
      position: 101
      prefix: --no-gap-only-sites
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
  - id: alignment
    type: File
    doc: 'Alignment in FASTA format'
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0

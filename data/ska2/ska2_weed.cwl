cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - weed
label: ska2_weed
doc: "Remove k-mers from a split k-mer file\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: skf_file
    type: File
    doc: 'Split-kmer (.skf) file to operate on'
    inputBinding:
      position: 1
  - id: weed_file
    type:
      - 'null'
      - File
    doc: 'A FASTA file containing sequences to remove'
    inputBinding:
      position: 2
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: 'Remove k-mers not in the weed_file'
    inputBinding:
      position: 101
      prefix: --reverse
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
  - id: weeded_skf
    type: File
    doc: 'Weeded split-kmer file'
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0

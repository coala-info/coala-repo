cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtk
  - flt
label: bedtk_flt
doc: "Filter BED records based on overlap with another BED file or VCF/PAF.\n\nTool
  homepage: https://github.com/lh3/bedtk"
inputs:
  - id: loaded_bed
    type: File
    doc: The first input BED file (loaded).
    inputBinding:
      position: 1
  - id: streamed_bed
    type: File
    doc: The second input BED file (streamed).
    inputBinding:
      position: 2
  - id: min_overlap_fraction
    type:
      - 'null'
      - float
    doc: Minimum overlap fraction.
    default: 0
    inputBinding:
      position: 103
      prefix: -f
  - id: print_contained_records
    type:
      - 'null'
      - boolean
    doc: Print records contained in the union of <loaded.bed>.
    inputBinding:
      position: 103
      prefix: -C
  - id: print_non_satisfying
    type:
      - 'null'
      - boolean
    doc: Print non-satisfying records.
    inputBinding:
      position: 103
      prefix: -v
  - id: second_input_is_paf
    type:
      - 'null'
      - boolean
    doc: The second input is PAF.
    inputBinding:
      position: 103
      prefix: -p
  - id: second_input_is_vcf
    type:
      - 'null'
      - boolean
    doc: The second input is VCF.
    inputBinding:
      position: 103
      prefix: -c
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size.
    default: 0
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtk:1.2--h9990f68_0
stdout: bedtk_flt.out

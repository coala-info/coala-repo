cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAdd
label: ngs-bits_VcfAdd
doc: "Merges several VCF files into one VCF by appending one to the other.\nVariant
  lines from all other input files are appended to the first input file.\nVCF header
  lines are taken from the first input file only.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: filter_description
    type:
      - 'null'
      - string
    doc: Description used in the filter header - use underscore instead of 
      spaces.
    default: ''
    inputBinding:
      position: 101
      prefix: -filter_desc
  - id: filter_tag
    type:
      - 'null'
      - string
    doc: Tag variants from all but the first input file with this filter entry.
    default: ''
    inputBinding:
      position: 101
      prefix: -filter
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files to merge in VCF or VCG.GZ format.
    inputBinding:
      position: 101
      prefix: -in
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: skip_duplicates
    type:
      - 'null'
      - boolean
    doc: Skip variants if they occur more than once.
    default: 'false'
    inputBinding:
      position: 101
      prefix: -skip_duplicates
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output VCF file with all variants.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0

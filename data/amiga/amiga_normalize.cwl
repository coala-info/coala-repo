cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amiga
  - normalize
label: amiga_normalize
doc: "Normalize growth parameters of fitted curves\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: input
    type: File
    doc: "Summary file of growth parameters (from amiga fit)"
    inputBinding:
      position: 1
      prefix: --input
  - id: over_write
    type: ['null', boolean]
    doc: "Over-write file otherwise a new copy is made with \"_normalized\" suffix"
    inputBinding:
      position: 1
      prefix: --over-write
  - id: verbose
    type: ['null', boolean]
    doc: "Print verbose messages"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: group_by
    type: ['null', string]
    doc: "Meta-data variables that define the groups to normalize within (e.g. 'Plate_ID')"
    inputBinding:
      position: 1
      prefix: --group-by
  - id: normalize_by
    type: ['null', string]
    doc: "Condition used as reference (e.g. 'Substrate:Negative Control')"
    inputBinding:
      position: 1
      prefix: --normalize-by
  - id: normalize_method
    type: ['null', {type: enum, symbols: [division, subtraction]}]
    doc: "Normalization method (default subtraction)"
    inputBinding:
      position: 1
      prefix: --normalize-method
outputs:
  - id: normalized_summary
    type: File
    doc: Normalized summary table (<input>_normalized.txt, or the input itself with --over-write)
    outputBinding:
      glob: '$(inputs.over_write ? inputs.input.basename : inputs.input.nameroot + "_normalized.txt")'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1

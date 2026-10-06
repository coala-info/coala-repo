cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amiga
  - get_confidence
label: amiga_get_confidence
doc: "Compute confidence intervals for parameters or curves.\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: input
    type: File
    doc: "Summary file (Parameters) or GP data file (Curves) from amiga fit"
    inputBinding:
      position: 1
      prefix: --input
  - id: type
    type: {type: enum, symbols: [Parameters, Curves]}
    doc: "Compute intervals for growth parameters or for curves"
    inputBinding:
      position: 1
      prefix: --type
  - id: confidence
    type: ['null', float]
    doc: "Must be between 80 and 100. Default is 95."
    inputBinding:
      position: 1
      prefix: --confidence
  - id: include_noise
    type: ['null', boolean]
    doc: "Include the estimated measurement noise when computing confidence interval (For Curves Only)."
    inputBinding:
      position: 1
      prefix: --include-noise
  - id: over_write
    type: ['null', boolean]
    doc: "Over-write file otherwise a new copy is made with \"_confidence\" suffix"
    inputBinding:
      position: 1
      prefix: --over-write
  - id: verbose
    type: ['null', boolean]
    doc: "Print verbose messages"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: confidence_table
    type: File
    doc: Table with confidence intervals (<input>_confidence.txt, or the input itself with --over-write)
    outputBinding:
      glob: '$(inputs.over_write ? inputs.input.basename : inputs.input.nameroot + "_confidence.txt")'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1

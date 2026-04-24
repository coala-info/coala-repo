cwlVersion: v1.2
class: CommandLineTool
baseCommand: scheme-convert
label: viramp-hub_scheme-convert
doc: "Converts scheme files between different formats.\n\nTool homepage: https://github.com/wm75/viramp-hub"
inputs:
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: amplicon_info
    type:
      - 'null'
      - File
    doc: Amplicon info file for inputs from which primer groupings cannot be 
      infered.
    inputBinding:
      position: 102
      prefix: --amplicon-info
  - id: bed_type
    type:
      - 'null'
      - string
    doc: For "bed" output, the type of bed to be written; Currently, you can 
      specify "ivar" to produce primer bed output compatible with the ivar suite
      of tools, or "cojac" to generate the amplicon insert bed expected by 
      cojac.
    inputBinding:
      position: 102
      prefix: --bed-type
  - id: from_format
    type:
      - 'null'
      - string
    doc: Format of the input file (only "bed" is supported in this version)
    inputBinding:
      position: 102
      prefix: --from
  - id: report_nested
    type:
      - 'null'
      - string
    doc: 'For amplicons formed by nested primers, report all primers, or just inner
      or outer ones. Applied only when writing amplicon info files (default: "full").'
    inputBinding:
      position: 102
      prefix: --report-nested
  - id: to
    type: string
    doc: Type of output to be generated
    inputBinding:
      position: 102
      prefix: --to
outputs:
  - id: output
    type: File
    doc: Name of the output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viramp-hub:0.1.0--pyhdfd78af_0

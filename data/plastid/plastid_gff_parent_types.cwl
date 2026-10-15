cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gff_parent_types
label: plastid_gff_parent_types
doc: 'Export a table of parent-child feature relationships for all feature types found in a GFF3 file.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: infile_gff
    type: File
    doc: Input GFF3 file
    inputBinding:
      position: 1
  - id: outfile_txt
    type: string
    doc: Name of output file
    inputBinding:
      position: 2
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Feature types to exclude from consideration
    inputBinding:
      position: 101
      prefix: --exclude
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all warning messages. Cannot use with '-v'.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity. With ''-v'', show every warning. With ''-vv'', turn warnings into exceptions. Cannot use with ''-q''. (Default: show each type of warning once)'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Table of parent-child feature relationships
    outputBinding:
      glob: $(inputs.outfile_txt)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2

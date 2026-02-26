cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - radtk
  - view
label: radtk_view
doc: "view a text representation of the RAD file\n\nTool homepage: https://github.com/COMBINE-lab/radtk"
inputs:
  - id: input
    type: File
    doc: the input RAD file to print
    inputBinding:
      position: 101
      prefix: --input
  - id: max_chunks
    type:
      - 'null'
      - int
    doc: print the records from at most this many chunks
    inputBinding:
      position: 101
      prefix: --max-chunks
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: skip printing the header and file-level tags (i.e. only print the 
      mapping reacords)
    inputBinding:
      position: 101
      prefix: --no-header
  - id: rad_type
    type: string
    doc: 'the type of input RAD file [possible values: bulk, single-cell, unknown]'
    inputBinding:
      position: 101
      prefix: --rad-type
  - id: use_ref_name
    type:
      - 'null'
      - boolean
    doc: use the reference name rather than ID in the mapped records
    inputBinding:
      position: 101
      prefix: --use-ref-name
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file where the JSON format RAD file will be written; if not 
      provided, the output will be written to standard out
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radtk:0.2.0--ha6fb395_1

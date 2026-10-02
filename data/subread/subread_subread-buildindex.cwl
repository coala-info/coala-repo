cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - subread-buildindex
label: subread_subread-buildindex
doc: Build an index for the reference genome for Subread aligners.
inputs:
  - id: reference_files
    type:
      type: array
      items: File
    doc: FASTA[.gz] reference genome files
    inputBinding:
      position: 1
  - id: output_basename
    type:
      - 'null'
      - string
    doc: base name of the index to be created
    inputBinding:
      position: 102
      prefix: -o
  - id: full_index
    type:
      - 'null'
      - boolean
    doc: build a full index for the reference genome. 16bp subreads will be 
      extracted from every position of the reference genome. Size of the index 
      is typically 3 times the size of index built from using the default 
      setting.
    inputBinding:
      position: 102
      prefix: -F
  - id: single_block
    type:
      - 'null'
      - boolean
    doc: create one block of index. The built index will not be split into 
      multiple pieces. This makes the largest amount of memory be requested when
      running alignments, but it enables the maximum mapping speed to be 
      achieved. This option overrides -M when it is provided as well.
    inputBinding:
      position: 102
      prefix: -B
  - id: memory
    type:
      - 'null'
      - int
    doc: size of requested memory(RAM) in megabytes, 8000 by default.
    inputBinding:
      position: 102
      prefix: -M
  - id: threshold
    type:
      - 'null'
      - int
    doc: specify the threshold for removing uninformative subreads (highly 
      repetitive 16mers in the reference). 100 by default.
    inputBinding:
      position: 102
      prefix: -f
  - id: color_space
    type:
      - 'null'
      - boolean
    doc: build a color-space index.
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: output_output_basename
    type:
      - 'null'
      - File[]
    doc: base name of the index to be created
    outputBinding:
      glob: $(inputs.output_basename)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
s:url: https://subread.sourceforge.net
$namespaces:
  s: https://schema.org/

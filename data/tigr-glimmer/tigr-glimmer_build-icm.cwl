cwlVersion: v1.2
class: CommandLineTool
baseCommand: build-icm
label: tigr-glimmer_build-icm
doc: Read sequences from standard input and output to output-file the 
  interpolated context model built from them.
inputs:
  - id: output_file
    type: File
    doc: output file
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file
    inputBinding:
      position: 2
  - id: depth
    type:
      - 'null'
      - int
    doc: Set depth of model to <num>
    inputBinding:
      position: 103
      prefix: -d
  - id: ignore_inframe_stop_codons
    type:
      - 'null'
      - boolean
    doc: Ignore input strings with in-frame stop codons
    inputBinding:
      position: 103
      prefix: -F
  - id: output_model_as_text
    type:
      - 'null'
      - boolean
    doc: Output model as text (for debugging only)
    inputBinding:
      position: 103
      prefix: -t
  - id: period
    type:
      - 'null'
      - int
    doc: Set period of model to <num>
    inputBinding:
      position: 103
      prefix: -p
  - id: use_reverse
    type:
      - 'null'
      - boolean
    doc: Use the reverse of input strings to build the model
    inputBinding:
      position: 103
      prefix: -r
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Set verbose level; higher is more diagnostic printouts
    inputBinding:
      position: 103
      prefix: -v
  - id: window_length
    type:
      - 'null'
      - int
    doc: Set length of model window to <num>
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_build-icm.out

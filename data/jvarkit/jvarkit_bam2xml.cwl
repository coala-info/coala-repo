cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit_bam2xml
label: jvarkit_bam2xml
doc: "Convert BAM to XML\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: input_bam
    type: File
    doc: input BAM file
    inputBinding:
      position: 1
  - id: no_attributes
    type:
      - 'null'
      - boolean
    doc: Do not print the attributes
    inputBinding:
      position: 102
      prefix: --no-attributes
  - id: no_comments
    type:
      - 'null'
      - boolean
    doc: Do not print the comments
    inputBinding:
      position: 102
      prefix: --no-comments
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not print the header
    inputBinding:
      position: 102
      prefix: --no-header
  - id: no_program
    type:
      - 'null'
      - boolean
    doc: Do not print the program list
    inputBinding:
      position: 102
      prefix: --no-program
  - id: no_quality
    type:
      - 'null'
      - boolean
    doc: Do not print the quality
    inputBinding:
      position: 102
      prefix: --no-quality
  - id: no_read_groups
    type:
      - 'null'
      - boolean
    doc: Do not print the read groups
    inputBinding:
      position: 102
      prefix: --no-read-groups
  - id: no_ref_dict
    type:
      - 'null'
      - boolean
    doc: Do not print the reference dictionary
    inputBinding:
      position: 102
      prefix: --no-ref-dict
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: Do not print the sequence
    inputBinding:
      position: 102
      prefix: --no-sequence
  - id: no_sequence_dictionary
    type:
      - 'null'
      - boolean
    doc: Do not print the sequence dictionary
    inputBinding:
      position: 102
      prefix: --no-sequence-dictionary
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: Sequence dictionary (SAMtools dict)
    inputBinding:
      position: 102
      prefix: --sequence-dictionary
  - id: sequence_dictionary_file
    type:
      - 'null'
      - File
    doc: Sequence dictionary file
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-file
  - id: sequence_dictionary_json
    type:
      - 'null'
      - string
    doc: Sequence dictionary JSON
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-json
  - id: sequence_dictionary_json_file
    type:
      - 'null'
      - File
    doc: Sequence dictionary JSON file
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-json-file
  - id: sequence_dictionary_json_string
    type:
      - 'null'
      - string
    doc: Sequence dictionary JSON string
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-json-string
  - id: sequence_dictionary_json_string_file
    type:
      - 'null'
      - File
    doc: Sequence dictionary JSON string file
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-json-string-file
  - id: sequence_dictionary_json_string_string
    type:
      - 'null'
      - string
    doc: Sequence dictionary JSON string string
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-json-string-string
  - id: sequence_dictionary_json_string_url
    type:
      - 'null'
      - string
    doc: Sequence dictionary JSON string URL
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-json-string-url
  - id: sequence_dictionary_json_url
    type:
      - 'null'
      - string
    doc: Sequence dictionary JSON URL
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-json-url
  - id: sequence_dictionary_string
    type:
      - 'null'
      - string
    doc: Sequence dictionary string
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-string
  - id: sequence_dictionary_url
    type:
      - 'null'
      - string
    doc: Sequence dictionary URL
    inputBinding:
      position: 102
      prefix: --sequence-dictionary-url
outputs:
  - id: output_xml
    type:
      - 'null'
      - File
    doc: 'output XML file. Default: stdout'
    outputBinding:
      glob: $(inputs.output_xml)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2

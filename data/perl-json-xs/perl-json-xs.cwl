cwlVersion: v1.2
class: CommandLineTool
baseCommand: json_xs
label: perl-json-xs
doc: "json_xs converts between some input and output formats (one of them is JSON).
  It reads data in the given format from standard input and writes it to standard
  output. The default input format is json and the default output format is json-pretty.\n\
  \nTool homepage: https://metacpan.org/pod/JSON::XS"
inputs:
  - id: input_data
    type: File
    doc: Data to convert (read from standard input)
  - id: eval_code
    type:
      - 'null'
      - string
    doc: Evaluate Perl code after reading the data and before writing it out again;
      the data is in $_ and whatever is in there is written out afterwards
    inputBinding:
      position: 101
      prefix: -e
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input format: json, cbor, storable, storable-file, bencode, clzf, eval,
      yaml, string or none'
    inputBinding:
      position: 101
      prefix: -f
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: json, json-utf-8, json-pretty, json-utf-16le, json-utf-16be,
      json-utf-32le, json-utf-32be, cbor, cbor-packed, storable, storable-file, bencode,
      clzf, yaml, dump, dumper, string or none'
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be slightly more verbose
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Converted data
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-json-xs:4.04--pl5321h9948957_0
stdin: $(inputs.input_data.path)
stdout: perl-json-xs.out

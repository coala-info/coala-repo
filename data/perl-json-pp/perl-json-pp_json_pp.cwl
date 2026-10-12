cwlVersion: v1.2
class: CommandLineTool
baseCommand: json_pp
label: perl-json-pp_json_pp
doc: "json_pp converts between some input and output formats (one of them is JSON).
  It reads a data in the given format from standard input and writes it to standard
  output. The default input format is json and the default output format is json
  with pretty option.\n\nTool homepage: http://metacpan.org/pod/JSON::PP"
inputs:
  - id: input_data
    type: File
    doc: Data to convert (read from standard input)
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input format: json or eval (Perl code)'
    inputBinding:
      position: 101
      prefix: -f
  - id: json_opt
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Options to JSON::PP, joined with commas (ascii latin1 utf8 pretty indent
      space_before space_after relaxed canonical allow_nonref allow_singlequote allow_barekey
      allow_bignum loose escape_slash indent_length)'
    inputBinding:
      position: 101
      prefix: -json_opt
      itemSeparator: ','
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: null, json or dumper (Data::Dumper)'
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose option, currently without effect
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Converted data
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-json-pp:4.11--pl5321hdfd78af_0
stdin: $(inputs.input_data.path)
stdout: perl-json-pp_json_pp.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: piconv
label: perl-encode_piconv
doc: "Iconv-like interface to Encode, used for converting text from one encoding to
  another.\n\nTool homepage: http://metacpan.org/pod/Encode"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to convert
    inputBinding:
      position: 1
  - id: check_validity
    type:
      - 'null'
      - boolean
    doc: check the validity of the input
    inputBinding:
      position: 102
      prefix: -c
  - id: check_validity_n
    type:
      - 'null'
      - int
    doc: check the validity of the input with level N
    inputBinding:
      position: 102
      prefix: -C
  - id: debug
    type:
      - 'null'
      - boolean
    doc: show debug information
    inputBinding:
      position: 102
      prefix: --debug
  - id: from_encoding
    type:
      - 'null'
      - string
    doc: Source encoding; when omitted, the current locale will be used
    inputBinding:
      position: 102
      prefix: --from
  - id: htmlcref
    type:
      - 'null'
      - boolean
    doc: transliterate characters missing in encoding to &#NNN;
    inputBinding:
      position: 102
      prefix: --htmlcref
  - id: list
    type:
      - 'null'
      - boolean
    doc: lists all available encodings
    inputBinding:
      position: 102
      prefix: --list
  - id: perlqq
    type:
      - 'null'
      - boolean
    doc: transliterate characters missing in encoding to \x{HHHH}
    inputBinding:
      position: 102
      prefix: --perlqq
  - id: resolve
    type:
      - 'null'
      - string
    doc: resolve encoding to its (Encode) canonical name
    inputBinding:
      position: 102
      prefix: --resolve
  - id: scheme
    type:
      - 'null'
      - string
    doc: use the scheme for conversion
    inputBinding:
      position: 102
      prefix: --scheme
  - id: string_input
    type:
      - 'null'
      - string
    doc: '"string" will be the input instead of STDIN or files'
    inputBinding:
      position: 102
      prefix: --string
  - id: to_encoding
    type:
      - 'null'
      - string
    doc: Target encoding; when omitted, the current locale will be used
    inputBinding:
      position: 102
      prefix: --to
  - id: xmlcref
    type:
      - 'null'
      - boolean
    doc: transliterate characters missing in encoding to &#xHHHH;
    inputBinding:
      position: 102
      prefix: --xmlcref
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-encode:3.19--pl5321hec16e2b_1
stdout: perl-encode_piconv.out

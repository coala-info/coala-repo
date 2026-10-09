cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/jq
label: jq
doc: "jq is a tool for processing JSON inputs, applying the given filter to its JSON text inputs and producing the filter's results as JSON on standard output.\n\nTool homepage: https://jqlang.github.io/jq/"
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: jq_named_string
        type: record
        fields:
          - name: name
            type: string
          - name: value
            type: string
      - name: jq_named_file
        type: record
        fields:
          - name: name
            type: string
          - name: file
            type: File
inputs:
  - id: filter
    type: string
    doc: jq filter to apply
    inputBinding:
      position: 10
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input JSON files. Without files and without null_input, jq reads standard input.
    inputBinding:
      position: 11
  - id: positional_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Remaining arguments for use with args (strings) or jsonargs (JSON texts); read as $ARGS.positional
    inputBinding:
      position: 12
  - id: compact_output
    type:
      - 'null'
      - boolean
    doc: compact instead of pretty-printed output
    inputBinding:
      position: 1
      prefix: -c
  - id: null_input
    type:
      - 'null'
      - boolean
    doc: use null as the single input value
    inputBinding:
      position: 1
      prefix: -n
  - id: exit_status
    type:
      - 'null'
      - boolean
    doc: set the exit status code based on the output
    inputBinding:
      position: 1
      prefix: -e
  - id: slurp
    type:
      - 'null'
      - boolean
    doc: read (slurp) all inputs into an array; apply the filter to it
    inputBinding:
      position: 1
      prefix: -s
  - id: raw_output
    type:
      - 'null'
      - boolean
    doc: output raw strings, not JSON texts
    inputBinding:
      position: 1
      prefix: -r
  - id: raw_input
    type:
      - 'null'
      - boolean
    doc: read raw strings, not JSON texts
    inputBinding:
      position: 1
      prefix: -R
  - id: join_output
    type:
      - 'null'
      - boolean
    doc: like raw_output but do not print a newline after each output
    inputBinding:
      position: 1
      prefix: -j
  - id: ascii_output
    type:
      - 'null'
      - boolean
    doc: output strictly ASCII, escaping non-ASCII characters
    inputBinding:
      position: 1
      prefix: -a
  - id: color_output
    type:
      - 'null'
      - boolean
    doc: colorize JSON
    inputBinding:
      position: 1
      prefix: -C
  - id: monochrome_output
    type:
      - 'null'
      - boolean
    doc: monochrome (don't colorize JSON)
    inputBinding:
      position: 1
      prefix: -M
  - id: sort_keys
    type:
      - 'null'
      - boolean
    doc: sort keys of objects on output
    inputBinding:
      position: 1
      prefix: -S
  - id: tab
    type:
      - 'null'
      - boolean
    doc: use tabs for indentation
    inputBinding:
      position: 1
      prefix: --tab
  - id: indent
    type:
      - 'null'
      - int
    doc: use the given number of spaces (no more than 7) for indentation
    inputBinding:
      position: 1
      prefix: --indent
  - id: seq
    type:
      - 'null'
      - boolean
    doc: use the application/json-seq MIME type scheme for separating JSON texts in the output
    inputBinding:
      position: 1
      prefix: --seq
  - id: stream
    type:
      - 'null'
      - boolean
    doc: parse the input in streaming fashion, outputting arrays of path and leaf values
    inputBinding:
      position: 1
      prefix: --stream
  - id: unbuffered
    type:
      - 'null'
      - boolean
    doc: flush the output after each JSON object is printed
    inputBinding:
      position: 1
      prefix: --unbuffered
  - id: library_path
    type:
      - 'null'
      - string
    doc: search for modules in the given directory
    inputBinding:
      position: 1
      prefix: -L
  - id: arg
    type:
      - 'null'
      - type: array
        items: jq_named_string
    doc: Set variable $name to the string value. Each item has a name and a value.
    inputBinding:
      position: 5
      valueFrom: |
        ${
          var r = [];
          if (self) { self.forEach(function(a) { r.push("--arg", a.name, a.value); }); }
          return r;
        }
  - id: argjson
    type:
      - 'null'
      - type: array
        items: jq_named_string
    doc: Set variable $name to the JSON text value. Each item has a name and a value.
    inputBinding:
      position: 5
      valueFrom: |
        ${
          var r = [];
          if (self) { self.forEach(function(a) { r.push("--argjson", a.name, a.value); }); }
          return r;
        }
  - id: slurpfile
    type:
      - 'null'
      - type: array
        items: jq_named_file
    doc: Set variable $name to an array of the JSON texts read from the file.
    inputBinding:
      position: 5
      valueFrom: |
        ${
          var r = [];
          if (self) { self.forEach(function(a) { r.push("--slurpfile", a.name, a.file.path); }); }
          return r;
        }
  - id: rawfile
    type:
      - 'null'
      - type: array
        items: jq_named_file
    doc: Set variable $name to a string consisting of the contents of the file.
    inputBinding:
      position: 5
      valueFrom: |
        ${
          var r = [];
          if (self) { self.forEach(function(a) { r.push("--rawfile", a.name, a.file.path); }); }
          return r;
        }
  - id: args
    type:
      - 'null'
      - boolean
    doc: remaining arguments are string arguments, not files
    inputBinding:
      position: 11
      prefix: --args
  - id: jsonargs
    type:
      - 'null'
      - boolean
    doc: remaining arguments are JSON arguments, not files
    inputBinding:
      position: 11
      prefix: --jsonargs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jq:1.6
successCodes:
  - 0
  - 1
  - 4
stdout: jq.out

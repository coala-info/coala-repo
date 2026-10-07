cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cleanifier
  - info
label: cleanifier_info
doc: "get information about a hash table and dump its data\n\nTool homepage: https://gitlab.com/rahmannlab/cleanifier"
inputs:
  - id: inputprefix
    type: File
    doc: "existing hash table: give the .hash file; the name without .hash is passed, with the .info file beside it (required)"
    secondaryFiles:
      - pattern: "^.info"
        required: true
    inputBinding:
      position: 1
      valueFrom: "$(self.path.replace(/\\.hash$/, ''))"
  - id: outprefix
    type:
      - 'null'
      - string
    doc: "file name prefix of exported data, extended by .{key,chc.val}.{txt,data}."
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: format
    type:
      - 'null'
      - string
    doc: "output format [native (default): use native integer arrays (uint{8,16,32,64}); packed: use bit-backed arrays; text: use text files (one integer per line); dna: text file with DNA k-mers (one k-mer per line)]"
    inputBinding:
      position: 101
      prefix: --format
  - id: filterexpression
    type:
      - 'null'
      - string
    doc: "filter expression using variables `key`, `choice`, `value`, e.g. '(choice != 0) and (value & 3 == 3)'. Output (but not statistics) will be restricted to items for which the filter expression is true."
    inputBinding:
      position: 101
      prefix: --filterexpression
  - id: compilefilter
    type:
      - 'null'
      - type: array
        items: string
    doc: "string specifying `path/module::compiler_func` that will be called with the valueset, the appinfo and given additional parameters (PARAM) to compile a filter function that takes key, choice and value as arguments."
    inputBinding:
      position: 101
      prefix: --compilefilter
  - id: statistics
    type:
      - 'null'
      - string
    doc: "level of detail of statistics to be shown (none, summary, details, full) (default: summary)"
    inputBinding:
      position: 101
      prefix: --statistics
  - id: showvalues
    type:
      - 'null'
      - string
    doc: "number of values to show in value statistics (none, all, INT) (default: 1023)"
    inputBinding:
      position: 101
      prefix: --showvalues
outputs:
  - id: exported
    type:
      type: array
      items: File
    doc: "Exported keys, choices and values"
    outputBinding:
      glob: "$(inputs.outprefix ? inputs.outprefix + '.*' : [])"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
stdout: cleanifier_info.out

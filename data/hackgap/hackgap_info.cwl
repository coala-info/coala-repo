cwlVersion: v1.2
class: CommandLineTool
baseCommand: hackgap_info
label: hackgap_info
doc: "Prints information about a hash table.\n\nTool homepage: https://gitlab.com/rahmannlab/hackgap"
inputs:
  - id: inputprefix
    type: string
    doc: file name of existing hash table (without extension .hash or .info)
    inputBinding:
      position: 1
  - id: compilefilter_params
    type:
      - 'null'
      - type: array
        items: string
    doc: additional parameters for compilefilter
    inputBinding:
      position: 2
  - id: compilefilter
    type:
      - 'null'
      - type: array
        items: string
    doc: string specifying `path/module::compiler_func` that will be called with
      the valueset, the appinfo and given additional parameters (PARAM) to 
      compile a filter function that takes key, choice and value as arguments.
    inputBinding:
      position: 103
      prefix: --compilefilter
  - id: filterexpression
    type:
      - 'null'
      - string
    doc: filter expression using variables `key`, `choice`, `value`, e.g. 
      '(choice != 0) and (value & 3 == 3)'. Output (but not statistics) will be 
      restricted to items for which the filter expression is true.
    inputBinding:
      position: 103
      prefix: --filterexpression
  - id: format
    type:
      - 'null'
      - string
    doc: 'output format [native (default): use native integer arrays (uint{8,16,32,64});
      packed: use bit-backed arrays; text: use text files (one integer per line);
      dna: text file with DNA k-mers (one k-mer per line)]'
    default: native
    inputBinding:
      position: 103
      prefix: --format
  - id: showvalues
    type:
      - 'null'
      - int
    doc: number of values to show in value statistics (none, all, INT)
    inputBinding:
      position: 103
      prefix: --showvalues
  - id: statistics
    type:
      - 'null'
      - string
    doc: level of detail of statistics to be shown (none, summary, details, 
      full)
    inputBinding:
      position: 103
      prefix: --statistics
outputs:
  - id: outprefix
    type:
      - 'null'
      - File
    doc: file name prefix of exported data, extended by 
      .{key,chc.val}.{txt,data}.
    outputBinding:
      glob: $(inputs.outprefix)
  - id: export
    type:
      - 'null'
      - File
    doc: file name prefix of exported data, extended by 
      .{key,chc.val}.{txt,data}.
    outputBinding:
      glob: $(inputs.export)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0

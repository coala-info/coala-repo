cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi_cache_dump
label: mimi_mimi_cache_dump
doc: "MIMI cache dump tool: print the contents of a binary cache file.\n\nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs:
  - id: num_compounds
    type:
      - 'null'
      - int
    doc: 'Number of compounds to output (default: all).'
    inputBinding:
      position: 101
      prefix: --num-compounds
  - id: num_isotopes
    type:
      - 'null'
      - int
    doc: 'Number of isotopes per compound to output (default: all).'
    inputBinding:
      position: 101
      prefix: --num-isotopes
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output file (default: stdout).'
    inputBinding:
      position: 101
      prefix: --output
  - id: cache_file
    type: File
    doc: Input cache file (.pkl).
    inputBinding:
      position: 201
outputs:
  - id: dump
    type:
      - 'null'
      - File
    doc: Dump file when --output is given.
    outputBinding:
      glob: $(inputs.output)
  - id: dump_text
    type: stdout
    doc: Dump printed to standard output.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
stdout: mimi_mimi_cache_dump.out

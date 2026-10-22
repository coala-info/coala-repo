cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - varlookup
label: svtools_varlookup
doc: 'Look up variants of a pruned, merged BEDPE (A file) in another pruned, merged
  BEDPE (B file).


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: distance
    type:
      - 'null'
      - int
    doc: Max separation distance (bp) of adjacent loci between bedpe files [50]
    inputBinding:
      position: 101
      prefix: --distance
  - id: a_file
    type:
      - 'null'
      - File
    doc: Pruned, merged BEDPE (A file) or standard input
    inputBinding:
      position: 101
      prefix: --aFile
  - id: b_file
    type:
      - 'null'
      - File
    doc: Pruned merged BEDPE (B file). For pruning use svtools prune
    inputBinding:
      position: 101
      prefix: --bFile
  - id: cohort
    type:
      - 'null'
      - string
    doc: 'Cohort name to add information of matching variants (default: bFile)'
    inputBinding:
      position: 101
      prefix: --cohort
  - id: output_bedpe
    type:
      - 'null'
      - string
    doc: 'Output BEDPE to write (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: out_bedpe
    type:
      - 'null'
      - File
    doc: BEDPE with lookup annotation
    outputBinding:
      glob: $(inputs.output_bedpe)
  - id: stdout
    type: stdout
    doc: Output when --output is not given
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_varlookup.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: DefineClones.py
label: changeo_DefineClones.py
doc: "Assigns Ig sequences to clonal groups based on junction sequence similarity.\n\
  \ \nTool homepage: http://changeo.readthedocs.io"
inputs:
  - id: act
    type:
      - 'null'
      - string
    doc: 'How to handle multiple V(D)J assignments for initial grouping: first or
      set (default: set).'
    inputBinding:
      position: 101
      prefix: --act
  - id: db_file
    type: File
    doc: A tab delimited database file (AIRR or Change-O format).
    inputBinding:
      position: 101
      prefix: -d
  - id: failed
    type:
      - 'null'
      - boolean
    doc: If specified create files containing records that fail processing.
    inputBinding:
      position: 101
      prefix: --failed
  - id: format
    type:
      - 'null'
      - string
    doc: 'Input and output format: airr or changeo (default: airr).'
    inputBinding:
      position: 101
      prefix: --format
  - id: seq_field
    type:
      - 'null'
      - string
    doc: Field to be used to calculate distance between records.
    inputBinding:
      position: 101
      prefix: --sf
  - id: v_field
    type:
      - 'null'
      - string
    doc: Field containing the germline V segment call.
    inputBinding:
      position: 101
      prefix: --vf
  - id: j_field
    type:
      - 'null'
      - string
    doc: Field containing the germline J segment call.
    inputBinding:
      position: 101
      prefix: --jf
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Use the V(D)J allele or gene for initial grouping: allele or gene (default:
      gene).'
    inputBinding:
      position: 101
      prefix: --mode
  - id: dist
    type:
      - 'null'
      - float
    doc: Distance threshold for clonal grouping.
    inputBinding:
      position: 101
      prefix: --dist
  - id: group
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional fields to use for grouping clones aside from V, J and junction
      length.
    inputBinding:
      position: 101
      prefix: --gf
  - id: link
    type:
      - 'null'
      - string
    doc: Linkage type (single, average, complete).
    inputBinding:
      position: 101
      prefix: --link
  - id: log
    type:
      - 'null'
      - string
    doc: Write verbose logging to this file.
    inputBinding:
      position: 101
      prefix: --log
  - id: maxmiss
    type:
      - 'null'
      - int
    doc: Maximum number of missing characters to allow.
    inputBinding:
      position: 101
      prefix: --maxmiss
  - id: model
    type:
      - 'null'
      - string
    doc: Distance model to use (e.g., ham, aa, hh_s1f, hh_s5f).
    inputBinding:
      position: 101
      prefix: --model
  - id: norm
    type:
      - 'null'
      - string
    doc: 'How to normalize distances: len, mut or none (default: len).'
    inputBinding:
      position: 101
      prefix: --norm
  - id: nproc
    type:
      - 'null'
      - int
    doc: The number of processors to use.
    inputBinding:
      position: 101
      prefix: --nproc
  - id: outname
    type:
      - 'null'
      - string
    doc: User specified output file name.
    inputBinding:
      position: 101
      prefix: --outname
  - id: sym
    type:
      - 'null'
      - string
    doc: Symmetry method (avg, min).
    inputBinding:
      position: 101
      prefix: --sym
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Verbose log file.
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/changeo:1.3.4--pyhdfd78af_0

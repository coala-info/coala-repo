cwlVersion: v1.2
class: CommandLineTool
baseCommand: DefineClones.py
label: changeo_DefineClones.py
doc: "Assigns Ig sequences to clonal groups based on junction sequence similarity.\n
  \nTool homepage: http://changeo.readthedocs.io"
inputs:
  - id: act
    type:
      - 'null'
      - string
    doc: "Action to perform: 'set' (fixed threshold), 'min' (minimum distance), or
      'max' (maximum distance)."
    inputBinding:
      position: 101
      prefix: --act
  - id: db_file
    type: File
    doc: A Change-O formatted TSV file.
    inputBinding:
      position: 101
      prefix: -d
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
    doc: Columns to use for grouping (e.g., V_CALL, J_CALL, JUNCTION_LENGTH).
    inputBinding:
      position: 101
      prefix: --group
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
      - File
    doc: User specified log file name.
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
    doc: Normalization method for distance (len, none).
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
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/changeo:1.3.4--pyhdfd78af_0

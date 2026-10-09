cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lirtmats
  - cli
label: lirtmats_cli
doc: "Executing lirtmats version 1.0.0.\n\nTool homepage: https://pypi.org/project/lirtmats/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_data)
        writable: true
inputs:
  - id: col_idx
    type:
      - 'null'
      - string
    doc: Column index of name, mz, rt and start of data intensity
    inputBinding:
      position: 101
      prefix: --col-idx
  - id: input_data
    type: File
    doc: Data set including peak-list. Results are written beside it as <name>_rtm_m, <name>_rtm_s and <name>_rtm.db files.
    inputBinding:
      position: 101
      prefix: --input-data
      valueFrom: $(self.basename)
  - id: input_sep
    type:
      - 'null'
      - string
    doc: Values in input or output file are separated by this character.
    inputBinding:
      position: 101
      prefix: --input-sep
  - id: ion_mode
    type:
      - 'null'
      - string
    doc: Ion mode of data set.
    inputBinding:
      position: 101
      prefix: --ion-mode
  - id: rt_path
    type:
      - 'null'
      - File
    doc: Retention time reference file for matching.
    inputBinding:
      position: 101
      prefix: --rt-path
  - id: rt_sep
    type:
      - 'null'
      - string
    doc: Delimiter in retention time reference file
    inputBinding:
      position: 101
      prefix: --rt-sep
  - id: rt_tol
    type:
      - 'null'
      - float
    doc: Retention time tolerance in seconds.
    inputBinding:
      position: 101
      prefix: --rt-tol
  - id: save_db
    type:
      - 'null'
      - boolean
    doc: Save all results in a sql database.
    inputBinding:
      position: 101
      prefix: --save-db
  - id: summ_type
    type:
      - 'null'
      - string
    doc: Retention time matching result file format.
    inputBinding:
      position: 101
      prefix: --summ-type
outputs:
  - id: matching_results
    type:
      type: array
      items: File
    doc: Retention time matching results (<name>_rtm_m and <name>_rtm_s tables and, with save_db, <name>_rtm.db).
    outputBinding:
      glob: $(inputs.input_data.nameroot + '_rtm*')
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lirtmats:1.0.0--pyhdfd78af_0
stdout: lirtmats_cli.out

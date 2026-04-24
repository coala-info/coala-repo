cwlVersion: v1.2
class: CommandLineTool
baseCommand: seismic
label: seismic-rna_seismic
doc: "Command line interface of SEISMIC-RNA.\n\nTool homepage: https://github.com/rouskinlab/seismic-rna"
inputs:
  - id: command
    type: string
    doc: The command to execute (align, biorxiv, cleanfa, cluster, conda, ct2db,
      datapath, db2ct, demult, docs, draw, ensembles, export, fold, github, 
      graph, join, list, mask, migrate, pool, pypi, relate, renumct, sim, 
      splitbam, table, test, wf)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: exit_on_error
    type:
      - 'null'
      - boolean
    doc: If an error occurs, exit SEISMIC-RNA
    inputBinding:
      position: 103
      prefix: --exit-on-error
  - id: log
    type:
      - 'null'
      - File
    doc: Log all messages to this file ('' to disable)
    inputBinding:
      position: 103
      prefix: --log
  - id: log_color
    type:
      - 'null'
      - boolean
    doc: Log messages with color codes on stderr
    inputBinding:
      position: 103
      prefix: --log-color
  - id: log_on_error
    type:
      - 'null'
      - boolean
    doc: If an error occurs, log a message
    inputBinding:
      position: 103
      prefix: --log-on-error
  - id: log_plain
    type:
      - 'null'
      - boolean
    doc: Log messages without color codes on stderr
    inputBinding:
      position: 103
      prefix: --log-plain
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Log fewer messages (-q, -qq, -qqq, -qqqq) on stderr
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Log more messages (-v, -vv, -vvv, -vvvv) on stderr
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
stdout: seismic-rna_seismic.out

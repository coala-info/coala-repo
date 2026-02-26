cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadbit describe
label: tadbit_describe
doc: "Describe jobs and results in a given working directory\n\nTool homepage: http://sgt.cnag.cat/3dg/tadbit/"
inputs:
  - id: jobids
    type:
      - 'null'
      - type: array
        items: int
    doc: Display only items matching these jobids.
    inputBinding:
      position: 101
      prefix: --jobids
  - id: no_x_screen
    type:
      - 'null'
      - boolean
    doc: no display server (X screen)
    inputBinding:
      position: 101
      prefix: --noX
  - id: select
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Select columns. List the keyword (column headers) to be displayed. E.g.
      to show only the colmns JobIds: `-s Jobids`'
    inputBinding:
      position: 101
      prefix: --select
  - id: skip_tables
    type:
      - 'null'
      - type: array
        items: string
    doc: 'what tables NOT to show, write either the sequence of names or indexes,
      according to this list: 1: paths, 2: jobs, 3: mapped_outputs, 4: mapped_inputs,
      5: parsed_outputs, 6: intersection_outputs, 7: filter_outputs, 8: normalize_outputs,
      9: merge_stats, 10: merge_outputs, 11: segment_outputs, 12: models, 13: modeled_regions'
    inputBinding:
      position: 101
      prefix: --skip_tables
  - id: tables
    type:
      - 'null'
      - type: array
        items: string
    doc: 'what tables to show, write either the sequence of names or indexes, according
      to this list: 1: paths, 2: jobs, 3: mapped_outputs, 4: mapped_inputs, 5: parsed_outputs,
      6: intersection_outputs, 7: filter_outputs, 8: normalize_outputs, 9: merge_stats,
      10: merge_outputs, 11: segment_outputs, 12: models, 13: modeled_regions'
    inputBinding:
      position: 101
      prefix: --tables
  - id: tmpdb
    type:
      - 'null'
      - Directory
    doc: if provided uses this directory to manipulate the database
    inputBinding:
      position: 101
      prefix: --tmpdb
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Print output in tab separated format
    inputBinding:
      position: 101
      prefix: --tsv
  - id: where
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Select rows. List pairs of keywords (column header) and values to filter
      results. For example to get only results where "18" appears in the column "Chromosome",
      the option should be set as: `-W Chromosome,18`'
    inputBinding:
      position: 101
      prefix: --where
  - id: working_directory
    type: Directory
    doc: path to working directory (generated with the tool tadbit map)
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Writes output in specified file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadbit:1.0.1--py310h2a84d7f_1

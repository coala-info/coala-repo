cwlVersion: v1.2
class: CommandLineTool
baseCommand: catpv
label: consel_catpv
doc: "Print the p-values (au, np, bp, pp, kh, sh, wkh, wsh) stored in pv files made by consel, optionally aggregating several pv files.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: pv_files
    type: File[]
    doc: "pv files made by consel"
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print auxiliary information (pf, rss, df, d, c, th)"
    inputBinding:
      position: 1
      prefix: -v
  - id: print_se
    type:
      - 'null'
      - boolean
    doc: "print the standard errors of the p-values"
    inputBinding:
      position: 1
      prefix: -e
  - id: sort_column
    type:
      - 'null'
      - int
    doc: "sort the lines by this column (1: item, 2: obs, 3 and up: p-values, e.g. 9 for au; negative for reverse order)"
    inputBinding:
      position: 1
      prefix: -s
  - id: print_rank
    type:
      - 'null'
      - boolean
    doc: "output the list of rank, order and item"
    inputBinding:
      position: 1
      prefix: -r
  - id: print_abbreviations
    type:
      - 'null'
      - boolean
    doc: "print the abbreviations of the column names"
    inputBinding:
      position: 1
      prefix: -h
  - id: label_add
    type:
      - 'null'
      - int
    doc: "number added to the item labels (default 1)"
    inputBinding:
      position: 1
      prefix: -l
  - id: aggregate_items
    type:
      - 'null'
      - int
    doc: "number of items to aggregate"
    inputBinding:
      position: 1
      prefix: -t
  - id: aggregate_start
    type:
      - 'null'
      - int
    doc: "first item to aggregate"
    inputBinding:
      position: 1
      prefix: -i
  - id: aggregate_output
    type:
      - 'null'
      - string
    doc: "aggregate the pv files and write the p-values as matrices to <name>.out"
    inputBinding:
      position: 1
      prefix: -o
  - id: congruence_output
    type:
      - 'null'
      - string
    doc: "write the minimum p-values over the pv files (congruence) to <name>.pv"
    inputBinding:
      position: 1
      prefix: -c
  - id: no_au
    type:
      - 'null'
      - boolean
    doc: "suppress printing au and np"
    inputBinding:
      position: 1
      prefix: --no_au
  - id: no_bp
    type:
      - 'null'
      - boolean
    doc: "suppress printing bp"
    inputBinding:
      position: 1
      prefix: --no_bp
  - id: no_pp
    type:
      - 'null'
      - boolean
    doc: "suppress printing pp"
    inputBinding:
      position: 1
      prefix: --no_pp
  - id: no_sh
    type:
      - 'null'
      - boolean
    doc: "suppress printing kh, sh, wkh and wsh"
    inputBinding:
      position: 1
      prefix: --no_sh
  - id: no_print
    type:
      - 'null'
      - boolean
    doc: "suppress printing"
    inputBinding:
      position: 1
      prefix: --no_print
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: "debug mode level"
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: aggregate
    type:
      - 'null'
      - File
    doc: "aggregated p-values (with -o)"
    outputBinding:
      glob: $(inputs.aggregate_output).out
  - id: congruence
    type:
      - 'null'
      - File
    doc: "congruence p-values (with -c)"
    outputBinding:
      glob: $(inputs.congruence_output).pv
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_catpv.log

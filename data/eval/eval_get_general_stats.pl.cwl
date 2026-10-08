cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_general_stats.pl
label: eval_get_general_stats.pl
doc: "Get general statistics on a list of gtf sets using the Eval package.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: list_member_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named inside the list files (staged beside the lists so the names resolve); not used with -g"
  - id: gtf_input
    type:
      - 'null'
      - boolean
    doc: "Input files are gtf not lists"
    inputBinding:
      position: 1
      prefix: -g
  - id: quick_load
    type:
      - 'null'
      - boolean
    doc: "Quick load the gtf file. Do not check them for errors."
    inputBinding:
      position: 2
      prefix: -q
  - id: no_alt_splicing
    type:
      - 'null'
      - boolean
    doc: "Do not get stats for alternative splices. (Faster)"
    inputBinding:
      position: 3
      prefix: -A
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose mode"
    inputBinding:
      position: 4
      prefix: -v
  - id: lists
    type:
      type: array
      items: File
    doc: "GTF set list files (or GTF files with -g)"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: General statistics report
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.list_member_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_get_general_stats.pl.out

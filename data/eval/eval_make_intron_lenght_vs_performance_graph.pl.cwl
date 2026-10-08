cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_intron_lenght_vs_performance_graph.pl
label: eval_make_intron_lenght_vs_performance_graph.pl
doc: "Create a table of intron prediction performance versus intron length.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: list_member_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named inside the list files (staged beside the lists so the names resolve); not used with -g"
  - id: min_bin_start
    type:
      - 'null'
      - int
    doc: "Sets the minimum bin start [default: min intron length]"
    inputBinding:
      position: 1
      prefix: -m
  - id: max_bin_stop
    type:
      - 'null'
      - int
    doc: "Sets the maximum bin end [default: max intron length]"
    inputBinding:
      position: 2
      prefix: -x
  - id: bin_size
    type:
      - 'null'
      - int
    doc: "Sets the bin size [default: 1/10 length range]; cannot be used with -B"
    inputBinding:
      position: 3
      prefix: -b
  - id: bin_count
    type:
      - 'null'
      - int
    doc: "Sets the number of bins [default: 10]; cannot be used with -b"
    inputBinding:
      position: 4
      prefix: -B
  - id: gtf_input
    type:
      - 'null'
      - boolean
    doc: "Input files are gtf not lists"
    inputBinding:
      position: 5
      prefix: -g
  - id: quick_load
    type:
      - 'null'
      - boolean
    doc: "Quick load the gtf file. Do not check them for errors."
    inputBinding:
      position: 6
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose mode"
    inputBinding:
      position: 7
      prefix: -v
  - id: annotation_list
    type: File
    doc: "Annotation list (or GTF with -g)"
    inputBinding:
      position: 100
  - id: prediction_lists
    type:
      type: array
      items: File
    doc: "Prediction lists (or GTFs with -g); one or more"
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Intron length versus performance table
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.list_member_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_make_intron_lenght_vs_performance_graph.pl.out

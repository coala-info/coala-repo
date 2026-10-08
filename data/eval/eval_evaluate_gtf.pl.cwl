cwlVersion: v1.2
class: CommandLineTool
baseCommand: evaluate_gtf.pl
label: eval_evaluate_gtf.pl
doc: "Run the evaluation code in text mode: compares one or more prediction GTF sets with an annotation GTF set.\n\nTool homepage: http://mblab.wustl.edu/software.html"
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
    doc: "Do not evaluate for alternative splicing events. (Faster)"
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
  - id: annotation_list
    type: File
    doc: "Input annotation list (or GTF file if -g is used)"
    inputBinding:
      position: 100
  - id: prediction_lists
    type:
      type: array
      items: File
    doc: "Prediction lists (or GTF files if -g is used); one or more"
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.list_member_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_evaluate_gtf.pl.out

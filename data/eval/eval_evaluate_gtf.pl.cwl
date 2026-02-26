cwlVersion: v1.2
class: CommandLineTool
baseCommand: evaluate_gtf.pl
label: eval_evaluate_gtf.pl
doc: "Run the evaluation code in text mode for GTF annotations and predictions.\n\n\
  Tool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: annotation_list
    type: File
    doc: Input annotation list (or GTF file if -g is used)
    inputBinding:
      position: 1
  - id: prediction_list_1
    type: File
    doc: First prediction list (or GTF file if -g is used)
    inputBinding:
      position: 2
  - id: prediction_lists_additional
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional prediction lists (or GTF files if -g is used)
    inputBinding:
      position: 3
  - id: gtf_input
    type:
      - 'null'
      - boolean
    doc: Input files are gtf not lists
    inputBinding:
      position: 104
      prefix: -g
  - id: no_alt_splicing
    type:
      - 'null'
      - boolean
    doc: Do not evaluate for alternative splicing events. (Faster)
    inputBinding:
      position: 104
      prefix: -A
  - id: quick_load
    type:
      - 'null'
      - boolean
    doc: Quick load the gtf file. Do not check them for errors.
    inputBinding:
      position: 104
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_evaluate_gtf.pl.out

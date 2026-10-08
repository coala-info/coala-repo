cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_gtfs.pl
label: eval_filter_gtfs.pl
doc: "Filters annotation-compared prediction GTFs with a filter file; writes <prediction>.filtered.gtf for each prediction.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: list_filter_types
    type:
      - 'null'
      - boolean
    doc: "List filter types"
    inputBinding:
      position: 1
      prefix: -f
  - id: gtf_inputs
    type:
      - 'null'
      - boolean
    doc: "Inputs are gtf files instead of list files"
    inputBinding:
      position: 2
      prefix: -g
  - id: no_alt_splicing
    type:
      - 'null'
      - boolean
    doc: "Do not check for alternative splices. (Faster)"
    inputBinding:
      position: 3
      prefix: -A
  - id: quick_load
    type:
      - 'null'
      - boolean
    doc: "Quick load the gtf file. Do not check them for errors."
    inputBinding:
      position: 4
      prefix: -q
  - id: filter_file
    type: File
    doc: "Filter file: list of filter types with a one-letter label, empty line(s), then the filter string such as (A&&B)||!C"
    inputBinding:
      position: 100
  - id: ann_gtf
    type: File
    doc: "Annotation GTF (or list file)"
    inputBinding:
      position: 101
  - id: pred_gtfs
    type:
      type: array
      items: File
    doc: "Prediction GTFs (or list files); one or more"
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Filter type list (with -f)
  - id: filtered_gtfs
    type:
      - 'null'
      - type: array
        items: File
    doc: Filtered prediction GTFs
    outputBinding:
      glob: "*.filtered.gtf"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.pred_gtfs) { for (var i = 0; i < inputs.pred_gtfs.length; i++) { l.push({entry: inputs.pred_gtfs[i], writable: true}); } }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_filter_gtfs.pl.out

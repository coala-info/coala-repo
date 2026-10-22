cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-summarize
label: tsv-utils_tsv-summarize
doc: "Run aggregation operations on fields in tab-separated value files, on the full input or grouped by key fields.\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input TSV files. Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: group_by
    type:
      - 'null'
      - string
    doc: "Fields to use as key."
    inputBinding:
      position: 101
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Treat the first line of each file as a header."
    inputBinding:
      position: 101
      prefix: -H
  - id: write_header
    type:
      - 'null'
      - boolean
    doc: "Write an output header even if there is no input header."
    inputBinding:
      position: 101
      prefix: -w
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)"
    inputBinding:
      position: 101
      prefix: -d
  - id: values_delimiter
    type:
      - 'null'
      - string
    doc: "Values delimiter. Default: vertical bar (|). (Single byte UTF-8 characters only.)"
    inputBinding:
      position: 101
      prefix: -v
  - id: float_precision
    type:
      - 'null'
      - int
    doc: "'Precision' to use printing floating point numbers. Default: 12"
    inputBinding:
      position: 101
      prefix: -p
  - id: exclude_missing
    type:
      - 'null'
      - boolean
    doc: "Exclude missing (empty) fields from calculations."
    inputBinding:
      position: 101
      prefix: -x
  - id: replace_missing
    type:
      - 'null'
      - string
    doc: "Replace missing (empty) fields with STR in calculations."
    inputBinding:
      position: 101
      prefix: -r
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Count occurrences of each unique key (--group-by), or the total number of records if no key field is specified."
    inputBinding:
      position: 101
      prefix: --count
  - id: count_header
    type:
      - 'null'
      - string
    doc: "Count occurrences of each unique key, like --count, but use STR as the header."
    inputBinding:
      position: 101
      prefix: --count-header
  - id: retain
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --retain
    doc: "FIELD-LIST. Retain one copy of the field."
    inputBinding:
      position: 101
  - id: first
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --first
    doc: "FIELD-LIST[:STR]. First value seen."
    inputBinding:
      position: 101
  - id: last
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --last
    doc: "FIELD-LIST[:STR]. Last value seen."
    inputBinding:
      position: 101
  - id: min
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --min
    doc: "FIELD-LIST[:STR]. Min value. (Fields with numeric values only.)"
    inputBinding:
      position: 101
  - id: max
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --max
    doc: "FIELD-LIST[:STR]. Max value. (Fields with numeric values only.)"
    inputBinding:
      position: 101
  - id: range
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --range
    doc: "FIELD-LIST[:STR]. Difference between min and max values. (Fields with numeric values only.)"
    inputBinding:
      position: 101
  - id: sum
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sum
    doc: "FIELD-LIST[:STR]. Sum of the values. (Fields with numeric values only.)"
    inputBinding:
      position: 101
  - id: mean
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mean
    doc: "FIELD-LIST[:STR]. Mean (average). (Fields with numeric values only.)"
    inputBinding:
      position: 101
  - id: median
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --median
    doc: "FIELD-LIST[:STR]. Median value. (Fields with numeric values only. Reads all values into memory.)"
    inputBinding:
      position: 101
  - id: quantile
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --quantile
    doc: "FIELD-LIST:p[,p...][:STR]. Quantiles. One or more fields, then one or more 0.0-1.0 probabilities."
    inputBinding:
      position: 101
  - id: mad
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mad
    doc: "FIELD-LIST[:STR]. Median absolute deviation from the median. Raw value, not scaled."
    inputBinding:
      position: 101
  - id: var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --var
    doc: "FIELD-LIST[:STR]. Variance. (Sample variance, numeric fields only)."
    inputBinding:
      position: 101
  - id: stdev
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --stdev
    doc: "FIELD-LIST[:STR]. Standard deviation. (Sample st.dev, numeric fields only)."
    inputBinding:
      position: 101
  - id: mode
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mode
    doc: "FIELD-LIST[:STR]. Mode. The most frequent value. (Reads all unique values into memory.)"
    inputBinding:
      position: 101
  - id: mode_count
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mode-count
    doc: "FIELD-LIST[:STR]. Count of the most frequent value. (Reads all unique values into memory.)"
    inputBinding:
      position: 101
  - id: unique_count
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --unique-count
    doc: "FIELD-LIST[:STR]. Number of unique values. (Reads all unique values into memory.)"
    inputBinding:
      position: 101
  - id: missing_count
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --missing-count
    doc: "FIELD-LIST[:STR]. Number of missing (empty) fields."
    inputBinding:
      position: 101
  - id: not_missing_count
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --not-missing-count
    doc: "FIELD-LIST[:STR]. Number of filled (non-empty) fields."
    inputBinding:
      position: 101
  - id: values
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --values
    doc: "FIELD-LIST[:STR]. All the values, separated by --values-delimiter. (Reads all values into memory.)"
    inputBinding:
      position: 101
  - id: unique_values
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --unique-values
    doc: "FIELD-LIST[:STR]. All the unique values, separated by --values-delimiter."
    inputBinding:
      position: 101
outputs:
  - id: summary
    type: stdout
    doc: "Summary table"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-summarize_output.tsv

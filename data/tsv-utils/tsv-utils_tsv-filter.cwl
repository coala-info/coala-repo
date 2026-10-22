cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-filter
label: tsv-utils_tsv-filter
doc: "Filter tab-delimited files for matching lines via comparison tests against individual fields.\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input TSV files. Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Treat the first line of each file as a header."
    inputBinding:
      position: 101
      prefix: --header
  - id: or
    type:
      - 'null'
      - boolean
    doc: "Evaluate tests as an OR rather than an AND."
    inputBinding:
      position: 101
      prefix: --or
  - id: invert
    type:
      - 'null'
      - boolean
    doc: "Print lines that do not match (invert the filter)."
    inputBinding:
      position: 101
      prefix: --invert
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Print only a count of the matched lines, excluding the header."
    inputBinding:
      position: 101
      prefix: --count
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)"
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: label
    type:
      - 'null'
      - string
    doc: "Do not filter. Instead, mark each record as passing the filter or not. STR is the header, ignored if there is no header line."
    inputBinding:
      position: 101
      prefix: --label
  - id: label_values
    type:
      - 'null'
      - string
    doc: "The pass/no-pass values used by --label, as STR1:STR2. Defaults to 1 and 0."
    inputBinding:
      position: 101
      prefix: --label-values
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: "Immediately output every matched line."
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: empty
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --empty
    doc: "True if FIELD is empty."
    inputBinding:
      position: 101
  - id: not_empty
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --not-empty
    doc: "True if FIELD is not empty."
    inputBinding:
      position: 101
  - id: blank
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --blank
    doc: "True if FIELD is empty or all whitespace."
    inputBinding:
      position: 101
  - id: not_blank
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --not-blank
    doc: "True if FIELD contains a non-whitespace character."
    inputBinding:
      position: 101
  - id: is_numeric
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --is-numeric
    doc: "True if FIELD is interpretable as a number."
    inputBinding:
      position: 101
  - id: is_finite
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --is-finite
    doc: "True if FIELD is interpretable as a number and is not NaN or infinity."
    inputBinding:
      position: 101
  - id: is_nan
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --is-nan
    doc: "True if FIELD is NaN."
    inputBinding:
      position: 101
  - id: is_infinity
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --is-infinity
    doc: "True if FIELD is infinity."
    inputBinding:
      position: 101
  - id: le
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --le
    doc: "FIELD:NUM, FIELD <= NUM (numeric)."
    inputBinding:
      position: 101
  - id: lt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --lt
    doc: "FIELD:NUM, FIELD < NUM (numeric)."
    inputBinding:
      position: 101
  - id: ge
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ge
    doc: "FIELD:NUM, FIELD >= NUM (numeric)."
    inputBinding:
      position: 101
  - id: gt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --gt
    doc: "FIELD:NUM, FIELD > NUM (numeric)."
    inputBinding:
      position: 101
  - id: eq
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --eq
    doc: "FIELD:NUM, FIELD == NUM (numeric)."
    inputBinding:
      position: 101
  - id: ne
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ne
    doc: "FIELD:NUM, FIELD != NUM (numeric)."
    inputBinding:
      position: 101
  - id: str_le
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --str-le
    doc: "FIELD:STR, FIELD <= STR (string)."
    inputBinding:
      position: 101
  - id: str_lt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --str-lt
    doc: "FIELD:STR, FIELD < STR (string)."
    inputBinding:
      position: 101
  - id: str_ge
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --str-ge
    doc: "FIELD:STR, FIELD >= STR (string)."
    inputBinding:
      position: 101
  - id: str_gt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --str-gt
    doc: "FIELD:STR, FIELD > STR (string)."
    inputBinding:
      position: 101
  - id: str_eq
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --str-eq
    doc: "FIELD:STR, FIELD == STR (string)."
    inputBinding:
      position: 101
  - id: istr_eq
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --istr-eq
    doc: "FIELD:STR, FIELD == (case-insensitive) STR (string)."
    inputBinding:
      position: 101
  - id: str_ne
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --str-ne
    doc: "FIELD:STR, FIELD != STR (string)."
    inputBinding:
      position: 101
  - id: istr_ne
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --istr-ne
    doc: "FIELD:STR, FIELD != (case-insensitive) STR (string)."
    inputBinding:
      position: 101
  - id: str_in_fld
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --str-in-fld
    doc: "FIELD:STR, FIELD contains STR (substring search)."
    inputBinding:
      position: 101
  - id: istr_in_fld
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --istr-in-fld
    doc: "FIELD:STR, FIELD contains STR (substring search, case-insensitive)."
    inputBinding:
      position: 101
  - id: str_not_in_fld
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --str-not-in-fld
    doc: "FIELD:STR, FIELD does not contain STR."
    inputBinding:
      position: 101
  - id: istr_not_in_fld
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --istr-not-in-fld
    doc: "FIELD:STR, FIELD does not contain STR (case-insensitive)."
    inputBinding:
      position: 101
  - id: regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --regex
    doc: "FIELD:REGEX, FIELD matches regular expression."
    inputBinding:
      position: 101
  - id: iregex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --iregex
    doc: "FIELD:REGEX, FIELD matches regular expression, case-insensitive."
    inputBinding:
      position: 101
  - id: not_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --not-regex
    doc: "FIELD:REGEX, FIELD does not match regular expression."
    inputBinding:
      position: 101
  - id: not_iregex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --not-iregex
    doc: "FIELD:REGEX, FIELD does not match regular expression, case-insensitive."
    inputBinding:
      position: 101
  - id: char_len_le
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --char-len-le
    doc: "FIELD:NUM, char-length(FIELD) <= NUM."
    inputBinding:
      position: 101
  - id: char_len_lt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --char-len-lt
    doc: "FIELD:NUM, char-length(FIELD) < NUM."
    inputBinding:
      position: 101
  - id: char_len_ge
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --char-len-ge
    doc: "FIELD:NUM, char-length(FIELD) >= NUM."
    inputBinding:
      position: 101
  - id: char_len_gt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --char-len-gt
    doc: "FIELD:NUM, char-length(FIELD) > NUM."
    inputBinding:
      position: 101
  - id: char_len_eq
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --char-len-eq
    doc: "FIELD:NUM, char-length(FIELD) == NUM."
    inputBinding:
      position: 101
  - id: char_len_ne
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --char-len-ne
    doc: "FIELD:NUM, char-length(FIELD) != NUM."
    inputBinding:
      position: 101
  - id: byte_len_le
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --byte-len-le
    doc: "FIELD:NUM, byte-length(FIELD) <= NUM."
    inputBinding:
      position: 101
  - id: byte_len_lt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --byte-len-lt
    doc: "FIELD:NUM, byte-length(FIELD) < NUM."
    inputBinding:
      position: 101
  - id: byte_len_ge
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --byte-len-ge
    doc: "FIELD:NUM, byte-length(FIELD) >= NUM."
    inputBinding:
      position: 101
  - id: byte_len_gt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --byte-len-gt
    doc: "FIELD:NUM, byte-length(FIELD) > NUM."
    inputBinding:
      position: 101
  - id: byte_len_eq
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --byte-len-eq
    doc: "FIELD:NUM, byte-length(FIELD) == NUM."
    inputBinding:
      position: 101
  - id: byte_len_ne
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --byte-len-ne
    doc: "FIELD:NUM, byte-length(FIELD) != NUM."
    inputBinding:
      position: 101
  - id: ff_le
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-le
    doc: "FIELD1:FIELD2, FIELD1 <= FIELD2 (numeric)."
    inputBinding:
      position: 101
  - id: ff_lt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-lt
    doc: "FIELD1:FIELD2, FIELD1 < FIELD2 (numeric)."
    inputBinding:
      position: 101
  - id: ff_ge
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-ge
    doc: "FIELD1:FIELD2, FIELD1 >= FIELD2 (numeric)."
    inputBinding:
      position: 101
  - id: ff_gt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-gt
    doc: "FIELD1:FIELD2, FIELD1 > FIELD2 (numeric)."
    inputBinding:
      position: 101
  - id: ff_eq
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-eq
    doc: "FIELD1:FIELD2, FIELD1 == FIELD2 (numeric)."
    inputBinding:
      position: 101
  - id: ff_ne
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-ne
    doc: "FIELD1:FIELD2, FIELD1 != FIELD2 (numeric)."
    inputBinding:
      position: 101
  - id: ff_str_eq
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-str-eq
    doc: "FIELD1:FIELD2, FIELD1 == FIELD2 (string)."
    inputBinding:
      position: 101
  - id: ff_istr_eq
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-istr-eq
    doc: "FIELD1:FIELD2, FIELD1 == (case-insensitive) FIELD2 (string)."
    inputBinding:
      position: 101
  - id: ff_str_ne
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-str-ne
    doc: "FIELD1:FIELD2, FIELD1 != FIELD2 (string)."
    inputBinding:
      position: 101
  - id: ff_istr_ne
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-istr-ne
    doc: "FIELD1:FIELD2, FIELD1 != (case-insensitive) FIELD2 (string)."
    inputBinding:
      position: 101
  - id: ff_absdiff_le
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-absdiff-le
    doc: "FIELD1:FIELD2:NUM, abs(FIELD1 - FIELD2) <= NUM"
    inputBinding:
      position: 101
  - id: ff_absdiff_gt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-absdiff-gt
    doc: "FIELD1:FIELD2:NUM, abs(FIELD1 - FIELD2) > NUM"
    inputBinding:
      position: 101
  - id: ff_reldiff_le
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-reldiff-le
    doc: "FIELD1:FIELD2:NUM, relative difference <= NUM"
    inputBinding:
      position: 101
  - id: ff_reldiff_gt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ff-reldiff-gt
    doc: "FIELD1:FIELD2:NUM, relative difference > NUM"
    inputBinding:
      position: 101
outputs:
  - id: tsv
    type: stdout
    doc: "Filtered TSV data (or the count with --count)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-filter_output.tsv

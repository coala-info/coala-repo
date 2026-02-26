cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_dump_data
doc: "Reads a single input PDF file and reports its metadata, bookmarks, page metrics,
  and other data to an output file or stdout.\n\nTool homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdf
    type: File
    doc: The input PDF file to report on.
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: The operation to perform (dump_data).
    default: dump_data
    inputBinding:
      position: 2
  - id: allow
    type:
      - 'null'
      - string
    doc: Permissions applied to the output PDF (e.g., Printing, ModifyContents).
    inputBinding:
      position: 103
      prefix: allow
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Restore PDF page stream compression.
    inputBinding:
      position: 103
      prefix: compress
  - id: do_ask
    type:
      - 'null'
      - boolean
    doc: Prompt for input when problems are encountered.
    inputBinding:
      position: 103
      prefix: do_ask
  - id: dont_ask
    type:
      - 'null'
      - boolean
    doc: Do not prompt for input; overwrite files without notice.
    inputBinding:
      position: 103
      prefix: dont_ask
  - id: drop_xfa
    type:
      - 'null'
      - boolean
    doc: Omit XFA data from the output PDF form.
    inputBinding:
      position: 103
      prefix: drop_xfa
  - id: drop_xmp
    type:
      - 'null'
      - boolean
    doc: Remove the PDF's document-level XMP stream.
    inputBinding:
      position: 103
      prefix: drop_xmp
  - id: encrypt_128bit
    type:
      - 'null'
      - boolean
    doc: Set output PDF encryption strength to 128 bits (default).
    inputBinding:
      position: 103
      prefix: encrypt_128bit
  - id: encrypt_40bit
    type:
      - 'null'
      - boolean
    doc: Set output PDF encryption strength to 40 bits.
    inputBinding:
      position: 103
      prefix: encrypt_40bit
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Merge input PDF's interactive form fields and data with the PDF's 
      pages.
    inputBinding:
      position: 103
      prefix: flatten
  - id: input_pw
    type:
      - 'null'
      - string
    doc: Input PDF owner password(s).
    inputBinding:
      position: 103
      prefix: input_pw
  - id: need_appearances
    type:
      - 'null'
      - boolean
    doc: Set flag to cue Reader/Acrobat to generate new field appearances.
    inputBinding:
      position: 103
      prefix: need_appearances
  - id: owner_pw
    type:
      - 'null'
      - string
    doc: Set the owner password for the output PDF.
    inputBinding:
      position: 103
      prefix: owner_pw
  - id: uncompress
    type:
      - 'null'
      - boolean
    doc: Remove PDF page stream compression.
    inputBinding:
      position: 103
      prefix: uncompress
  - id: user_pw
    type:
      - 'null'
      - string
    doc: Set the user password for the output PDF.
    inputBinding:
      position: 103
      prefix: user_pw
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output mode.
    inputBinding:
      position: 103
      prefix: verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The name of the output data file. If omitted, output goes to stdout.
    outputBinding:
      glob: $(inputs.output)

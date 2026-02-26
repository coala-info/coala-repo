cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_dump_data_utf8
doc: "Reads a single input PDF file and reports its metadata, bookmarks, page metrics,
  and other data to the given output filename or stdout, encoded as UTF-8.\n\nTool
  homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdf
    type: File
    doc: The input PDF file to be processed.
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: The operation to perform (dump_data_utf8).
    default: dump_data_utf8
    inputBinding:
      position: 2
  - id: allow
    type:
      - 'null'
      - type: array
        items: string
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
    doc: Remove the document-level XMP stream from the PDF.
    inputBinding:
      position: 103
      prefix: drop_xmp
  - id: encrypt_128bit
    type:
      - 'null'
      - boolean
    doc: Use 128-bit encryption (default if passwords are provided).
    inputBinding:
      position: 103
      prefix: encrypt_128bit
  - id: encrypt_40bit
    type:
      - 'null'
      - boolean
    doc: Override default 128-bit encryption with 40-bit encryption.
    inputBinding:
      position: 103
      prefix: encrypt_40bit
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Merge an input PDF's interactive form fields and their data with the 
      PDF's pages.
    inputBinding:
      position: 103
      prefix: flatten
  - id: input_pw
    type:
      - 'null'
      - string
    doc: Input PDF owner passwords.
    inputBinding:
      position: 103
      prefix: input_pw
  - id: keep_final_id
    type:
      - 'null'
      - boolean
    doc: Copy the document ID from the final input document into the new output 
      PDF.
    inputBinding:
      position: 103
      prefix: keep_final_id
  - id: keep_first_id
    type:
      - 'null'
      - boolean
    doc: Copy the document ID from the first input document into the new output 
      PDF.
    inputBinding:
      position: 103
      prefix: keep_first_id
  - id: need_appearances
    type:
      - 'null'
      - boolean
    doc: Cues Reader/Acrobat to generate new field appearances based on form 
      field values.
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
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename for the reported data.
    outputBinding:
      glob: $(inputs.output)

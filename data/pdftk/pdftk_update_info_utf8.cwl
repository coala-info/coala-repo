cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_update_info_utf8
doc: "Changes the bookmarks and metadata in a single PDF's Info dictionary to match
  the input data file (UTF-8 encoded).\n\nTool homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdf
    type: File
    doc: Input PDF file
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: 'The operation to perform: update_info_utf8'
    inputBinding:
      position: 2
  - id: info_data_file
    type: File
    doc: Input info data file encoded as UTF-8
    inputBinding:
      position: 3
  - id: allow
    type:
      - 'null'
      - type: array
        items: string
    doc: Permissions applied to the output PDF (e.g., Printing, ModifyContents)
    inputBinding:
      position: 104
      prefix: allow
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Restore PDF page stream compression
    inputBinding:
      position: 104
      prefix: compress
  - id: do_ask
    type:
      - 'null'
      - boolean
    doc: Prompt for input when problems are encountered
    inputBinding:
      position: 104
      prefix: do_ask
  - id: dont_ask
    type:
      - 'null'
      - boolean
    doc: Do not prompt for input (e.g., overwrite files without notice)
    inputBinding:
      position: 104
      prefix: dont_ask
  - id: drop_xfa
    type:
      - 'null'
      - boolean
    doc: Omit XFA data from the output PDF form
    inputBinding:
      position: 104
      prefix: drop_xfa
  - id: drop_xmp
    type:
      - 'null'
      - boolean
    doc: Remove the document-level XMP stream from the PDF
    inputBinding:
      position: 104
      prefix: drop_xmp
  - id: encrypt_128bit
    type:
      - 'null'
      - boolean
    doc: Encrypt output with 128-bit strength
    inputBinding:
      position: 104
      prefix: encrypt_128bit
  - id: encrypt_40bit
    type:
      - 'null'
      - boolean
    doc: Encrypt output with 40-bit strength
    inputBinding:
      position: 104
      prefix: encrypt_40bit
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Merge interactive form fields and their data with the PDF's pages
    inputBinding:
      position: 104
      prefix: flatten
  - id: input_pw
    type:
      - 'null'
      - string
    doc: Input PDF owner password
    inputBinding:
      position: 104
      prefix: input_pw
  - id: keep_final_id
    type:
      - 'null'
      - boolean
    doc: Copy the document ID from the final input document
    inputBinding:
      position: 104
      prefix: keep_final_id
  - id: keep_first_id
    type:
      - 'null'
      - boolean
    doc: Copy the document ID from the first input document
    inputBinding:
      position: 104
      prefix: keep_first_id
  - id: need_appearances
    type:
      - 'null'
      - boolean
    doc: Set flag to cue Reader to generate new field appearances
    inputBinding:
      position: 104
      prefix: need_appearances
  - id: owner_pw
    type:
      - 'null'
      - string
    doc: Set the owner password
    inputBinding:
      position: 104
      prefix: owner_pw
  - id: uncompress
    type:
      - 'null'
      - boolean
    doc: Remove PDF page stream compression
    inputBinding:
      position: 104
      prefix: uncompress
  - id: user_pw
    type:
      - 'null'
      - string
    doc: Set the user password
    inputBinding:
      position: 104
      prefix: user_pw
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more information during execution
    inputBinding:
      position: 104
      prefix: verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output)

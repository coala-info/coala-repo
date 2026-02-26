cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_attach_files
doc: "Packs arbitrary files into a PDF using PDF's file attachment features.\n\nTool
  homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdf
    type: File
    doc: Input PDF file
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: The operation to perform
    default: attach_files
    inputBinding:
      position: 2
  - id: attachment_files
    type:
      type: array
      items: File
    doc: Arbitrary files to pack into the PDF
    inputBinding:
      position: 3
  - id: allow
    type:
      - 'null'
      - type: array
        items: string
    doc: Permissions applied to the output PDF (e.g., Printing, ModifyContents, 
      etc.)
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
    doc: Use 128-bit encryption for output PDF
    inputBinding:
      position: 104
      prefix: encrypt_128bit
  - id: encrypt_40bit
    type:
      - 'null'
      - boolean
    doc: Use 40-bit encryption for output PDF
    inputBinding:
      position: 104
      prefix: encrypt_40bit
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Merge input PDF's interactive form fields and their data with the PDF's
      pages
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
  - id: owner_pw
    type:
      - 'null'
      - string
    doc: Set the owner password for the output PDF
    inputBinding:
      position: 104
      prefix: owner_pw
  - id: to_page
    type:
      - 'null'
      - string
    doc: Attach files to a specific page number (1-based, or 'end'). If omitted,
      files are attached at the document level.
    inputBinding:
      position: 104
      prefix: to_page
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
    doc: Set the user password for the output PDF
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
    doc: Output PDF filename
    outputBinding:
      glob: $(inputs.output)

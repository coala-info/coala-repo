cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_multibackground
doc: "Applies each page of the background PDF to the corresponding page of the input
  PDF. If the input PDF has more pages than the background PDF, then the final background
  page is repeated across the remaining pages.\n\nTool homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdfs
    type:
      type: array
      items: File
    doc: A list of the input PDF files.
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: The operation to perform
    inputBinding:
      position: 2
  - id: background_pdf
    type: File
    doc: The background PDF to apply to the input PDF.
    inputBinding:
      position: 3
  - id: allow
    type:
      - 'null'
      - type: array
        items: string
    doc: Permissions applied to the output PDF (e.g., Printing, ModifyContents).
    inputBinding:
      position: 104
      prefix: allow
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Apply PDF page stream compression.
    inputBinding:
      position: 104
      prefix: compress
  - id: do_ask
    type:
      - 'null'
      - boolean
    doc: Prompt for input when problems are encountered.
    inputBinding:
      position: 104
      prefix: do_ask
  - id: dont_ask
    type:
      - 'null'
      - boolean
    doc: Do not prompt for input; overwrite files without notice.
    inputBinding:
      position: 104
      prefix: dont_ask
  - id: drop_xfa
    type:
      - 'null'
      - boolean
    doc: Omit XFA data from the output PDF form.
    inputBinding:
      position: 104
      prefix: drop_xfa
  - id: drop_xmp
    type:
      - 'null'
      - boolean
    doc: Remove the document-level XMP stream from the PDF.
    inputBinding:
      position: 104
      prefix: drop_xmp
  - id: encrypt_128bit
    type:
      - 'null'
      - boolean
    doc: Set output PDF encryption strength to 128 bits (default).
    inputBinding:
      position: 104
      prefix: encrypt_128bit
  - id: encrypt_40bit
    type:
      - 'null'
      - boolean
    doc: Set output PDF encryption strength to 40 bits.
    inputBinding:
      position: 104
      prefix: encrypt_40bit
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Merge an input PDF's interactive form fields and their data with the 
      PDF's pages.
    inputBinding:
      position: 104
      prefix: flatten
  - id: input_pw
    type:
      - 'null'
      - string
    doc: Input PDF owner passwords.
    inputBinding:
      position: 104
      prefix: input_pw
  - id: keep_final_id
    type:
      - 'null'
      - boolean
    doc: Copy the document ID from the final input document into the new output 
      PDF.
    inputBinding:
      position: 104
      prefix: keep_final_id
  - id: keep_first_id
    type:
      - 'null'
      - boolean
    doc: Copy the document ID from the first input document into the new output 
      PDF.
    inputBinding:
      position: 104
      prefix: keep_first_id
  - id: need_appearances
    type:
      - 'null'
      - boolean
    doc: Sets a flag that cues Reader/Acrobat to generate new field appearances.
    inputBinding:
      position: 104
      prefix: need_appearances
  - id: owner_pw
    type:
      - 'null'
      - string
    doc: Set the owner password for the output PDF.
    inputBinding:
      position: 104
      prefix: owner_pw
  - id: uncompress
    type:
      - 'null'
      - boolean
    doc: Remove PDF page stream compression.
    inputBinding:
      position: 104
      prefix: uncompress
  - id: user_pw
    type:
      - 'null'
      - string
    doc: Set the user password for the output PDF.
    inputBinding:
      position: 104
      prefix: user_pw
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more information during processing.
    inputBinding:
      position: 104
      prefix: verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename. Use - for stdout.
    outputBinding:
      glob: $(inputs.output)

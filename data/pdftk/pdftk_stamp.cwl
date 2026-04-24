cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_stamp
doc: "Apply a foreground stamp to a PDF document. This behaves like the background
  operation except it overlays the stamp PDF page on top of the input PDF document's
  pages.\n\nTool homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdf
    type: File
    doc: The input PDF file to be stamped.
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: The operation to perform (stamp).
    inputBinding:
      position: 2
  - id: stamp_pdf
    type: File
    doc: The PDF file to use as a stamp. Only the first page is used and applied
      to every page of the input PDF.
    inputBinding:
      position: 3
  - id: allow
    type:
      - 'null'
      - type: array
        items: string
    doc: Permissions applied to the output PDF (e.g., Printing, CopyContents).
    inputBinding:
      position: 104
      prefix: allow
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Restore PDF page stream compression.
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
    doc: Use 128-bit encryption for the output PDF (default).
    inputBinding:
      position: 104
      prefix: encrypt_128bit
  - id: encrypt_40bit
    type:
      - 'null'
      - boolean
    doc: Use 40-bit encryption for the output PDF.
    inputBinding:
      position: 104
      prefix: encrypt_40bit
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Merge the input PDF's interactive form fields and their data with the 
      PDF's pages.
    inputBinding:
      position: 104
      prefix: flatten
  - id: input_pw
    type:
      - 'null'
      - string
    doc: Input PDF owner password.
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
    doc: Set a flag that cues Reader/Acrobat to generate new field appearances.
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
    doc: Enable verbose output.
    inputBinding:
      position: 104
      prefix: verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The output filename for the stamped PDF.
    outputBinding:
      glob: $(inputs.output)

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_fill_form
doc: "Fills the single input PDF's form fields with the data from an FDF file, XFDF
  file or stdin.\n\nTool homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdf
    type: File
    doc: Input PDF file
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: The operation to perform (fill_form)
    inputBinding:
      position: 2
  - id: fdf_data_file
    type: File
    doc: FDF data filename, XFDF data filename, or -
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
    doc: Use the compress filter to restore compression
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
    doc: Do not prompt for input
    inputBinding:
      position: 104
      prefix: dont_ask
  - id: drop_xfa
    type:
      - 'null'
      - boolean
    doc: Omit the XFA data from the output PDF form
    inputBinding:
      position: 104
      prefix: drop_xfa
  - id: drop_xmp
    type:
      - 'null'
      - boolean
    doc: Remove the XMP stream from the PDF altogether
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
    doc: Merge input PDF's interactive form fields (and their data) with the 
      PDF's pages
    inputBinding:
      position: 104
      prefix: flatten
  - id: input_pw
    type:
      - 'null'
      - string
    doc: Input PDF owner passwords
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
    doc: Sets a flag that cues Reader/Acrobat to generate new field appearances
    inputBinding:
      position: 104
      prefix: need_appearances
  - id: owner_pw
    type:
      - 'null'
      - string
    doc: Owner password for the output PDF
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
    doc: User password for the output PDF
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

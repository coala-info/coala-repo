cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_burst
doc: "Splits a single input PDF document into individual pages. Also creates a report
  named doc_data.txt.\n\nTool homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdf
    type: File
    doc: Input PDF file to be burst
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: The operation to perform (burst)
    inputBinding:
      position: 2
  - id: allow
    type:
      - 'null'
      - type: array
        items: string
    doc: Permissions applied to the output PDF (Printing, DegradedPrinting, 
      ModifyContents, Assembly, CopyContents, ScreenReaders, ModifyAnnotations, 
      FillIn, AllFeatures)
    inputBinding:
      position: 103
      prefix: allow
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Restore PDF page stream compression
    inputBinding:
      position: 103
      prefix: compress
  - id: do_ask
    type:
      - 'null'
      - boolean
    doc: Prompt for input when problems are encountered
    inputBinding:
      position: 103
      prefix: do_ask
  - id: dont_ask
    type:
      - 'null'
      - boolean
    doc: Do not prompt for input; overwrite files without notice
    inputBinding:
      position: 103
      prefix: dont_ask
  - id: drop_xfa
    type:
      - 'null'
      - boolean
    doc: Omit XFA data from the output PDF form
    inputBinding:
      position: 103
      prefix: drop_xfa
  - id: drop_xmp
    type:
      - 'null'
      - boolean
    doc: Remove the document-level XMP stream from the PDF
    inputBinding:
      position: 103
      prefix: drop_xmp
  - id: encrypt_128bit
    type:
      - 'null'
      - boolean
    doc: Use 128-bit encryption (default if password provided)
    inputBinding:
      position: 103
      prefix: encrypt_128bit
  - id: encrypt_strength
    type:
      - 'null'
      - boolean
    doc: Override default 128-bit encryption with 40-bit
    inputBinding:
      position: 103
      prefix: encrypt_40bit
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Merge interactive form fields and their data with the PDF's pages
    inputBinding:
      position: 103
      prefix: flatten
  - id: input_pw
    type:
      - 'null'
      - string
    doc: Input PDF owner password
    inputBinding:
      position: 103
      prefix: input_pw
  - id: need_appearances
    type:
      - 'null'
      - boolean
    doc: Cue Reader to generate new field appearances based on form field values
    inputBinding:
      position: 103
      prefix: need_appearances
  - id: owner_pw
    type:
      - 'null'
      - string
    doc: Set the owner password for the output PDFs
    inputBinding:
      position: 103
      prefix: owner_pw
  - id: uncompress
    type:
      - 'null'
      - boolean
    doc: Remove PDF page stream compression
    inputBinding:
      position: 103
      prefix: uncompress
  - id: user_pw
    type:
      - 'null'
      - string
    doc: Set the user password for the output PDFs
    inputBinding:
      position: 103
      prefix: user_pw
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: verbose
outputs:
  - id: output_format
    type:
      - 'null'
      - File
    doc: Printf-styled format string for output pages (e.g. pg_%04d.pdf) or 
      output directory
    outputBinding:
      glob: $(inputs.output_format)

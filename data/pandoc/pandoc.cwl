cwlVersion: v1.2
class: CommandLineTool
baseCommand: pandoc
label: pandoc
doc: "Pandoc is a Haskell library for converting from one markup format to another,
  and a command-line tool that uses this library.\n\nTool homepage: https://github.com/jgm/pandoc"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to be converted. If no files are specified, input is read from
      stdin.
    inputBinding:
      position: 1
  - id: extract_media
    type:
      - 'null'
      - Directory
    doc: Extract images and other media contained in a docx or epub container to the
      specified directory.
    inputBinding:
      position: 102
      prefix: --extract-media
  - id: filter
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify an executable to be used as a filter transforming the pandoc AST.
    inputBinding:
      position: 102
      prefix: --filter
  - id: from
    type:
      - 'null'
      - string
    doc: Specify input format.
    inputBinding:
      position: 102
      prefix: --from
  - id: metadata
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the metadata field KEY to the value VALUE.
    inputBinding:
      position: 102
      prefix: --metadata
  - id: number_sections
    type:
      - 'null'
      - boolean
    doc: Number section headings in LaTeX, ConTeXt, HTML, or EPUB output.
    inputBinding:
      position: 102
      prefix: --number-sections
  - id: pdf_engine
    type:
      - 'null'
      - string
    doc: Use the specified engine when producing PDF output (e.g. pdflatex, wkhtmltopdf).
    inputBinding:
      position: 102
      prefix: --pdf-engine
  - id: resource_path
    type:
      - 'null'
      - string
    doc: List of paths to search for images and other resources.
    inputBinding:
      position: 102
      prefix: --resource-path
  - id: standalone
    type:
      - 'null'
      - boolean
    doc: Produce output with an appropriate header and footer.
    inputBinding:
      position: 102
      prefix: --standalone
  - id: table_of_contents
    type:
      - 'null'
      - boolean
    doc: Include an automatically generated table of contents.
    inputBinding:
      position: 102
      prefix: --toc
  - id: to
    type:
      - 'null'
      - string
    doc: Specify output format.
    inputBinding:
      position: 102
      prefix: --to
  - id: variable
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the template variable KEY to VALUE.
    inputBinding:
      position: 102
      prefix: --variable
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to FILE instead of stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandoc:2.1.3--0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdftk
label: pdftk_unpack_files
doc: "Copies all of the attachments from the input PDF into the current folder or
  to an output directory given after output.\n\nTool homepage: https://github.com/mikehaertl/php-pdftk"
inputs:
  - id: input_pdf
    type: File
    doc: The input PDF file containing attachments.
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: The operation to perform (unpack_files).
    default: unpack_files
    inputBinding:
      position: 2
  - id: do_ask
    type:
      - 'null'
      - boolean
    doc: pdftk will prompt you for further input when it encounters a problem.
    inputBinding:
      position: 103
      prefix: do_ask
  - id: dont_ask
    type:
      - 'null'
      - boolean
    doc: pdftk won't ask you what to do; will over-write files with its output 
      without notice.
    inputBinding:
      position: 103
      prefix: dont_ask
  - id: input_pw
    type:
      - 'null'
      - string
    doc: Input PDF owner password, if necessary.
    inputBinding:
      position: 103
      prefix: input_pw
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: By default, pdftk runs quietly. Append verbose to the end and it will 
      speak up.
    inputBinding:
      position: 103
      prefix: verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The name of an output directory where attachments will be copied.
    outputBinding:
      glob: $(inputs.output_directory)

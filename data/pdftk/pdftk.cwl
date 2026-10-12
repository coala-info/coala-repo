cwlVersion: v1.2
class: CommandLineTool
label: pdftk
doc: A handy tool for manipulating PDF documents, including merging, splitting, 
  rotating, encrypting, and filling forms. The pdftk/pdftk image starts pdftk as
  its entrypoint, so the command line has no base command.
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: The input PDF files, in the order to combine them. Give handles in
      the handles input to name them (A=in1.pdf).
    inputBinding:
      position: 1
      valueFrom: |
        ${
          return self.map(function(f, i) {
            return (inputs.handles && inputs.handles[i]) ? inputs.handles[i] + "=" + f.path : f.path;
          });
        }
  - id: handles
    type:
      - 'null'
      - type: array
        items: string
    doc: Upper-case handles for the input files, in the same order (for
      example A, B). Page ranges and passwords refer to them.
  - id: operation
    type:
      - 'null'
      - string
    doc: 'The operation to perform: cat, shuffle, burst, rotate, generate_fdf, fill_form,
      background, multibackground, stamp, multistamp, dump_data, dump_data_utf8, dump_data_fields,
      dump_data_fields_utf8, dump_data_annots, update_info, update_info_utf8, attach_files,
      unpack_files.'
    inputBinding:
      position: 3
  - id: operation_arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Text arguments of the chosen operation (for example page ranges for
      cat, such as A1-3 B, or to_page 2 for attach_files).
    inputBinding:
      position: 5
  - id: operation_file_arguments
    type:
      - 'null'
      - type: array
        items: File
    doc: File arguments of the chosen operation (for example the FDF or XFDF
      file of fill_form, the PDF of background or stamp, the info file of
      update_info, or the files of attach_files).
    inputBinding:
      position: 4
  - id: input_pw
    type:
      - 'null'
      - type: array
        items: string
    doc: Input PDF owner passwords associated with files by using their handles.
    inputBinding:
      position: 2
      prefix: input_pw
  - id: output
    type: string
    doc: The output filename, directory (for unpack_files), or printf-styled 
      format string (for burst, for example pg_%04d.pdf).
    inputBinding:
      position: 100
      prefix: output
  - id: encryption
    type:
      - 'null'
      - string
    doc: 'Encryption algorithm to use: encrypt_40bit, encrypt_128bit, or encrypt_aes128.'
    inputBinding:
      position: 104
  - id: allow
    type:
      - 'null'
      - type: array
        items: string
    doc: Permissions applied to the output PDF (e.g., Printing, ModifyContents, 
      etc.).
    inputBinding:
      position: 104
      prefix: allow
  - id: owner_pw
    type:
      - 'null'
      - string
    doc: Set the owner password for the output PDF.
    inputBinding:
      position: 104
      prefix: owner_pw
  - id: user_pw
    type:
      - 'null'
      - string
    doc: Set the user password for the output PDF.
    inputBinding:
      position: 104
      prefix: user_pw
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Merge an input PDF's interactive form fields and their data with the 
      PDF's pages.
    inputBinding:
      position: 104
      prefix: flatten
  - id: need_appearances
    type:
      - 'null'
      - boolean
    doc: Sets a flag that cues Reader/Acrobat to generate new field appearances 
      based on the form field values.
    inputBinding:
      position: 104
      prefix: need_appearances
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Restore PDF page stream compression.
    inputBinding:
      position: 104
      prefix: compress
  - id: uncompress
    type:
      - 'null'
      - boolean
    doc: Remove PDF page stream compression.
    inputBinding:
      position: 104
      prefix: uncompress
  - id: keep_first_id
    type:
      - 'null'
      - boolean
    doc: Copy the document ID from the first input document into the new output 
      PDF.
    inputBinding:
      position: 104
      prefix: keep_first_id
  - id: keep_final_id
    type:
      - 'null'
      - boolean
    doc: Copy the document ID from the final input document into the new output 
      PDF.
    inputBinding:
      position: 104
      prefix: keep_final_id
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
    doc: Remove the PDF's document-level XMP stream.
    inputBinding:
      position: 104
      prefix: drop_xmp
  - id: replacement_font
    type:
      - 'null'
      - string
    doc: Use the specified font to display text in form fields.
    inputBinding:
      position: 104
      prefix: replacement_font
  - id: dont_ask
    type:
      - 'null'
      - boolean
    doc: Do not prompt for input (e.g., when overwriting files).
    inputBinding:
      position: 104
      prefix: dont_ask
  - id: do_ask
    type:
      - 'null'
      - boolean
    doc: Prompt for input when problems are encountered.
    inputBinding:
      position: 104
      prefix: do_ask
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: The output filename, directory (for unpack_files), or printf-styled 
      format string (for burst).
    outputBinding:
      glob: |
        ${
          if (inputs.operation == 'unpack_files' || inputs.operation == 'burst') { return []; }
          return inputs.output;
        }
  - id: burst_pages
    type:
      - 'null'
      - type: array
        items: File
    doc: The single page PDFs and doc_data.txt written by the burst operation.
    outputBinding:
      glob: |
        ${
          if (inputs.operation != 'burst') { return []; }
          var p = inputs.output.replace(/%0?[0-9]*d/, '*');
          return [p, 'doc_data.txt'];
        }
  - id: unpacked_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The files written by the unpack_files operation (output is a directory).
    outputBinding:
      glob: |
        ${
          if (inputs.operation != 'unpack_files') { return []; }
          return inputs.output + '/*';
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: '$(inputs.operation == "unpack_files" ? inputs.output : ".pdftk_unused")'
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: pdftk/pdftk
s:url: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/
$namespaces:
  s: https://schema.org/

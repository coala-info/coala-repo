cwlVersion: v1.2
class: CommandLineTool
baseCommand: protxml_to_psql.rb
label: protk_protxml_to_psql.rb
doc: 'Convert a protXML file to a sqlite database.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: protxml_file
    type: File
    doc: Input protXML file
    inputBinding:
      position: 1
  - id: spectrum_files
    type:
      - 'null'
      - type: array
        items: File
    doc: mzML spectrum files from which spectra are looked up
    inputBinding:
      position: 2
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: database
    type:
      - 'null'
      - File
    doc: A Fasta file where full protein sequences can be looked up
    inputBinding:
      position: 102
      prefix: --database
  - id: output_path
    type: string
    doc: An explicitly named output (sqlite database) file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: sqlite database
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1

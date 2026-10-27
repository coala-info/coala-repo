cwlVersion: v1.2
class: CommandLineTool
baseCommand: WhatsGNU_database_customizer.py
label: whatsgnu_database_customizer
doc: "Database customizer script for WhatsGNU: prepares faa, RAST or gff files
  (modifies locus tags and writes individual or concatenated files) for building
  a WhatsGNU database.\n\nTool homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs:
  - id: prefix_name
    type: string
    doc: prefix name for the output folder and the one concatenated modified file
    inputBinding:
      position: 100
  - id: directory_path
    type: Directory
    doc: path to directory of faa, RAST txt or gff files (staged as input_dir; the
      tool creates its output folder beside the input directory)
    inputBinding:
      position: 101
      valueFrom: input_dir/
  - id: genbank_refseq
    type:
      - 'null'
      - boolean
    doc: faa files from GenBank or RefSeq
    inputBinding:
      position: 1
      prefix: --GenBank_RefSeq
  - id: prokka
    type:
      - 'null'
      - boolean
    doc: faa files from Prokka
    inputBinding:
      position: 1
      prefix: --prokka
  - id: rast
    type:
      - 'null'
      - boolean
    doc: spreadsheet tab-separated text files from RAST
    inputBinding:
      position: 1
      prefix: --RAST
  - id: gff_file
    type:
      - 'null'
      - boolean
    doc: gff file from prokka, needed if planning to run Roary
    inputBinding:
      position: 1
      prefix: --gff_file
  - id: gzipped
    type:
      - 'null'
      - boolean
    doc: compressed file (.gz)
    inputBinding:
      position: 1
      prefix: --gzipped
  - id: list_csv
    type:
      - 'null'
      - File
    doc: 'a file.csv of 3+ columns - file_name, old locustag, new locustag and optionally metadata'
    inputBinding:
      position: 1
      prefix: --list_csv
  - id: individual_files
    type:
      - 'null'
      - boolean
    doc: individual modified files
    inputBinding:
      position: 1
      prefix: --individual_files
  - id: concatenated_file
    type:
      - 'null'
      - boolean
    doc: one concatenated modified file of all input files
    inputBinding:
      position: 1
      prefix: --concatenated_file
outputs:
  - id: output_folder
    type: Directory
    doc: Output folder (named after prefix_name) with the modified files
    outputBinding:
      glob: $(inputs.prefix_name)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: input_dir
        entry: $(inputs.directory_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0

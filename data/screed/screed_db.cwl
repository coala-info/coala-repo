cwlVersion: v1.2
class: CommandLineTool
baseCommand: [screed, db]
label: screed_db
doc: "Creates a screed database from a FASTA or FASTQ file. The database is written\
  \ next to the input as <filename>_screed.\n\nTool homepage: http://github.com/dib-lab/screed/"
inputs:
  - id: filename
    type: File
    doc: The name of the FASTA or FASTQ file to process.
    inputBinding:
      position: 1
outputs:
  - id: db_file
    type: File
    doc: The screed database, named <filename>_screed
    outputBinding:
      glob: $(inputs.filename.basename)_screed
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.filename)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screed:1.0.4--py_0

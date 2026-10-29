cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ncbi.py
  - prep_sra_table
label: viral-ngs_ncbi_prep_sra_table
doc: "This is a very lazy hack that creates a basic table that can be pasted into various columns of an SRA submission spreadsheet. It probably doesn't work in all cases.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: lib_fname
    type: File
    doc: "A file that lists all of the library IDs that will be submitted in this batch"
    inputBinding:
      position: 1
  - id: biosample_file
    type: File
    doc: "A file with two columns and a header: sample and BioSample. This file may refer to samples that are not included in this submission."
    inputBinding:
      position: 2
  - id: md5_fname
    type: File
    doc: "A file with two columns and no header. Two columns are MD5 checksum and filename. Should contain an entry for every bam file being submitted in this batch. This is typical output from \"md5sum *.cleaned.bam\"."
    inputBinding:
      position: 3
  - id: out_file
    type: string
    doc: "Output table that contains most of the variable columns needed for SRA submission."
    inputBinding:
      position: 4
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: out_file_file
    type: File
    doc: "Output file written to out_file"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0

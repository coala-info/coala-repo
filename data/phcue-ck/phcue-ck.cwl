cwlVersion: v1.2
class: CommandLineTool
baseCommand: phcue-ck
label: phcue-ck
doc: "phcue-ck is a command line tool to obtain FTP links to FASTQ files from ENA
  using run accession\n\nTool homepage: https://lgi-onehealth.github.io/phcue-ck/"
inputs:
  - id: accession
    type:
      - 'null'
      - type: array
        items: string
    doc: The accession of the run to query (must be an SRR, ERR or DRR 
      accession)
    inputBinding:
      position: 101
      prefix: --accession
  - id: file
    type:
      - 'null'
      - File
    doc: File containing accessions to query
    inputBinding:
      position: 101
      prefix: --file
  - id: keep_single_end
    type:
      - 'null'
      - boolean
    doc: Keep single end reads if there are paired end reads too
    inputBinding:
      position: 101
      prefix: --keep-single-end
  - id: num_requests
    type:
      - 'null'
      - int
    doc: Maximum number of concurrent requests to make to the ENA API (max of 10
      are allowed)
    default: 1
    inputBinding:
      position: 101
      prefix: --num-requests
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Format for output of data. [possible values: json, csv, csv-wide, csv-long]'
    default: json
    inputBinding:
      position: 101
      prefix: --output-format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phcue-ck:0.2.0--h3dc2dae_4
stdout: phcue-ck.out

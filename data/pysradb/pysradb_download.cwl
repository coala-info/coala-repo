cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb_download
label: pysradb_download
doc: "Download SRA data. Accepts a list of accession IDs from stdin or a file.\n\n\
  Tool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: accession_ids
    type:
      type: array
      items: string
    doc: List of SRA accession IDs (e.g., SRR12345, SRP67890). Can be provided 
      via stdin or a file.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files if they are incomplete.
    inputBinding:
      position: 102
      prefix: --force
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save downloaded files. Defaults to the current directory.
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: skip_metadata
    type:
      - 'null'
      - boolean
    doc: Skip downloading metadata files (e.g., .info, .sra.runinfo.xml).
    inputBinding:
      position: 102
      prefix: --skip-metadata
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel download threads. Defaults to 1.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
stdout: pysradb_download.out

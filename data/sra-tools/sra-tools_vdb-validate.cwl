cwlVersion: v1.2
class: CommandLineTool
baseCommand: vdb-validate
label: sra-tools_vdb-validate
doc: "Examine directories, files and VDB objects, reporting any problems that can
  be detected.\n\nTool homepage: https://github.com/ncbi/sra-tools"
inputs:
  - id: paths
    type:
      type: array
      items: string
    doc: Path(s) to examine
    inputBinding:
      position: 1
  - id: check_blob_crc
    type:
      - 'null'
      - boolean
    doc: Check blobs CRC32
    inputBinding:
      position: 102
      prefix: --BLOB-CRC
  - id: check_consistency
    type:
      - 'null'
      - boolean
    doc: Deeply check data consistency for tables
    inputBinding:
      position: 102
      prefix: --CONSISTENCY-CHECK
  - id: check_redact
    type:
      - 'null'
      - boolean
    doc: check if redaction of bases has been correctly performed
    inputBinding:
      position: 102
      prefix: --check-redact
  - id: check_referential_integrity
    type:
      - 'null'
      - boolean
    doc: Check data referential integrity for databases
    inputBinding:
      position: 102
      prefix: --REFERENTIAL-INTEGRITY
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: Continue checking object for all possible errors
    inputBinding:
      position: 102
      prefix: --exhaustive
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of 
      (fatal|sys|int|err|warn|info|debug) or (0-6) Current/default is warn.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: ngc_path
    type:
      - 'null'
      - File
    doc: path to ngc file
    inputBinding:
      position: 102
      prefix: --ngc
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program. Negated by verbose.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: require_blob_checksums
    type:
      - 'null'
      - boolean
    doc: Require blob checksums
    inputBinding:
      position: 102
      prefix: --require-blob-checksums
  - id: sdc_plen_thold
    type:
      - 'null'
      - string
    doc: Specify threshold for amount of secondary alignment which are shorter 
      (hard-clipped) than corresponding primaries, default 1%.
    inputBinding:
      position: 102
      prefix: --sdc:plen_thold
  - id: sdc_rows
    type:
      - 'null'
      - string
    doc: Specify maximum amount of secondary alignment table rows to look at 
      before saying accession is good, default 100000. Specifying will iterate 
      the whole table. Can be in percent (e.g. 5%)
    inputBinding:
      position: 102
      prefix: --sdc:rows
  - id: sdc_seq_rows
    type:
      - 'null'
      - string
    doc: Specify maximum amount of sequence table rows to look at before saying 
      accession is good, default 100000. Specifying will iterate the whole 
      table. Can be in percent (e.g. 5%)
    inputBinding:
      position: 102
      prefix: --sdc:seq-rows
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of the program status messages. Use multiple 
      times for more verbosity. Negates quiet.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools_vdb-validate.out

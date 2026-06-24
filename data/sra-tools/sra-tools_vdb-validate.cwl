cwlVersion: v1.2
class: CommandLineTool
baseCommand: vdb-validate
label: sra-tools_vdb-validate
doc: Examine directories, files and VDB objects, reporting any problems that can
  be detected. Components md5s are always checked if present.
inputs:
  - id: path
    type:
      type: array
      items: string
    doc: Path to directories, files or VDB objects to examine
    inputBinding:
      position: 1
  - id: blob_crc
    type:
      - 'null'
      - string
    doc: Check blobs CRC32 (yes | no)
    inputBinding:
      position: 102
      prefix: --BLOB-CRC
  - id: referential_integrity
    type:
      - 'null'
      - string
    doc: Check data referential integrity for databases (yes | no)
    inputBinding:
      position: 102
      prefix: --REFERENTIAL-INTEGRITY
  - id: consistency_check
    type:
      - 'null'
      - string
    doc: Deeply check data consistency for tables (yes | no)
    inputBinding:
      position: 102
      prefix: --CONSISTENCY-CHECK
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: Continue checking object for all possible errors
    inputBinding:
      position: 102
      prefix: --exhaustive
  - id: sdc_rows
    type:
      - 'null'
      - string
    doc: Specify maximum amount of secondary alignment table rows to look at 
      before saying accession is good. Can be in percent (e.g. 5%)
    inputBinding:
      position: 102
      prefix: --sdc:rows
  - id: sdc_seq_rows
    type:
      - 'null'
      - string
    doc: Specify maximum amount of sequence table rows to look at before saying 
      accession is good. Can be in percent (e.g. 5%)
    inputBinding:
      position: 102
      prefix: --sdc:seq-rows
  - id: sdc_plen_thold
    type:
      - 'null'
      - string
    doc: Specify threshold for amount of secondary alignment which are shorter 
      (hard-clipped) than corresponding primaries
    inputBinding:
      position: 102
      prefix: --sdc:plen_thold
  - id: ngc
    type: File
    doc: path to ngc file
    inputBinding:
      position: 102
      prefix: --ngc
  - id: check_redact
    type:
      - 'null'
      - boolean
    doc: check if redaction of bases has been correctly performed
    inputBinding:
      position: 102
      prefix: --check-redact
  - id: require_blob_checksums
    type:
      - 'null'
      - boolean
    doc: Require blob checksums
    inputBinding:
      position: 102
      prefix: --require-blob-checksums
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of 
      (fatal|sys|int|err|warn|info|debug) or (0-6)
    inputBinding:
      position: 102
      prefix: --log-level
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program. Negated by verbose.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
stdout: sra-tools_vdb-validate.out
s:url: https://github.com/ncbi/sra-tools
$namespaces:
  s: https://schema.org/

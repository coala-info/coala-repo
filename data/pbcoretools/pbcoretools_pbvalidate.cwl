cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbvalidate
label: pbcoretools_pbvalidate
doc: "Utility for validating files produced by PacBio software against our own internal
  specifications.\n\nTool homepage: https://github.com/mpkocher/pbcoretools"
inputs:
  - id: file
    type: File
    doc: BAM, FASTA, or DataSet XML file
    inputBinding:
      position: 1
  - id: aligned
    type:
      - 'null'
      - boolean
    doc: Specify that the file should contain only mapped alignments
    inputBinding:
      position: 102
      prefix: --aligned
  - id: contents
    type:
      - 'null'
      - string
    doc: Enforce read type (SUBREAD, CCS)
    inputBinding:
      position: 102
      prefix: --contents
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Alias for setting log level to DEBUG
    inputBinding:
      position: 102
      prefix: --debug
  - id: index
    type:
      - 'null'
      - boolean
    doc: Require index files (.fai or .pbi)
    inputBinding:
      position: 102
      prefix: --index
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
    inputBinding:
      position: 102
      prefix: --log-level
  - id: mapped
    type:
      - 'null'
      - boolean
    doc: Alias for --aligned
    inputBinding:
      position: 102
      prefix: --mapped
  - id: max_errors
    type:
      - 'null'
      - int
    doc: 'Exit after MAX_ERRORS have been recorded (DEFAULT: check entire file)'
    inputBinding:
      position: 102
      prefix: --max
  - id: max_records
    type:
      - 'null'
      - int
    doc: 'Exit after MAX_RECORDS have been inspected (DEFAULT: check entire file)'
    inputBinding:
      position: 102
      prefix: --max-records
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Limits validation to the first 100 records (plus file header); equivalent
      to --max-records=100
    inputBinding:
      position: 102
      prefix: --quick
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Alias for setting log level to CRITICAL to suppress output.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to optional reference FASTA file, used for additional validation of
      mapped BAM records
    inputBinding:
      position: 102
      prefix: --reference
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Turn on additional validation, primarily for DataSet XML
    inputBinding:
      position: 102
      prefix: --strict
  - id: type
    type:
      - 'null'
      - string
    doc: Use the specified file type instead of guessing (BAM, Fasta, AlignmentSet,
      etc.)
    inputBinding:
      position: 102
      prefix: --type
  - id: unaligned
    type:
      - 'null'
      - boolean
    doc: Specify that the file should contain only unmapped alignments
    inputBinding:
      position: 102
      prefix: --unaligned
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: Alias for --unaligned
    inputBinding:
      position: 102
      prefix: --unmapped
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set the verbosity level.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Write the log to file. Default(None) will write to stdout.
    outputBinding:
      glob: $(inputs.log_file)
  - id: xunit_out
    type:
      - 'null'
      - File
    doc: Xunit test results for Jenkins
    outputBinding:
      glob: $(inputs.xunit_out)
  - id: alarms_out
    type:
      - 'null'
      - File
    doc: alarms.json for errors
    outputBinding:
      glob: $(inputs.alarms_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbcoretools:0.8.1--py_1

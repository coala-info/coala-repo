cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_jannocoalesce
doc: 'Coalesce information from one or multiple janno files to another one


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: jannocoalesce
inputs:
  - id: log_mode
    type:
      - 'null'
      - string
    doc: 'How information should be reported: NoLog, SimpleLog, DefaultLog, ServerLog
      or VerboseLog. (default: DefaultLog)'
    inputBinding:
      position: 1
      prefix: --logMode
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Short for --logMode VerboseLog.
    inputBinding:
      position: 2
      prefix: --debug
  - id: err_length
    type:
      - 'null'
      - string
    doc: 'After how many characters should a potential genotype data parsing error
      message be truncated. "Inf" for no truncation. (default: CharCount 1500)'
    inputBinding:
      position: 3
      prefix: --errLength
  - id: in_plink_pop_name
    type:
      - 'null'
      - string
    doc: 'Where to read the population/group name from the FAM file in Plink-format:
      asFamily (default) | asPhenotype | asBoth.'
    inputBinding:
      position: 4
      prefix: --inPlinkPopName
  - id: source_file
    type:
      - 'null'
      - File
    doc: The source .janno file.
    inputBinding:
      position: 100
      prefix: --sourceFile
  - id: base_dir
    type:
      - 'null'
      - Directory
    doc: A base directory to search for Poseidon packages.
    inputBinding:
      position: 100
      prefix: --baseDir
  - id: target_file
    type: File
    doc: The target .janno file to fill. It is staged writable, so it can also be
      changed in place.
    inputBinding:
      position: 100
      prefix: --targetFile
      valueFrom: $(self.basename)
  - id: out_file
    type:
      - 'null'
      - string
    doc: An optional file to write the results to. If not specified, the target file
      is changed in place.
    inputBinding:
      position: 100
      prefix: --outFile
  - id: include_columns
    type:
      - 'null'
      - string
    doc: A comma-separated list of .janno column names to coalesce. If not specified,
      all columns found in the source and target are filled.
    inputBinding:
      position: 100
      prefix: --includeColumns
  - id: exclude_columns
    type:
      - 'null'
      - string
    doc: A comma-separated list of .janno column names NOT to coalesce.
    inputBinding:
      position: 100
      prefix: --excludeColumns
  - id: force
    type:
      - 'null'
      - boolean
    doc: Override non-missing content in target columns with non-missing content in
      source columns.
    inputBinding:
      position: 100
      prefix: --force
  - id: source_key
    type:
      - 'null'
      - string
    doc: 'The .janno column to use as the source key. (default: "Poseidon_ID")'
    inputBinding:
      position: 100
      prefix: --sourceKey
  - id: target_key
    type:
      - 'null'
      - string
    doc: 'The .janno column to use as the target key. (default: "Poseidon_ID")'
    inputBinding:
      position: 100
      prefix: --targetKey
  - id: strip_id_regex
    type:
      - 'null'
      - string
    doc: A regular expression (POSIX Extended) for parts of the IDs to strip before
      matching between source and target.
    inputBinding:
      position: 100
      prefix: --stripIdRegex
outputs:
  - id: stderr
    type: stderr
    doc: Log messages written by the tool
  - id: out_janno
    type:
      - 'null'
      - File
    doc: The coalesced .janno file written with --outFile.
    outputBinding:
      glob: $(inputs.out_file)
  - id: target_janno
    type: File
    doc: The target .janno file (changed in place when --outFile is not given).
    outputBinding:
      glob: $(inputs.target_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.target_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stderr: poseidon-trident_jannocoalesce.err

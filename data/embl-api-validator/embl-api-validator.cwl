cwlVersion: v1.2
class: CommandLineTool
baseCommand: embl-api-validator
label: embl-api-validator
doc: "Validates biological sequence data files.\n\nTool homepage: http://www.ebi.ac.uk/ena/software/flat-file-validator"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input files to validate
    inputBinding:
      position: 1
  - id: assembly
    type:
      - 'null'
      - boolean
    doc: genome assembly entries
    inputBinding:
      position: 102
      prefix: -assembly
  - id: de
    type:
      - 'null'
      - boolean
    doc: Additional Fix :Adds/Fixes DE line(optional)
    inputBinding:
      position: 102
      prefix: -de
  - id: file_format
    type:
      - 'null'
      - string
    doc: File format(optional) Values:'embl','genbank','gff3','assembly'
    inputBinding:
      position: 102
      prefix: -f
  - id: filter
    type:
      - 'null'
      - string
    doc: -filter <prefix> Store entries in <prefix>_good.txt and 
      <prefix>_bad.txt files in the working directory. Entries with errors are 
      stored in the bad file and entries without errors are stored in the good 
      file. (optional)
    inputBinding:
      position: 102
      prefix: -filter
  - id: fix
    type:
      - 'null'
      - boolean
    doc: Fixes entries in input files. Stores input files in 'original_files' 
      folder. (optional)
    inputBinding:
      position: 102
      prefix: -fix
  - id: fix_diagnose
    type:
      - 'null'
      - boolean
    doc: Creates 'diagnose' folder in the current directory with original 
      entries in <filename>_origin file and the fixed entries in 
      <filename>_fixed file. Only fixed entries will be stored in these 
      files.(optional)
    inputBinding:
      position: 102
      prefix: -fix_diagnose
  - id: log_level
    type:
      - 'null'
      - int
    doc: 'Log level(optional) Values : 0(Quiet), 1(Summary), 2(Verbose)'
    inputBinding:
      position: 102
      prefix: -l
  - id: lowmemory
    type:
      - 'null'
      - boolean
    doc: Runs in low memory usage mode. Writes error logs but does not show 
      message summary(optional)
    inputBinding:
      position: 102
      prefix: -lowmemory
  - id: min_gap_length
    type:
      - 'null'
      - int
    doc: minimum gap length to generate assembly_gap/gap features, use assembly 
      flag to add assembly_gap features
    inputBinding:
      position: 102
      prefix: -min_gap_length
  - id: prefix
    type:
      - 'null'
      - string
    doc: Adds prefix to report files
    inputBinding:
      position: 102
      prefix: -prefix
  - id: remote
    type:
      - 'null'
      - boolean
    doc: Remote, is this being run outside the EBI(optional)
    inputBinding:
      position: 102
      prefix: -r
  - id: skip
    type:
      - 'null'
      - string
    doc: -skip <errorcode1>,<errorcode2>,... Ignore specified errors.(optional)
    inputBinding:
      position: 102
      prefix: -skip
  - id: wrap
    type:
      - 'null'
      - boolean
    doc: Turns on line wrapping in flat file writing (optional)
    inputBinding:
      position: 102
      prefix: -wrap
outputs:
  - id: report_files
    type:
      type: array
      items: File
    doc: Report files written by the validator (prefix_VAL_*.txt)
    outputBinding:
      glob:
        - '*_VAL_*.txt'
  - id: good_entries_file
    type:
      - 'null'
      - File
    doc: Entries without errors (<filter>_good.txt), written with -filter
    outputBinding:
      glob: $(inputs.filter)_good.txt
  - id: bad_entries_file
    type:
      - 'null'
      - File
    doc: Entries with errors (<filter>_bad.txt), written with -filter
    outputBinding:
      glob: $(inputs.filter)_bad.txt
  - id: diagnose_dir
    type:
      - 'null'
      - Directory
    doc: diagnose folder written with -fix_diagnose
    outputBinding:
      glob: diagnose
  - id: original_files_dir
    type:
      - 'null'
      - Directory
    doc: original_files folder with the unfixed input files, written with -fix
    outputBinding:
      glob: original_files
  - id: stderr
    type: stderr
    doc: Validator messages and summary
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.files)
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/embl-api-validator:1.1.180--1
stderr: embl-api-validator.log
successCodes:
  - 0
  - 3

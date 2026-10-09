cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sh
  - -c
label: magetab-curation-scripts_validate_magetab.pl
doc: "Validates MAGE-TAB files.\n\nTool homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.adf_file)
        writable: true
      - entry: $(inputs.idf_file)
        writable: true
      - entry: $(inputs.merged_file)
        writable: true
      - entry: $(inputs.data_directory)
        writable: true
arguments:
  - position: -1
    valueFrom: 'mkdir -p atlas_cfg; for f in /usr/local/atlasprod/supporting_files/*.default; do cp "$f" "atlas_cfg/`basename "$f" .default`"; done; export ATLAS_META_CONFIG=$PWD/atlas_cfg; exec validate_magetab.pl "$@"'
  - position: 0
    valueFrom: validate_magetab.pl
inputs:
  - id: adf_file
    type:
      - 'null'
      - File
    doc: The MAGE-TAB ADF file to be checked.
    inputBinding:
      position: 101
      prefix: -a
      valueFrom: $(self.basename)
  - id: data_directory
    type:
      - 'null'
      - Directory
    doc: Directory where the data files and SDRF can be found if they are not in
      the same directory as the IDF
    inputBinding:
      position: 101
      prefix: -d
      valueFrom: $(self.basename)
  - id: full_curator_checking
    type:
      - 'null'
      - boolean
    doc: Flag to switch on full curator checking mode, including Atlas checks
    inputBinding:
      position: 101
      prefix: -c
  - id: idf_file
    type:
      - 'null'
      - File
    doc: The MAGE-TAB IDF file to be checked (SDRF file name will be obtained 
      from the IDF)
    inputBinding:
      position: 101
      prefix: -i
      valueFrom: $(self.basename)
  - id: merged_file
    type:
      - 'null'
      - File
    doc: A MAGE-TAB document in which a single IDF and SDRF have been combined 
      (in that order), with the start of each section marked by [IDF] and [SDRF]
      respectively. Note that such documents are not compliant with the MAGE-TAB
      format specification; this format is used by ArrayExpress to simplify data
      submissions.
    inputBinding:
      position: 101
      prefix: -m
      valueFrom: $(self.basename)
  - id: skip_data_file_checks
    type:
      - 'null'
      - boolean
    doc: Flag to indicate that all data file checks should be skipped
    inputBinding:
      position: 101
      prefix: -x
  - id: verbose_logging
    type:
      - 'null'
      - boolean
    doc: Swtich on verbose logging.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log_files
    type:
      type: array
      items: File
    doc: Validation log files written beside the checked file
    outputBinding:
      glob: '*.log'
successCodes:
  - 0
  - 1
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts_validate_magetab.pl.out

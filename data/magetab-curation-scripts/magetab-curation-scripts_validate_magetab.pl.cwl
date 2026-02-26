cwlVersion: v1.2
class: CommandLineTool
baseCommand: validate_magetab.pl
label: magetab-curation-scripts_validate_magetab.pl
doc: "Validates MAGE-TAB files.\n\nTool homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs:
  - id: adf_file
    type:
      - 'null'
      - File
    doc: The MAGE-TAB ADF file to be checked.
    inputBinding:
      position: 101
      prefix: -a
  - id: data_directory
    type:
      - 'null'
      - Directory
    doc: Directory where the data files and SDRF can be found if they are not in
      the same directory as the IDF
    inputBinding:
      position: 101
      prefix: -d
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts_validate_magetab.pl.out

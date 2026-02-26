cwlVersion: v1.2
class: CommandLineTool
baseCommand: start-asap.pl
label: start-asap
doc: "Create a config.xml file for the ASA3P pipeline\n\nTool homepage: http://github.com/quadram-institute-bioscience/start-asap/"
inputs:
  - id: copy_files
    type:
      - 'null'
      - boolean
    doc: Place a copy of the reads and reference files in the "./data" 
      subdirectory.
    inputBinding:
      position: 101
      prefix: --copy-files
  - id: for_tag
    type:
      - 'null'
      - string
    doc: 'String denoting the file is a Forward file (default: "_R1").'
    default: _R1
    inputBinding:
      position: 101
      prefix: --for-tag
  - id: force
    type:
      - 'null'
      - boolean
    doc: Remove the content of the output directory, if a config file is found.
    inputBinding:
      position: 101
      prefix: --force
  - id: genus
    type:
      - 'null'
      - string
    doc: Genus of the bacteria
    inputBinding:
      position: 101
      prefix: --genus
  - id: id_separator
    type:
      - 'null'
      - string
    doc: 'The sample ID will determined splitting the name at the separator (default:
      "_").'
    default: _
    inputBinding:
      position: 101
      prefix: --id-separator
  - id: json_file
    type:
      - 'null'
      - File
    doc: A JSON file with project metadata.
    inputBinding:
      position: 101
      prefix: --project-info
  - id: project_description
    type:
      - 'null'
      - string
    doc: A description for the project
    inputBinding:
      position: 101
      prefix: --project-description
  - id: project_name
    type:
      - 'null'
      - string
    doc: Project code name
    inputBinding:
      position: 101
      prefix: --project-name
  - id: reads_dir
    type: Directory
    doc: Directory containing the raw reads in FASTQ format.
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: reference_file
    type: File
    doc: Reference file in FASTA or GBK format (other formats are supported by 
      ASA3P, but have not been tested)
    inputBinding:
      position: 101
      prefix: --reference
  - id: rev_tag
    type:
      - 'null'
      - string
    doc: 'String denoting the file is a Reverse file (default: "_R2")'
    default: _R2
    inputBinding:
      position: 101
      prefix: --rev-tag
  - id: species
    type:
      - 'null'
      - string
    doc: Species of the bacteria
    inputBinding:
      position: 101
      prefix: --species
  - id: user_mail
    type:
      - 'null'
      - string
    doc: Email address name of the project customer
    inputBinding:
      position: 101
      prefix: --user-mail
  - id: user_name
    type:
      - 'null'
      - string
    doc: First name of the project customer
    inputBinding:
      position: 101
      prefix: --user-name
  - id: user_surname
    type:
      - 'null'
      - string
    doc: Last name of the project customer
    inputBinding:
      position: 101
      prefix: --user-surname
outputs:
  - id: output_dir
    type: Directory
    doc: Project directory that will be the input of ASA3P. Will be created if 
      not exists and a "config.xml" file will be placed there. The directory 
      will contain a "data" subdirectory, left empty by default.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/start-asap:1.3.0--0

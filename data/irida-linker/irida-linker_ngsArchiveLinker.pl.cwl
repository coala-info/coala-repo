cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsArchiveLinker.pl
label: irida-linker_ngsArchiveLinker.pl
doc: "Link or download sequence files from the IRIDA NGS Archive.\n\nTool homepage:
  https://github.com/phac-nml/irida-linker"
inputs:
  - id: api_url
    type: string
    doc: The base URL for the NGS Archive REST API. Overrides config file 
      setting.
    inputBinding:
      position: 101
      prefix: --baseURL
  - id: config_file
    type:
      - 'null'
      - File
    doc: The location of the config file. Not required if --baseURL option is 
      used.
    inputBinding:
      position: 101
      prefix: --config
  - id: download
    type:
      - 'null'
      - boolean
    doc: 'Option to download files from the REST API instead of softlinking. Note:
      Files may be quite large. This option is not recommended if you have access
      to the sequencing filesystem.'
    inputBinding:
      position: 101
      prefix: --download
  - id: file_type
    type:
      - 'null'
      - string
    doc: 'Type of file to link or download. Available options: "fastq", "assembly".
      Default "fastq". To get both types, you can enter --type fastq,assembly'
    inputBinding:
      position: 101
      prefix: --type
  - id: flat_directory
    type:
      - 'null'
      - boolean
    doc: Create links or files in a flat directory under the project name rather
      than in sample directories.
    inputBinding:
      position: 101
      prefix: --flat
  - id: ignore_existing
    type:
      - 'null'
      - boolean
    doc: Ignore creating links for files that already exist.
    inputBinding:
      position: 101
      prefix: --ignore
  - id: output_directory
    type: Directory
    doc: A directory to output the collection of links.
    inputBinding:
      position: 101
      prefix: --output
  - id: password
    type:
      - 'null'
      - string
    doc: 'The password to use for API requests. Note: if this option is not entered
      it will be requested during running of the script.'
    inputBinding:
      position: 101
      prefix: --password
  - id: project_id
    type: string
    doc: The ID of the project to get data from.
    inputBinding:
      position: 101
      prefix: --projectId
  - id: rename_existing
    type:
      - 'null'
      - boolean
    doc: 'Rename existing files with _# suffix. Useful for topup runs with similar
      filenames. NOTE: This option overrides the --ignore option.'
    inputBinding:
      position: 101
      prefix: --rename
  - id: sample_id
    type:
      - 'null'
      - type: array
        items: string
    doc: A sample id to get sequence files for. Multiple samples may be listed 
      as -s 1 -s 2 -s 3...
    inputBinding:
      position: 101
      prefix: --sample
  - id: username
    type:
      - 'null'
      - string
    doc: 'The username to use for API requests. Note: if this option is not entered
      it will be requested during running of the script.'
    inputBinding:
      position: 101
      prefix: --username
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-linker:1.1.1--hdfd78af_2
stdout: irida-linker_ngsArchiveLinker.pl.out

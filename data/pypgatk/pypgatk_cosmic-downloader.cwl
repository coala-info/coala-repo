cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgatk
  - cosmic-downloader
label: pypgatk_cosmic-downloader
doc: "Command to download the cosmic mutation database\n\nTool homepage:
  http://github.com/bigbio/py-pgatk"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for the ensembl data downloader pipeline
    inputBinding:
      position: 101
      prefix: --config_file
  - id: output_directory
    type:
      - 'null'
      - string
    doc: Output directory for the peptide databases
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: password
    type:
      - 'null'
      - string
    doc: Password for cosmic database -- please if you don't have one register 
      here (https://cancer.sanger.ac.uk/cosmic/register)
    inputBinding:
      position: 101
      prefix: --password
  - id: url_file
    type:
      - 'null'
      - string
    doc: Add the url to a downloaded file
    inputBinding:
      position: 101
      prefix: --url_file
  - id: username
    type:
      - 'null'
      - string
    doc: Username for cosmic database -- please if you don't have one register 
      here (https://cancer.sanger.ac.uk/cosmic/register)
    inputBinding:
      position: 101
      prefix: --username
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for the peptide databases
    outputBinding:
      glob: $(inputs.output_directory)
  - id: url_file_out
    type:
      - 'null'
      - File
    doc: File with the download URLs, written when url_file is given (nothing is downloaded then)
    outputBinding:
      glob: $(inputs.url_file)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
stdout: pypgatk_cosmic-downloader.out

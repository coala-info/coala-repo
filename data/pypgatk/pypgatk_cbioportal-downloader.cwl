cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgatk
  - cbioportal-downloader
label: pypgatk_cbioportal-downloader
doc: "Download data from cBioPortal\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: config_file
    type:
      - 'null'
      - string
    doc: Configuration file for the ensembl data downloader pipeline
    inputBinding:
      position: 101
      prefix: --config_file
  - id: download_study
    type:
      - 'null'
      - string
    doc: Download a specific Study from cBioPortal -- (all to download all 
      studies)
    inputBinding:
      position: 101
      prefix: --download_study
  - id: list_studies
    type:
      - 'null'
      - boolean
    doc: Print the list of all the studies in cBioPortal 
      (https://www.cbioportal.org)
    inputBinding:
      position: 101
      prefix: --list_studies
  - id: multithreading
    type:
      - 'null'
      - boolean
    doc: Enable multithreading to download multiple files ad the same time
    inputBinding:
      position: 101
      prefix: --multithreading
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for the peptide databases
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: url_file
    type:
      - 'null'
      - string
    doc: Add the url to a downloaded file
    inputBinding:
      position: 101
      prefix: --url_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
stdout: pypgatk_cbioportal-downloader.out

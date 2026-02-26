cwlVersion: v1.2
class: CommandLineTool
baseCommand: MS2Query
label: ms2query
doc: "MS2Query is a tool for MSMS library matching, searching both for analogues and
  exact matches in one run\n\nTool homepage: https://github.com/iomega/ms2query"
inputs:
  - id: additional_metadata
    type:
      - 'null'
      - type: array
        items: string
    doc: Return additional metadata columns in the results, for example 
      --additional_metadata retention_time feature_id
    inputBinding:
      position: 101
      prefix: --additional_metadata
  - id: download
    type:
      - 'null'
      - boolean
    doc: This will download the most up to date model and library.The model will
      be stored in the folder given as the second argumentThe model will be 
      downloaded in the in the ionization mode specified under --mode
    inputBinding:
      position: 101
      prefix: --download
  - id: filter_ionmode
    type:
      - 'null'
      - boolean
    doc: Filter out all spectra that are not in the specified ion-mode. The ion 
      mode can be specified by using --ionmode
    inputBinding:
      position: 101
      prefix: --filter_ionmode
  - id: ionmode
    type:
      - 'null'
      - string
    doc: Specify the ionization mode used
    inputBinding:
      position: 101
      prefix: --ionmode
  - id: library
    type: Directory
    doc: The directory containing the library spectra (in sqlite), models and 
      precalculated embeddings, to download add --download
    inputBinding:
      position: 101
      prefix: --library
  - id: results
    type:
      - 'null'
      - Directory
    doc: The folder in which the results should be stored. The default is a new 
      results folder in the folder with the spectra
    inputBinding:
      position: 101
      prefix: --results
  - id: spectra
    type:
      - 'null'
      - File
    doc: 'The MS2 query spectra that should be processed. If a directory is specified
      all spectrum files in the directory will be processed. Accepted formats are:
      "mzML", "json", "mgf", "msp", "mzxml", "usi" or a pickled matchms object'
    inputBinding:
      position: 101
      prefix: --spectra
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2query:1.5.4--pyhdfd78af_0
stdout: ms2query.out

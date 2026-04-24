cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv extract
label: mtsv_extract
doc: "Extracts reads based on taxonomic IDs and other criteria.\n\nTool homepage:
  https://github.com/FofanovLab/MTSv"
inputs:
  - id: taxids
    type:
      type: array
      items: string
    doc: List of species to extract. (Space separated).
    inputBinding:
      position: 1
  - id: by_sample
    type:
      - 'null'
      - boolean
    doc: Breakdown extracted queries by sample.
    inputBinding:
      position: 102
      prefix: --by_sample
  - id: config
    type:
      - 'null'
      - File
    doc: Specify path to config file path, relative to working directory, not 
      required if using default config.
    inputBinding:
      position: 102
      prefix: --config
  - id: descendants
    type:
      - 'null'
      - boolean
    doc: Include all descendant taxa in extracted queries. Queries may be 
      extracted before roll up, so by default, descendant taxa will be included 
      in search if a higher level taxid is provided. If False (F), only exact 
      matches to taxid will be returned.
    inputBinding:
      position: 102
      prefix: --descendants
  - id: extract_path
    type:
      - 'null'
      - Directory
    doc: Directory to place extracted reads.
    inputBinding:
      position: 102
      prefix: --extract_path
  - id: input_hits
    type:
      - 'null'
      - File
    doc: Path to either merged binning output or signature hits file. The merged
      file should be passed if all query hits should be extracted and the 
      signature hits file should be passed if only signature queries are 
      desired.
    inputBinding:
      position: 102
      prefix: --input_hits
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set log file path, absolute or relative to working dir.
    inputBinding:
      position: 102
      prefix: --log_file
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads to spawn.
    inputBinding:
      position: 102
      prefix: --threads
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Specify working directory to place output.
    inputBinding:
      position: 102
      prefix: --working_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
stdout: mtsv_extract.out

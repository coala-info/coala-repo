cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cblaster
  - extract
label: cblaster_extract
doc: "Extract information from session files\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: session
    type: File
    doc: cblaster session file
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Sequence description delimiter
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: extract_sequences
    type:
      - 'null'
      - boolean
    doc: Extract sequences, in FASTA format, for each extracted record
    inputBinding:
      position: 102
      prefix: --extract_sequences
  - id: name_only
    type:
      - 'null'
      - boolean
    doc: Do not save sequence descriptions (i.e. no genomic coordinates)
    inputBinding:
      position: 102
      prefix: --name_only
  - id: organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: Organism names, accepts regular expressions
    inputBinding:
      position: 102
      prefix: --organisms
  - id: queries
    type:
      - 'null'
      - type: array
        items: string
    doc: IDs of query sequences
    inputBinding:
      position: 102
      prefix: --queries
  - id: scaffolds
    type:
      - 'null'
      - type: array
        items: string
    doc: Scaffold names/ranges, in the form scaffold_name:start-stop
    inputBinding:
      position: 102
      prefix: --scaffolds
  - id: output_path
    type: string
    doc: Output file name
    inputBinding:
      position: 103
      prefix: --output
  - id: ncbi_email
    type:
      - 'null'
      - string
    doc: E-mail address for NCBI Entrez. cblaster refuses to start without an 
      e-mail or NCBI API key in its config file; this CWL writes that file 
      ($HOME/.config/cblaster/config.ini) from ncbi_email / ncbi_api_key.
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: NCBI API key written to the cblaster config file (alternative to 
      ncbi_email)
  - id: sqlite_db
    type:
      - 'null'
      - File
    doc: cblaster SQLite database (<name>.sqlite3) that a local/hmm session refers
      to. It is staged into the working directory, so it is found when the 
      session stores the database by its file name (as cblaster_search.cwl 
      does).
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${ var s = "[cblaster]\n"; if (inputs.ncbi_email) { s += "email = " + inputs.ncbi_email + "\n"; } if (inputs.ncbi_api_key) { s += "api_key = " + inputs.ncbi_api_key + "\n"; } return {"class": "Directory", "basename": ".config", "listing": [{"class": "Directory", "basename": "cblaster", "listing": [{"class": "File", "basename": "config.ini", "contents": s}]}]}; }
      - $(inputs.sqlite_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
    dockerOutputDirectory: /cblaster

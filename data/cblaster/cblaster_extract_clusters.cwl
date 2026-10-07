cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cblaster
  - extract_clusters
label: cblaster_extract_clusters
doc: "Extract clusters from a session file\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: session
    type: File
    doc: cblaster session file
    inputBinding:
      position: 1
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: Cluster numbers/ ranges provided by the summary file of the 'search' 
      command.
    inputBinding:
      position: 102
      prefix: --clusters
  - id: format
    type:
      - 'null'
      - string
    doc: The format of the resulting files. The options are genbank and bigscape
    inputBinding:
      position: 102
      prefix: --format
  - id: maximum_clusters
    type:
      - 'null'
      - int
    doc: The maximum amount of clusters that will be extracted. Ordered on score
      (def. 50)
    inputBinding:
      position: 102
      prefix: --maximum_clusters
  - id: organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: Organism names (can be regex patterns)
    inputBinding:
      position: 102
      prefix: --organisms
  - id: prefix
    type:
      - 'null'
      - string
    doc: Start of the name for each cluster file, the base name is 
      'cluster_clutser_number' e.g. cluster1
    inputBinding:
      position: 102
      prefix: --prefix
  - id: scaffolds
    type:
      - 'null'
      - type: array
        items: string
    doc: Scaffold names/ranges e.g name:start-stop. Only clusters fully within 
      the range are selected.
    inputBinding:
      position: 102
      prefix: --scaffolds
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: Minimum score of a cluster in order to be included
    inputBinding:
      position: 102
      prefix: --score_threshold
  - id: output_path
    type: string
    doc: Output directory for the clusters
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
    type: Directory
    doc: Output directory for the clusters
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

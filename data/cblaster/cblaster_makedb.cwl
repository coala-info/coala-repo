cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cblaster
  - makedb
label: cblaster_makedb
doc: "Generate local databases from genome files\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: paths
    type:
      type: array
      items: File
    doc: Path/s to genome files to use when building local databases (can be 
      gzipped). Alternatively, path to one .txt file with one genome file per 
      line.
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - int
    doc: Number of genome files to parse before saving them in the local 
      database. Useful when encountering memory issues with large/many files. By
      default, all genome files will be parsed at once.
    inputBinding:
      position: 102
      prefix: --batch
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use when parsing genome files. By default, all 
      available cores will be used.
    inputBinding:
      position: 102
      prefix: --cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite pre-existing files, if any
    inputBinding:
      position: 102
      prefix: --force
  - id: name
    type: string
    doc: Name to use when building sqlite3/diamond databases (with extensions 
      .sqlite3 and .dmnd, respectively)
    inputBinding:
      position: 102
      prefix: --name
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: diamond_db
    type: File
    doc: DIAMOND database (<name>.dmnd) with the cblaster SQLite database 
      (<name>.sqlite3) beside it
    outputBinding:
      glob: $(inputs.name).dmnd
    secondaryFiles:
      - ^.sqlite3
  - id: fasta
    type: File?
    doc: Protein FASTA written while building the databases (<name>.fasta)
    outputBinding:
      glob: $(inputs.name).fasta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${ var s = "[cblaster]\n"; if (inputs.ncbi_email) { s += "email = " + inputs.ncbi_email + "\n"; } if (inputs.ncbi_api_key) { s += "api_key = " + inputs.ncbi_api_key + "\n"; } return {"class": "Directory", "basename": ".config", "listing": [{"class": "Directory", "basename": "cblaster", "listing": [{"class": "File", "basename": "config.ini", "contents": s}]}]}; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
stdout: cblaster_makedb.out

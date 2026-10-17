cwlVersion: v1.2
class: CommandLineTool
baseCommand: genbank_get_genomes_by_taxon.py
label: pyani_genbank_get_genomes_by_taxon
doc: "Download genomes of a taxon from NCBI GenBank (legacy pyani script).\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs:
  - id: outdirname
    type: string
    doc: "Output directory (required)"
    inputBinding:
      position: 1
      prefix: -o
  - id: email
    type: string
    doc: "Email associated with NCBI queries (required)"
    inputBinding:
      position: 1
      prefix: --email
  - id: taxon
    type:
      - 'null'
      - string
    doc: "NCBI taxonomy ID"
    inputBinding:
      position: 10
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Give verbose output"
    inputBinding:
      position: 10
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Report debugging output"
    inputBinding:
      position: 10
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force file overwriting"
    inputBinding:
      position: 10
      prefix: -f
  - id: noclobber
    type:
      - 'null'
      - boolean
    doc: "Don't nuke existing files"
    inputBinding:
      position: 10
      prefix: --noclobber
  - id: logfile
    type:
      - 'null'
      - string
    doc: "Logfile location"
    inputBinding:
      position: 10
      prefix: -l
  - id: format
    type:
      - 'null'
      - string
    doc: "Output file format [gbk|fasta]"
    inputBinding:
      position: 10
      prefix: --format
  - id: retries
    type:
      - 'null'
      - int
    doc: "Number of Entrez retry attempts per request."
    inputBinding:
      position: 10
      prefix: --retries
  - id: batchsize
    type:
      - 'null'
      - int
    doc: "Entrez record return batch size"
    inputBinding:
      position: 10
      prefix: --batchsize
  - id: timeout
    type:
      - 'null'
      - int
    doc: "Timeout for URL connection (s)"
    inputBinding:
      position: 10
      prefix: --timeout
outputs:
  - id: output_dir
    type: Directory
    doc: Downloaded genomes
    outputBinding:
      glob: $(inputs.outdirname)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0

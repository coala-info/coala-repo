cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - stringMLST.py
  - --getMLST
label: stringmlst_getMLST
doc: "Download an MLST typing scheme from pubMLST and build the stringMLST database for it (needs network access).\n\nTool homepage: https://github.com/jordanlab/stringMLST"
inputs:
  - id: species
    type: string
    doc: Species name from the pubMLST schemes (use "list" to show the available schemes; "all" will download and build all)
    inputBinding:
      position: 1
      prefix: --species
  - id: prefix
    type:
      - 'null'
      - string
    doc: Directory where the scheme and its database are created
    inputBinding:
      position: 2
      prefix: --prefix
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer size for which the db has to be formed (Default k = 35)
    inputBinding:
      position: 3
      prefix: -k
outputs:
  - id: database_dir
    type: Directory
    doc: Directory holding the downloaded scheme files and the k-mer database
    outputBinding:
      glob: $(inputs.prefix || '.')
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringmlst:0.6.3--py_0

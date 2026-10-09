cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mashpit
  - build
label: mashpit_build
doc: "Build a mashpit database (a sketch-based surveillance database) from a pathogen
  taxon or from a list of NCBI BioSample accessions. Needs network access to NCBI.\n\
  \nTool homepage: https://github.com/tongzhouxu/mashpit"
inputs:
  - id: database_type
    type: string
    doc: mashpit database type (taxon or accession)
    inputBinding:
      position: 1
  - id: name
    type: string
    doc: mashpit database name (a folder with this name is created)
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable logs
    inputBinding:
      position: 101
      prefix: --quiet
  - id: number
    type:
      - 'null'
      - int
    doc: maximum number of hashes for sourmash, default is 1000
    inputBinding:
      position: 101
      prefix: --number
  - id: ksize
    type:
      - 'null'
      - int
    doc: kmer size for sourmash, default is 31
    inputBinding:
      position: 101
      prefix: --ksize
  - id: species
    type:
      - 'null'
      - string
    doc: species name
    inputBinding:
      position: 101
      prefix: --species
  - id: email
    type:
      - 'null'
      - string
    doc: Entrez email
    inputBinding:
      position: 101
      prefix: --email
  - id: key
    type:
      - 'null'
      - string
    doc: Entrez api key
    inputBinding:
      position: 101
      prefix: --key
  - id: pd_version
    type:
      - 'null'
      - string
    doc: a specified Pathogen Detection version (PDG accession). Default is the
      latest.
    inputBinding:
      position: 101
      prefix: --pd_version
  - id: list
    type:
      - 'null'
      - File
    doc: Path to a list of NCBI BioSample accessions
    inputBinding:
      position: 101
      prefix: --list
outputs:
  - id: database_dir
    type: Directory
    doc: Database folder (<name>.db metadata and <name>.sig signatures)
    outputBinding:
      glob: $(inputs.name)
  - id: log
    type:
      - 'null'
      - type: array
        items: File
    doc: Log file written by mashpit
    outputBinding:
      glob: mashpit-*.log
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: SSL_CERT_FILE
        envValue: /usr/local/ssl/cacert.pem
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashpit:0.9.10--pyhdfd78af_1

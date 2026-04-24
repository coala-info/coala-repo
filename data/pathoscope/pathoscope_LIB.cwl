cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pathoscope
  - LIB
label: pathoscope_LIB
doc: "PathoScope LIB module for creating reference libraries and mapping gi to taxonomy
  ids.\n\nTool homepage: https://github.com/PathoScope/PathoScope"
inputs:
  - id: db
    type:
      - 'null'
      - string
    doc: mysql pathoscope database name
    inputBinding:
      position: 101
      prefix: -db
  - id: db_host
    type:
      - 'null'
      - string
    doc: specify hostname running mysql if you want to use mysql instead of hash method
      in mapping gi to taxonomy id
    inputBinding:
      position: 101
      prefix: -dbhost
  - id: db_passwd
    type:
      - 'null'
      - string
    doc: provide password associate with user
    inputBinding:
      position: 101
      prefix: -dbpasswd
  - id: db_port
    type:
      - 'null'
      - int
    doc: provide mysql server port if different from default (3306)
    inputBinding:
      position: 101
      prefix: -dbport
  - id: db_user
    type:
      - 'null'
      - string
    doc: user name to access mysql
    inputBinding:
      position: 101
      prefix: -dbuser
  - id: exclude_taxon_ids
    type:
      - 'null'
      - string
    doc: Specify taxon ids to exclude with comma separated (if you have multiple taxon
      ids to exclude).
    inputBinding:
      position: 101
      prefix: -excludeTaxonIds
  - id: genome_file
    type: File
    doc: Specify reference genome (Download ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nt.gz)
    inputBinding:
      position: 101
      prefix: -genomeFile
  - id: no_desc
    type:
      - 'null'
      - boolean
    doc: Do not keep an additional description in original fasta seq header. Depending
      on NGS aligner, a long sequence header may slow down its mapping process.
    inputBinding:
      position: 101
      prefix: --noDesc
  - id: online
    type:
      - 'null'
      - boolean
    doc: To enable online searching in case you cannot find a correct taxonomy id
      for a given gi. When there are many entries in nt whose gi is invalid, this
      option may slow down the overall process.
    inputBinding:
      position: 101
      prefix: --online
  - id: out_prefix
    type: string
    doc: specify an output prefix to name your target database
    inputBinding:
      position: 101
      prefix: -outPrefix
  - id: sub_tax
    type:
      - 'null'
      - boolean
    doc: To include all sub taxonomies under the query taxonomy id. e.g., if you set
      -t 4751 --subtax, it will cover all sub taxonomies under taxon id 4751 (fungi).
    inputBinding:
      position: 101
      prefix: --subTax
  - id: taxon_ids
    type:
      - 'null'
      - string
    doc: Specify taxon ids of your interest with comma separated (if you have multiple
      taxon ids). If you do not specify this option, it will work on all entries in
      the reference file.
    inputBinding:
      position: 101
      prefix: -taxonIds
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output Directory (Default=. (current directory))
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2

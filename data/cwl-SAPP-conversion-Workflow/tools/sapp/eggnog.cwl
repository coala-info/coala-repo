class: CommandLineTool
cwlVersion: v1.2

label: "eggNOG"

doc: |
  eggNOG is a public resource that provides Orthologous Groups (OGs)
  of proteins at different taxonomic levels, each with integrated and summarized functional annotations.

hints:
  InlineJavascriptRequirement: {}
  SoftwareRequirement:
    packages:
      eggnog:
        version: ["2.1.12"]
        specs: ["https://anaconda.org/bioconda/eggnog-mapper", "doi.org/10.1101/2021.06.03.446934"]
      sapp:
        version: ["2.0"]
        specs: ["https://sapp.gitlab.io/docs/index.html", "doi.org/10.1101/184747"]

  DockerRequirement:
    dockerPull: quay.io/biocontainers/eggnog-mapper:2.1.12--pyhdfd78af_0

# requirements:
#   ResourceRequirement:
#     ramMin: 50000
#     coresMin: 16

baseCommand: [emapper.py]

inputs:
  input_fasta:
    type: File
    inputBinding:
      separate: true
      prefix: -i
    label: Input FASTA file containing protein sequences

  db:
    type: [string?, File?]  # data/eggnog.db
    inputBinding:
      prefix: --database
    label: specify the target database for sequence searches (euk,bact,arch, host:port, local hmmpressed database)
    # default: /unlock/references/databases/eggnog/eggnog.db

  db_diamond:
    type: [string?, File?]  # data/eggnog_proteins.dmnd
    inputBinding:
      prefix: --dmnd_db
    label: Path to DIAMOND-compatible database
    # default: /unlock/references/databases/eggnog/eggnog_proteins.dmnd

  data_dir:
    type: [string?, Directory?]  # data/
    inputBinding:
      prefix: --data_dir
    label: Directory to use for DATA_PATH
    # default: /unlock/references/databases/eggnog

  mode:
    type: string?
    inputBinding:
      prefix: -m
    label: hmmer or diamond
    default: hmmer

  cpu:
    type: int?
    inputBinding:
      prefix: --cpu
    default: 4

arguments: 
  - position: 1
    valueFrom: "--dbmem"
  - position: 2
    prefix: '--annotate_hits_table'
    valueFrom: $(inputs.inputFile.nameroot)_eggnog_hits_table.tsv
  - position: 3
    prefix: '-o'
    valueFrom: $(inputs.inputFile.nameroot)_eggnog.tsv
    
    

outputs:
  output_annotations:
    type: File?
    format: edam:format_3475
    outputBinding:
      glob: $(inputs.output)*annotations*

  output_orthologs:
    type: File?
    format: edam:format_3475
    outputBinding:
      glob: $(inputs.output)*orthologs*

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/

$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/version/latest/schemaorg-current-http.rdf

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
    
s:copyrightHolder:
    - name: "EMBL - European Bioinformatics Institute"
    - url: "https://www.ebi.ac.uk/"
s:license: "https://www.apache.org/licenses/LICENSE-2.0"
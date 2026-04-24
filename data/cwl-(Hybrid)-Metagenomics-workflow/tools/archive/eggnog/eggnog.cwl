class: CommandLineTool
cwlVersion: v1.2

label: "eggNOG"

doc: |
  eggNOG is a public resource that provides Orthologous Groups (OGs)
  of proteins at different taxonomic levels, each with integrated and summarized functional annotations.

# cmdline	emapper.py --cpu 20 
  # --mp_start_method forkserver 
  # --data_dir /dev/shm/ 
  # -o out 
  # --output_dir /emapper_web_jobs/emapper_jobs/user_data/MM_8hl1swdu 
  # --temp_dir /emapper_web_jobs/emapper_jobs/user_data/MM_8hl1swdu 
  # --override 
  # -m diamond  <DONE>
  # --dmnd_ignore_warnings <DONE>
  # --dmnd_algo ctg <DONE>
  # -i /emapper_web_jobs/emapper_jobs/user_data/MM_8hl1swdu/queries.fasta 
  # --evalue 0.001 <DONE>
  # --score 60 <DONE>
  # --pident 40 
  # --query_cover 20 
  # --subject_cover 20 
  # --itype proteins 
  # --tax_scope auto 
  # --target_orthologs all 
  # --go_evidence non-electronic 
  # --pfam_realign none 
  # --report_orthologs 
  # --decorate_gff yes 
  # --excel  
  # > /emapper_web_jobs/emapper_jobs/user_data/MM_8hl1swdu/emapper.out  
  # 2> /emapper_web_jobs/emapper_jobs/user_data/MM_8hl1swdu/emapper.err

hints:
  InlineJavascriptRequirement: {}
  SoftwareRequirement:
    packages:
      eggnog:
        version: ["2.1.12"]
        specs: ["https://anaconda.org/bioconda/eggnog-mapper","https://doi.org/10.1101/2021.06.03.446934"]

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

  cpu:
    type: int?
    inputBinding:
      prefix: --cpu

arguments: 
  - position: 1
    valueFrom: "--dbmem"
  - position: 2
    prefix: '--annotate_hits_table'
    valueFrom: $(inputs.input_fasta.nameroot)_eggnog_hits_table.tsv
  - position: 3
    prefix: '-o'
    valueFrom: $(inputs.input_fasta.nameroot)_eggnog.tsv
  # Defaults from eggnog-mapper online
  # - position: 4
  #   prefix: '-dmnd_ignore_warnings'
  # - position: 5
  #   prefix: '--dmnd_algo'
  #   valueFrom: "ctg"
  # - position: 6
  #   prefix: '--evalue'
  #   valueFrom: "0.001"
  # - position: 7
  #   prefix: '--score'
  #   valueFrom: "60"
  # - position: 8
  #   prefix: '--pident'
  #   valueFrom: "40"
  # - position: 9
  #   prefix: '--query_cover'
  #   valueFrom: "20"
  # - position: 10
  #   prefix: '--subject_cover'
  #   valueFrom: "20"
  # - position: 11
  #   prefix: '--itype'
  #   valueFrom: "proteins"
  # - position: 12
  #   prefix: '--tax_scope'
  #   valueFrom: "auto"
  # - position: 13
  #   prefix: '--target_orthologs'
  #   valueFrom: "all"
  # - position: 14
  #   prefix: '--go_evidence'
  #   valueFrom: "non-electronic"
  # - position: 15
  #   prefix: '--pfam_realign'
  #   valueFrom: "none"
  # - position: 16
  #   prefix: '--report_orthologs'
  # - position: 17
  #   prefix: '--decorate_gff'
  #   valueFrom: "yes"

outputs:
  output_annotations:
    type: File?
    format: edam:format_3475
    outputBinding:
      glob: $(inputs.input_fasta.nameroot)*annotations*

  output_orthologs:
    type: File?
    format: edam:format_3475
    outputBinding:
      glob: $(inputs.input_fasta.nameroot)*orthologs*

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/

$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/version/latest/schemaorg-current-http.rdf


s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person  # Original author
    s:author: 'Michael Crusoe, Aleksandra Ola Tarkowska, Maxim Scheremetjew, Ekaterina Sakharova'
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
    
s:copyrightHolder:
    - name: "EMBL - European Bioinformatics Institute"
    - url: "https://www.ebi.ac.uk/"
s:license: "https://www.apache.org/licenses/LICENSE-2.0"

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
        specs: ["https://anaconda.org/bioconda/eggnog-mapper","https://doi.org/10.1101/2021.06.03.446934"]

  DockerRequirement:
    dockerPull: quay.io/biocontainers/eggnog-mapper:2.1.12--pyhdfd78af_0

baseCommand: [emapper.py]

inputs:
  input_fasta:
    type: File
    inputBinding:
      separate: true
      prefix: -i
    label: Input FASTA file containing protein sequences

  eggnog_dbs:
    type:
      - type: record
        name: eggnog
        fields:
          data_dir:
            type: Directory
            inputBinding:
              prefix: --data_dir
            doc: Directory containing all data files for the eggNOG database.
          db:
            type: File
            inputBinding:
              prefix: --database
            doc: eggNOG database file
          diamond_db:
            type: File
            inputBinding:
              prefix: --dmnd_db
            doc: eggNOG database file for diamond blast search
  mode:
    type:
      - "null"
      - type: enum
        symbols:
          - diamond
          - hmmer
        inputBinding:
          prefix: -m
    default: diamond
    doc: Run with hmmer or diamond. Default diamond

  go_evidence:
    type:
      - type: enum
        symbols:
          - experimental
          - non-electronic
          - all
        inputBinding:
          prefix: --go_evidence
    default: non-electronic
    doc: | 
      Defines what type of GO terms should be used for annotation. 
      experimental = Use only terms inferred from experimental evidence. 
      non-electronic = Use only non-electronically curated terms.
      Default non-electronic.

  cpu:
    type: int?
    inputBinding:
      prefix: --cpu
    default: 4

  dbmem:
    type: boolean
    inputBinding:
      prefix: --dbmem
    doc: Use this option to allocate the whole eggnog.db DB in memory. Database will be unloaded after execution. (default false)
    default: false


arguments: 
  - position: 2
    prefix: '--annotate_hits_table'
    valueFrom: $(inputs.input_fasta.nameroot)
  - position: 3
    prefix: '-o'
    valueFrom: $(inputs.input_fasta.nameroot)
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
    s:author: 'Ekaterina Sakharova'
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  
s:copyrightHolder: 'EMBL - European Bioinformatics Institute'
s:license: https://www.apache.org/licenses/LICENSE-2.0
s:dateCreated: "2019-06-14"
s:dateModified: "2024-10-03"

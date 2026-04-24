class: CommandLineTool
cwlVersion: v1.2

label: 'InterProScan: protein sequence classifier'

doc: >-
  InterProScan is the software package that allows sequences (protein and
  nucleic) to be scanned against InterPro's signatures. Signatures are
  predictive models, provided by several different databases, that make up the
  InterPro consortium.

  Documentation on how to run InterProScan 5 can be found here:
  https://github.com/ebi-pf-team/interproscan/wiki/HowToRun

# hints:
#   DockerRequirement:
#     dockerPull: docker-registry.wur.nl/m-unlock/docker/interproscan:5.63-95.0

requirements:
  SoftwareRequirement:
    packages:
      interproscan:
        version: ["5.63-95.0"]
        specs: ["https://doi.org/10.1093/bioinformatics/btu031"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/interproscan:5.63-95.0
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.interproscan)
        writable: true
      # - entryname: script.sh
        # entry: |-
          #!/bin/bash
          # Creating a symbolic link from whatever the data location is to the expected location
          # cp -rs /opt/interproscan/* ./ # To preserve the original directory
          # ls ./
          # ls -lah data/pfam/35.0/pfam_a.hmm
          # ./interproscan.sh --applications Pfam $@ # SFLD SMART AntiFam NCBIfam


  # ResourceRequirement:
  #   ramMin: 10000
  #   coresMin: 8

baseCommand: [bash, -x]

arguments:
  - position: 1
    valueFrom: $(inputs.interproscan.path)/interproscan.sh
  - position: 3
    prefix: '-cpu'
    valueFrom: '16'
  # - position: 4
#     valueFrom: '-dp'
  - position: 5
    valueFrom: '--goterms'
  - position: 6
    valueFrom: '-pa'
  - position: 7
    valueFrom: 'TSV,JSON'
    prefix: '-f'
  - position: 8
    valueFrom: '--iprlookup'
  # - position: 9
    # valueFrom: '--disable-precalc'
    

inputs:
  interproscan:
    inputBinding:
      position: 1
    type: Directory
    label: InterProScan program directory path
  input_fasta:
    type: File
    inputBinding:
      position: 2
      prefix: '--input'
    label: Input protein fasta file path
    
  applications:
    type: string
    inputBinding:
      position: 3
      prefix: '--applications'

outputs:
  tsv_annotations:
    type: File
    outputBinding:
      glob: '*.tsv'        
  json_annotations:
    type: File
    outputBinding:
      glob: '*.json'

$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'

$schemas:
   - http://edamontology.org/EDAM_1.16.owl
   - https://schema.org/version/latest/schemaorg-current-https.rdf

s:author:
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
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke

s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2022-00-00"
s:dateModified: "2024-09-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


class: CommandLineTool
cwlVersion: v1.2

label: InterProScan

doc: >-
  InterProScan is the software package that allows sequences to be scanned 
  against InterPro's signatures. Signatures are predictive models, 
  provided by several different databases, that make up the InterPro consortium.

  You need to to download a copy of InterProScan v5 here: 
  https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/

  Before you run InterProScan 5 for the first time, you should run the command:
  > python3 setup.py -f interproscan.properties

  Documentation on InterProScan can be found here:
  https://interproscan-docs.readthedocs.io

hints:
  SoftwareRequirement:
    packages:
      openjdk:
        version: ["21.0.2"]
        specs: ["https://anaconda.org/conda-forge/openjdk"]
      python:
        version: ["3.12.2"]
        specs: ["https://anaconda.org/conda-forge/python"]
      perl:
        version: ["5.32"]
        specs: ["https://anaconda.org/conda-forge/perl"]
      interproscan:
        version: ["5"]
        specs: ["https://doi.org/10.1093/bioinformatics/btu031"]

  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/interproscan_v5:base

requirements:
  NetworkAccess:
    networkAccess: true
  InlineJavascriptRequirement: {}

baseCommand: [bash, -x]

arguments:
  - position: 1
    valueFrom: $(inputs.interproscan_directory.path)/interproscan.sh
  - prefix: "--output-file-base"
    position: 9
    valueFrom: $(inputs.protein_fasta.nameroot).interproscan

inputs:
  interproscan_directory:
    inputBinding:
      position: 1
    type: Directory
    label: IPR directory
    doc: InterProScan (full) program directory path
  protein_fasta:
    type: File
    inputBinding:
      position: 2
      prefix: --input
    label: Input protein fasta file path
  threads:
    type: int?
    default: 1
    inputBinding:
      position: 3
      prefix: --cpu
  applications:
    type: string
    inputBinding:
      position: 4
      prefix: --applications
    default: 'Pfam,SFLD,SMART,AntiFam,NCBIfam'
    label: Applications
    doc: |
          Comma separated list of analyses:
          FunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam
          default Pfam,SFLD,SMART,AntiFam,NCBIfam
  output_formats:
    type: string?
    default: 'TSV,JSON'
    inputBinding:
      position: 5
      prefix: --formats
    label: Output format
    doc: Optional, case-insensitive, comma separated list of output formats. Supported formats are TSV, XML, JSON, and GFF3. Default  JSON,TSV
  ipr_lookup:
    type: boolean?
    default: true
    inputBinding:
      position: 6
      prefix: --iprlookup
    label: IPR lookup
    doc: Also include lookup of corresponding InterPro annotation in the TSV and GFF3 output formats. Default true
  goterms:
    type: boolean?
    default: true
    inputBinding:
      position: 7
      prefix: --goterms
    label: GOterms
    doc: Lookup of corresponding Gene Ontology annotation (IMPLIES -iprlookup option). Default true
  pathways:
    type: boolean?
    default: true
    inputBinding:
      position: 8
      prefix: --pathways
    label: Pathways
    doc: Lookup of corresponding Pathway annotation (IMPLIES -iprlookup option). Default true

outputs:
  tsv_annotations:
    type: File?
    outputBinding:
      glob: '*.tsv'        
  json_annotations:
    type: File?
    outputBinding:
      glob: '*.json'
  xml_annotations:
    type: File?
    outputBinding:
      glob: '*.xml'
  gff3_annotations:
    type: File?
    outputBinding:
      glob: '*.gff3'

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


$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'

$schemas:
   - http://edamontology.org/EDAM_1.16.owl
   - https://schema.org/version/latest/schemaorg-current-https.rdf

s:copyrightHolder: 'EMBL - European Bioinformatics Institute'
s:license: https://www.apache.org/licenses/LICENSE-2.0
s:dateCreated: "2019-06-14"
s:dateModified: "2024-03-00"
s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl

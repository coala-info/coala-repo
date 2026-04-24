#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "Bracken"
doc: |
  Bayesian Reestimation of Abundance with KrakEN.
  Bracken is a highly accurate statistical method that computes the abundance of species in DNA sequences from a metagenomics sample.

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.kraken_report)
        writable: true

hints:
  SoftwareRequirement:
    packages:
      bracken:
        version: ["2.9"]
        specs: ["https://anaconda.org/bioconda/bracken", "doi.org/10.7717/peerj-cs.104"]

  DockerRequirement:
    dockerPull: quay.io/biocontainers/bracken:2.9--py39h1f90b4d_0

baseCommand: [ bracken ]

arguments:
  - valueFrom: $(inputs.identifier+"_"+inputs.database.path.split( '/' ).pop()+"_bracken_"+inputs.level+".txt")
    prefix: -o

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset
    label: identifier used

  database:
    type: Directory
    label: Database
    doc: Database location of kraken2
    inputBinding:
      prefix: -d 
  kraken_report:
    type: File
    label: Kraken report
    doc: Kraken REPORT file to use for abundance estimation
    inputBinding:
      prefix: -i
  read_length:
    type: int
    label: Read length
    doc: Read length to get all classification. Default 100
    inputBinding:
      prefix: -r
  threshold:
    type: int
    label: threshold
    doc: Number of reads required PRIOR to abundance estimation to perform reestimation. Default 0
    inputBinding:
      prefix: -t
  level:
    type: string
    label: Level
    doc: Level to estimate abundance at. option [D,P,C,O,F,G,S,S1]. Default Species; 'S'
    inputBinding:
      prefix: -l

outputs:
  output_report:
    type: File
    outputBinding:
      glob: $(inputs.identifier+"_"+inputs.database.path.split( '/' ).pop()+"_bracken_"+inputs.level+".txt")

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: 2024-10-07
s:dateCreated: "2024-04-15"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "SAPP Reduce"

doc: |
    Reduces genome HDT files from sapp by removing sequence information

hints:
  SoftwareRequirement:
    packages:
      openjdk:
        version: ["17.0.3"]
        specs: ["https://anaconda.org/conda-forge/openjdk"]
      sapp:
        version: ["2.0"]
        specs: ["https://sapp.gitlab.io/docs/index.html", "doi.org/10.1101/184747"]
        
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/sapp:2.0

requirements: 
  InlineJavascriptRequirement: {}

baseCommand: ["java","-jar","/SAPP-2.0.jar","-reduce"]

inputs:
  input:
    type: File
    doc: Genome input file used in RDF format
    label: Genome RDF input file
    inputBinding:
      prefix: -i
  output:
    type: string
    doc: Genome output filename used in RDF format
    label: Genome rdf output file
    inputBinding:
      prefix: -o

outputs:
  output:
    type: File
    outputBinding:
      glob: "*.reduce.hdt.gz"

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

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: 2024-10-07
s:dateCreated: "2023-03-01"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
  
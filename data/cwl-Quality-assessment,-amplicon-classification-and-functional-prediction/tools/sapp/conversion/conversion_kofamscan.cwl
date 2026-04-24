#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: "SAPP conversion -kofamscan"

doc: |
    SAPP conversion from KoFamScan/KoFamKOALA output to GBOL RDF file (TTL)

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
 - class: InlineJavascriptRequirement

inputs:
  rdf:
    type: File
    label: RDF
    doc: Input RDF file
    inputBinding:
      prefix: -input
  resultfile:
    type: File
    label: KofamScan tsv
    doc: KofamScan detail-tsv output
    inputBinding:
      prefix: -resultFile
  limit:
    type: int?
    label: Limit
    doc: Limit the number of hits per locus tag (0=no limit) (optional). Default 0
    inputBinding:
      prefix: -limit
  output_prefix:
    type: string
    label: Output prefix
    doc: Output filename prefix. Suffix '.KoFamKOALA.ttl' will be added.

arguments:
  - prefix: "-output"
    valueFrom: $(inputs.output_prefix).KoFamKOALA.ttl

baseCommand: ["java", "-Xmx5G", "-jar", "/SAPP-2.0.jar", "-kofamscan"]

outputs:
  kofamscan_ttl:
    type: File
    outputBinding:
      glob: $(inputs.output_prefix).KoFamKOALA.ttl

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
s:dateCreated: "2023-09-00"
s:dateModified: "2024-04-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
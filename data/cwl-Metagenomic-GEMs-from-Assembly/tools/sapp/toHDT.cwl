#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "Genome conversion"

doc: |
    Runs Genome conversion tool from SAPP

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
  input:
    type: File
    doc: RDF file in any format with the right extension
    label: RDF input file (hdt, ttl, nt, etc...)
    inputBinding:
      prefix: -i
  output:
    type: string
    doc: Name of the output file with the right extension
    label: RDF output file (hdt, ttl, nt, etc...)
    inputBinding:
      prefix: -o


baseCommand: ["java", "-Xmx5g", "-jar", "/SAPP-2.0.jar", "-convert"]

outputs:
  hdt_output: 
    type: File
    outputBinding:
      glob: $(inputs.output)

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
s:dateCreated: "2020-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/
  
#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "Infernal rna prediction"

doc: |
    Runs microbial infernal rna prediction on GBOL RDF file

requirements:
 - class: InlineJavascriptRequirement

inputs:
  input:
    type: File
    doc: Reference genome file used in RDF format
    label: Reference genome
    inputBinding:
      prefix: -input
  identifier:
    type: string
    doc: Name of the sample being analysed
    label: Sample name
  clanin:
    type: string
    doc: Path to Rfam.clanin file
    label: clanin file
    inputBinding:
      prefix: -clanin
  cm:
    type: string
    doc: Path to Rfam.cm file that is already indexed with cmpress
    label: cm file
    inputBinding:
      prefix: -cm
  cmscan:
    type: string
    doc: Path to cmscan binary
    label: cmscan path
    inputBinding:
      prefix: -cmscan
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    inputBinding:
      prefix: -cpu

baseCommand: ["java", "-Xmx5g", "-jar", "/unlock/infrastructure/binaries/sapp/SAPP-2.0.jar", "-infernal"]

arguments:
  - prefix: "-output"
    valueFrom: $(inputs.identifier).infernal.ttl

outputs:
  output: 
    type: File
    outputBinding:
      glob: $(inputs.identifier).infernal.ttl


s:author:
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
s:dateCreated: "2020-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/
  
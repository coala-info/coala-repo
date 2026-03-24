#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

doc: |
  ClustalO execution workflow

requirements:
 - class: InlineJavascriptRequirement

inputs:
  threads:
    type: int?
    label: Number of threads
    doc: Number of threads for clustalo to use.
    default: 4
    inputBinding:
      prefix: -threads
  fasta:
    type: File
    label: Input fasta file
    doc: Input sasta file 
    inputBinding:
      prefix: -fasta
  clustalo:
    type: string
    label: Binary path
    doc: Path to the clustalo binary
    default: /unlock/infrastructure/binaries/clustalo/clustalo
    inputBinding:
      prefix: -clustalo
      position: 1

arguments:
  - prefix: "-distmat"
    valueFrom: $(inputs.fasta.basename).dist
  - prefix: "-output"
    valueFrom: $(inputs.fasta.basename).aln
  - prefix: "-gtree"
    valueFrom: $(inputs.fasta.basename).tree

baseCommand: ["python3", "/unlock/infrastructure/binaries/clustalo/clustalo.py"]

outputs:
  dist:
    type: File
    outputBinding:
      glob: $(inputs.fasta.basename).dist
  output:
    type: File
    outputBinding:
      glob: $(inputs.fasta.basename).aln
  tree:
    type: File
    outputBinding:
      glob: $(inputs.fasta.basename).tree

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

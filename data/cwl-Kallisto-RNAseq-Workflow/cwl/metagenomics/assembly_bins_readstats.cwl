#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "Bin read mapping stats"

doc: |
    Table of general read mapping statistics of the bins and assembly

requirements:
 - class: InlineJavascriptRequirement 

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
    inputBinding:
      position: 4
  
  binContigs:
    type: File
    doc: File containing bins and their respective (assembly) contigs
    label: binContigs file
    inputBinding:
      position: 1
  idxstats:
    type: File
    doc: Output File from samtools idxstats
    label: idxstats file
    inputBinding:
      position: 2
  flagstat:
    type: File
    doc: Output file from samtools flagstat tool
    label: samtools flagstat
    inputBinding:
      position: 3

baseCommand: [python3, "/unlock/infrastructure/binaries/scripts/metagenomics/assembly_bins_readstats.py"]

stdout: $(inputs.identifier)_binReadStats.tsv

outputs:
  binReadStats:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_binReadStats.tsv

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
s:dateCreated: "2021-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

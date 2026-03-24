#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: custom GenBank to fasta extraction python script

doc: Uses a custom python script to extract a GenBank file.

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/biopython:1.69--np110py36_0 
  SoftwareRequirement:
    packages:
      biopython:
        version: ["1.69"]
        specs: ["identifiers.org/RRID:SCR_007173"]

baseCommand: ["python"]

inputs:
  script:
    type: File
    label: custom python script
    doc: The custom python script "genbank_to_fasta.py"
    inputBinding:
      position: 1
  genbank_file:
    label: GenBank file
    doc: Input GenBank file.
    type: File
    inputBinding:
      position: 2
  output_prefix:
    label: output prefix
    doc: The prefix for the output FASTA file.
    type: string
    inputBinding:
      position: 3

outputs:
  fasta:
    type: File?
    label: extracted FASTA file
    doc: The extracted FASTA file.
    outputBinding:
      glob: "$(inputs.output_prefix).fasta"

$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-04-17"
s:dateModified: "2025-04-17"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"
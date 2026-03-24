#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: custom GenBank merging python script

doc: A custom python script to merge multiple GenBank files, optionally also outputs a FASTA file.

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
    doc: The custom python script "merge_genbank.py".
    inputBinding:
      position: 1
  genbank_files:
    label: GenBank files
    doc: List of input GenBank files to be merged.
    type: File[]
    inputBinding:
      position: 2
  output_prefix:
    label: output prefix
    doc: The prefix for the output merged GenBank and FASTA files.
    type: string
    inputBinding:
      position: 3
  fasta_output:
    label: FASTA output
    doc: Optional flag to output a FASTA file in addition.
    type: boolean
    inputBinding:
      prefix: --fasta
      position: 4
    default: false

outputs:
  merged_genbank:
    type: File
    label: merged GenBank File
    doc: Merged GenBank file.
    outputBinding:
      glob: "$(inputs.output_prefix).gb"
  merged_fasta:
    type: File?
    label: merged FASTA file
    doc: Merged FASTA file (optional, based on fasta_output flag).
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
s:dateCreated: "2025-04-14"
s:dateModified: "2025-04-14"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"
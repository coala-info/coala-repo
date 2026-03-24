#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: custom VCF merging python script

doc: A custom python script to merge freebayes and Clair3 VCF files.

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/python:3.13
  SoftwareRequirement:
    packages:
      python:
        version: ["3.13"]
        specs: ["identifiers.org/RRID:SCR_008394"]

baseCommand: ["python"]

inputs:
  script:
    type: File
    label: custom python script
    doc: The custom python script "combine_variant_calling.py"
    inputBinding:
      position: 1
  clair3_vcf:
    type: File
    label: Clair3 VCF
    doc: A Clair3 VCF output file.
    inputBinding:
      position: 2
  freebayes_vcf:
    type: File
    label: freebayes VCF
    doc: A freebayes VCF output file.
    inputBinding:
      position: 3

outputs:
  merged_vcf:
    type: File
    outputBinding:
      glob: "combined_output.vcf"

$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-03-20"
s:dateModified: "2025-04-14"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"
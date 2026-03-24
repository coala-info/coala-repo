#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: HUMAnN3 humann_renorm_table

doc: |
  Runs the HUMAnN 3 humann_renorm_table function.
  HUMAnN utility for renormalizing TSV files
  ===========================================
  Each level of a stratified table will be 
  normalized using the desired scheme.


requirements:
 - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      humann:
        version: ["3.8"]
        specs: ["https://anaconda.org/bioconda/humann", "doi.org/10.7554/eLife.65088"]      
  DockerRequirement:
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0

baseCommand: [humann_renorm_table]

arguments:
  - prefix: "--output"
    valueFrom: $(inputs.input_table.nameroot)-$(inputs.mode)-$(inputs.units).tsv

inputs:
  input_table:
    type: File
    doc: Input table
    label: Input table
    inputBinding:
      prefix: --input

  units:
    type:
      - type: enum
        symbols:
          - cpm
          - relab
    doc: Normalization scheme, copies per million [cpm], relative abundance [relab] default=[cpm]
    label: Units
    default: cpm
    inputBinding:
      prefix: --units
  mode:
    type:
      - type: enum
        symbols:
          - community
          - levelwise
    doc: Normalize all levels by [community] total or [levelwise] totals; default=[community]
    label: Mode
    default: community
    inputBinding:
      prefix: --mode    
  special:
    type:
      - type: enum
        symbols:
          - y
          - n
    doc: Include the special features UNMAPPED, UNINTEGRATED, and UNGROUPED; default=[y]
    label: Special
    default: y
    inputBinding:
      prefix: --special
  update-sname:
    type: boolean?
    doc: Update '-RPK' in sample names to appropriate suffix; default false
    label: Update sname
    inputBinding:
      prefix: --update-sname  

outputs:
  renormalized_table:
    type: File
    outputBinding: {glob: '*.tsv'}

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-02-14"
s:dateCreated: "2025-02-11"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

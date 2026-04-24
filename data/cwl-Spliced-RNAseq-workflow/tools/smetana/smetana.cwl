#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: SMETANA
doc: |
    Species METabolic interaction ANAlysis (SMETANA) is a python-based command line tool to analyse microbial communities.
    It takes as input a microbial communtity (from a collection of genome-scale metabolic models in SBML format) and 
    computes of several metrics that describe the potential for cross-feeding interactions between community members.
        
requirements:
  InlineJavascriptRequirement: {}

hints:
  SoftwareRequirement:
    packages:
      python3:
        version: ["1.2.0"]
        specs: ["https://pypi.org/project/smetana", "doi.org/10.1073/pnas.1421834112"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker-private/smetana:1.2.0

baseCommand: [ smetana ]

outputs:
  detailed_output_tsv:
    label: SMETANA output
    doc: SMETANA detailed tsv output
    type: File
    outputBinding:
      glob: $(inputs.identifier)_SMETANA*

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: Identifier used

  GEM:
    label: Metabolic model
    doc: Multiple Metabolic models (xml format)
    type: File[]
    inputBinding:
      position: 10
  media:
    type: string?
    label: Media database
    doc: Media database file
    inputBinding:
      prefix: -m
      position: 1
  mediadb:
    type: File?
    label: Media database
    doc: Media database file
    inputBinding:
      prefix: --mediadb  
      position: 2
  flavor:
    type: string
    label: Flavor
    doc: Expected SBML flavor of the input files (cobra or fbc2)
    inputBinding:
      prefix: --flavor
      position: 3

  global:
      type: boolean?
      doc: Calculates all inter-species interactions (much slower), check Algorithms for details.
      label: Global mode
      inputBinding:
        prefix: "--global"
        position: 11
  detailed:
      type: boolean?
      doc: Runs MIP/MRO and is much faster, recommended when analysing multiple communities.
      label: Detailed mode
      inputBinding:
        prefix: "--detailed"
        position: 11

  solver:
    type: string?
    label: solver
    doc: Set the solver to be used. [cplex|glpk|gurobi|glpk_exact]. default; glpk
    inputBinding:
      prefix: --solver
      position: 4

arguments:
  - "--verbose"
  - prefix: "--output"
    valueFrom: $(inputs.identifier)_SMETANA

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
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
s:dateCreated: "2022-06-00"
s:dateModified: "2023-02-20"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "CarveMe"
doc: |
    CarveMe is a python-based tool for genome-scale metabolic model reconstruction.
    (Workflow will finish as successful even though no model can be created. Check messages!)
        
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.protein_file)

hints:
  SoftwareRequirement:
    packages:
      python3:
        version: ["1.6.1"]
        specs: ["https://pypi.org/project/carveme", "doi.org/10.1093/nar/gky537"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/carveme:1.6.1

baseCommand: [ carve ]

outputs:
  carveme_gem:
    label: CarveMe GEM
    doc: CarveMe metabolic model Output SBML in sbml-fbc2 format
    type: File # Changed File? to File
    outputBinding:
      glob: $(inputs.protein_file.nameroot).GEM.xml

inputs:
  protein_file:
    type: File
    label: Input fasta file
    doc: Proteins sequence file in FASTA format. 
    inputBinding:
        position: 0

  gapfill:
    type: string?
    label: Gap fill
    doc: Gap fill model for given media
    inputBinding:
      prefix: --gapfill
    # default: "M8"

  mediadb:
    type: File?
    label: Media database
    doc: Media database file
    inputBinding:
      prefix: --mediadb

  init:
    type: File?
    label: Initial media
    doc: Initialize model with given medium
    inputBinding:
      prefix: --init

  carveme_solver:
    type: string?
    label: carveme_solver
    doc: Solver to use for optimization, by default cplex which is properly configured in the docker image. Alternatively, you can use the open source SCIP solver. This will be slower (expect at least 10 min per execution).
    inputBinding:
      prefix: --solver
    # default: "cplex"

arguments:
  - "--fbc2"
  - prefix: "--output"
    valueFrom: $(inputs.protein_file.nameroot).GEM.xml

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
s:dateCreated: "2022-06-00"
s:dateModified: "2023-02-20"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

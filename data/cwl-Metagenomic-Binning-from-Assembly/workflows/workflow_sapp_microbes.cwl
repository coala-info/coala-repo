#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
   - class: StepInputExpressionRequirement
   - class: InlineJavascriptRequirement
   - class: MultipleInputFeatureRequirement
   - class: LoadListingRequirement

label: Genome conversion and annotation
doc: Workflow for genome annotation from FASTA format

inputs:
  fasta:
    type: File
    doc: Genome sequence in FASTA format
    label: FASTA input file
  identifier:
    type: string
    doc: Identifier of the sample being converted
    label: Sample name
  codon_table:
    type: int
    doc: Codon table used for gene prediction
    label: Codon table
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    default: 2
  interpro:
    type: Directory
    doc: Path to the interproscan application directory 
    label: InterProScan path
    loadListing: no_listing
  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
  conversion:
    run: ../tools/sapp/conversion.cwl
    in:
      identifier: identifier
      fasta: fasta
      codon_table: codon_table
    out: [output]
############################
  # infernal:
  #   run: ../tools/sapp/infernal.cwl
  #   in:
  #     identifier: identifier
  #     input: conversion/output
  #     threads: threads
  #   out: [output]
############################
  prodigal:
    run: ../tools/sapp/prodigal.cwl
    in:
      identifier: identifier
      input: conversion/output
    out: [output]
############################
  # kofamscan:
  #   run: ../tools/sapp/kofamscan.cwl
  #   in:
  #     identifier: identifier
  #     input: prodigal/output
  #     threads: threads
  #   out: [output]
############################
  interproscan:
    run: ../tools/sapp/interproscan.cwl
    in:
      identifier: identifier
      input: prodigal/output
      cpu: threads
      interpro: interpro
    out: [output]
############################
  gzip:
    run: ../tools/bash/pigz.cwl
    in:
      inputfile: interproscan/output
      threads: threads
    out: [output]

outputs:
  output:
    type: File
    outputSource: gzip/output
  
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
s:dateCreated: "2021-00-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

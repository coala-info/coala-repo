#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
   - class: StepInputExpressionRequirement
   - class: InlineJavascriptRequirement
   - class: MultipleInputFeatureRequirement

label: Genome conversion and annotation
doc: Workflow for genome annotation from EMBL format

inputs:
  embl:
    type: File
    doc: Genome sequence in EMBL format
    label: EMBL input file
  fasta:
    type: File?
    doc: Genome sequence in FASTA format
    label: EMBL input file
  identifier:
    type: string
    doc: Identifier of the sample being converted
    label: Sample name
  codon:
    type: int
    doc: Codon table used for gene prediction
    label: Codon table
    default: 1
  genome:
    type: boolean?
    doc: FASTA to RDF conversion with genome data
    # default: true
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    default: 2
  interpro:
    type: Directory
    doc: Path to the interproscan application directory 
    label: InterProScan path

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
  conversion:
    run: ../tools/sapp/conversion.cwl
    in:
      identifier: identifier
      embl: embl
      fasta: fasta
      codon: codon
      genome: genome
    out: [output]
############################
  # Check for genes?
  count_genes:
    run: ../tools/bash/grep_count.cwl
    in:
      grep: 
        default: "/Gene>"
      infile: conversion/output
    out: [matches]
############################
  interproscan:
    when: $(inputs.matches > 0)
    run: ../tools/sapp/interproscan.cwl
    in:
      matches: count_genes/matches
      identifier: identifier
      input: conversion/output
      interpro: interpro
      cpu: threads
    out: [output]
############################
  tohdt:
    run: ../tools/sapp/toHDT.cwl
    in:
      output: 
        valueFrom: $(inputs.identifier).hdt
      input: interproscan/output
    out: [output]

outputs:
  output:
    type: File
    outputSource: tohdt/output

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
s:dateCreated: "2020-00-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/

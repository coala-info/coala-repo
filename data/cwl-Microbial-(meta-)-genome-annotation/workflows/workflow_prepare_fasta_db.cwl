#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}

label: Prepare (multiple) fasta files to one file. 
doc: |
  Prepare (multiple) fasta files to one file. 
  With option to make unique headers to avoid same fasta headers, which can break some tools.

inputs:
  output_name:
    type: string
    doc: Output name for this dataset used
    label: identifier used
  fasta_input:
    type: File[]
    label: Fasta input
    doc: Fasta file(s) to prepare
  make_headers_unique:
    type: boolean?
    label: Make headers unique
    doc: Make fasta headers unique avoiding same fasta headers, which can break some tools.

outputs:
  fasta_db:
    type: File
    label: Prepared fasta file
    doc: Prepared fasta file
    outputSource:
      - fasta_array_to_file/file
      - merge_input/output
      - prepare_fasta_db/fasta_db
    pickValue: first_non_null

steps:
#############################################
#### Pick first file of reference when make_headers_unique is false
  fasta_array_to_file:
    label: Array to file
    doc: Pick first file of filter_reference when make_headers_unique input is false
    when: $(inputs.make_headers_unique === false && inputs.fasta_input.length === 1)
    run: ../tools/expressions/array_to_file_tool.cwl
    in:
      make_headers_unique: make_headers_unique
      fasta_input: fasta_input

      files: fasta_input
    out: [file]
#############################################
#### Merging of reference files files to only one
  merge_input:
    label: Merge reference files
    doc: Only merge input when make unique is false. 
    when: $(inputs.make_headers_unique === false && inputs.fasta_input.length > 1)
    run: ../tools/bash/concatenate.cwl
    in:
      output_name: output_name
      make_headers_unique: make_headers_unique
      fasta_input: fasta_input

      infiles: fasta_input
      outname:
        valueFrom: $(inputs.output_name)_filter-reference_merged.fa
    out: [output]
#############################################
#### Preparation of reference files
  prepare_fasta_db:
    label: Prepare references
    doc: Prepare references to a single fasta file and unique headers
    when: $(inputs.make_headers_unique)
    run: ../tools/bbmap/prepare_fasta_db.cwl
    in:
      output_name: output_name
      fasta_input: fasta_input
      make_headers_unique: make_headers_unique

      fasta_files: fasta_input
      output_file_name:
        valueFrom: $(inputs.output_name)_filter-reference_uniq.fa.gz
    out: [fasta_db]

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
s:dateModified: 2024-10-07
s:dateCreated: "2023-01-00"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/

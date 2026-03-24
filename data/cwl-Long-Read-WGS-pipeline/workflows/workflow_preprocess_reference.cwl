#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}

label: plasmid preprocessing workflow
doc: |
  **Workflow for preprocessing the reference file. Downloads the GenBank file from NCBI if not provided, concatenates plasmid GenBank file(s) with each other and the reference file, extracts GFF3 from the (merged) reference.**

  This workflow on WorkflowHub: https://workflowhub.eu/workflows/1818

  **All tool CWL files and other workflows can be found here:**
    Tools: https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/tools
    Workflows: https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/workflows

inputs:
  reference_file:
    type: File?
    label: reference GenBank file
    doc: Reference file in GenBank format.
  accession_number:
    type: string?
    label: accession number
    doc: accession number, used to download a GenBank file from NCBI, mandatory when not inputting a reference file.
  plasmids:
    type: File[]?
    label: plasmid file(s)
    doc: Input plasmid GenBank files.
    
  # scripts
  merging_genbank_script:
    type: File
    label: merging script
    doc: Python script to merge multiple GenBank Files. Passed externally within the git structure to avoid having to host a new image.
    default: 
      class: File
      location: ../tools/scripts/merge_genbank.py
      basename: merge_genbank.py
  fasta_extraction_script:
    type: File
    label: FASTA extraction script
    doc: Python script that extracts a FASTA file from GenBank Files. Passed externally within the git structure to avoid having to host a new image.
    default: 
      class: File
      location: ../tools/scripts/genbank_to_fasta.py
      basename: genbank_to_fasta.py
  gff3_extraction_script:
    type: File
    label: GFF3 extraction script
    doc: BioPerl script that extracts a GFF3 file from GenBank Files. Passed externally within the git structure to avoid having to host a new image.
    default: 
      class: File
      location: ../tools/scripts/bp_genbank2gff3_fixed.pl
      basename: bp_genbank2gff3_fixed.pl

steps:
#############################################
#### Fetch reference from NCBI
  fetch_reference:
    label: fetch reference
    doc: Downloads the associated GenBank file from the supplied accession number.
    run: ../tools/scripts/download_genbank.cwl
    when: $(inputs.accession_number !== null && inputs.reference_file === null)
    in:
      accession_number: accession_number
      reference_file: reference_file
    out: [genbank_file]
#############################################
#### Plasmid merging
  merge_plasmids:
    label: merge plasmids
    doc: Merges plasmids when more than one are present.
    run: ../tools/scripts/merge_genbank.cwl
    when: $(inputs.plasmids !== null && inputs.plasmids.contents !== "" && inputs.plasmids.length > 1)
    in:
      plasmids: plasmids
      script: merging_genbank_script
      genbank_files: plasmids
      output_prefix:
        valueFrom: "merged_plasmids"
    out: [merged_genbank]
#############################################
#### Merge plasmid(s) and reference
  merge_reference:
    label: merge plasmid(s) with reference
    doc: Merges the plasmid(s) with the reference GenBank file.
    run: ../tools/scripts/merge_genbank.cwl
    when: $(inputs.plasmids !== null && inputs.plasmids.contents !== "") 
    in:
      script: merging_genbank_script
      reference_file: reference_file
      plasmids: plasmids
      merged_plasmids: merge_plasmids/merged_genbank
      fetched_reference: fetch_reference/genbank_file
      genbank_files: 
        valueFrom: |
            ${
              var gb_list = [];
              if (inputs.reference_file) {
                gb_list.push(inputs.reference_file);
              } else if (inputs.fetched_reference) {
                gb_list.push(inputs.fetched_reference);
              }
              if (inputs.plasmids && inputs.plasmids.length > 1) {
                gb_list.push(inputs.merged_plasmids);
              } else if (inputs.plasmids) {
                gb_list.push(inputs.plasmids[0]);
              }
              return gb_list;
            }
      output_prefix:
        valueFrom: "merged_reference"
      fasta_output:
        valueFrom: $(true)
    out: [ merged_genbank, merged_fasta ]
#############################################
#### Extract FASTA
  extract_fasta:
    label: extract FASTA
    doc: Extracts FASTA file from input reference file when no plasmids are provided.
    run: ../tools/scripts/genbank_to_fasta.cwl
    when: $(inputs.plasmids == null)
    in:
      script: fasta_extraction_script
      plasmids: plasmids
      reference_file: reference_file
      genbank_file: 
        source: [ fetch_reference/genbank_file, reference_file ]
        pickValue: first_non_null
      output_prefix:
        valueFrom: "extracted"
    out: [fasta]
#############################################
#### Extract GFF3
  extract_gff3:
    label: extract GFF3
    doc: Extracts GFF3 annotation file from the (merged) reference.
    run: ../tools/scripts/genbank_to_gff3.cwl
    in:
      script: gff3_extraction_script
      genbank_file: 
        source: [ merge_reference/merged_genbank, fetch_reference/genbank_file, reference_file ]
        pickValue: first_non_null
    out: [gff3]
#############################################
#### Determine final output
  determine_output:
    label: determine output
    doc: Determines relevant final outputs.
    run: ../tools/expressions/determine_output.cwl
    in:
      merged_genbank: merge_reference/merged_genbank
      merged_fasta: merge_reference/merged_fasta
      fetched_reference: fetch_reference/genbank_file
      original_reference: reference_file
      extracted_fasta: extract_fasta/fasta
    out: [ genbank, fasta ]

outputs:
  genbank_final:
    type: File
    label: GenBank output file
    doc: Final GenBank output file.
    outputSource: determine_output/genbank
  fasta_final:
    type: File
    label: FASTA output file
    doc: Final FASTA output file.
    outputSource: determine_output/fasta
  gff3:
    type: File
    label: GFF3 output file
    doc: Final GFF3 output file.
    outputSource: extract_gff3/gff3
  
$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: placeholder
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis/cwl
s:dateCreated: "2025-04-14"
s:dateModified: "2025-06-20"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "placeholder"
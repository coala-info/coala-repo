#!/usr/bin/env cwl-runner

# TODO
# - Implement 
#   - SPADES V
#   - PRODIGAL V
#   - BARRNAP
#   - ARAGORN
#   - INTERPROSCAN
#   - BLAST (SWISSPROT)
#   - EC?
# 

cwlVersion: v1.2
class: Workflow
requirements:
   - class: StepInputExpressionRequirement
   - class: InlineJavascriptRequirement
   - class: MultipleInputFeatureRequirement
   - class: SubworkflowFeatureRequirement

label: Microbial (meta-)? genome annotation
doc: Workflow for genome annotation

inputs:
  isolate:
    type: boolean?
    doc: this flag is highly recommended for high-coverage isolate and multi-cell data
    label: high-coverage mode
  metagenomics:
    type: boolean?
    doc: this flag is required for metagenomic sample data
    label: metagenomics sample
  threads:
    type: int?
    doc: Number of threads to use for computational processes
    label: Number of threads
    default: 2
  memory:
    type: int?
    doc: Maximum memory usage in MegaBytes
    label: Maximum memory in MB
    default: 4000
  fasta:
    type: File
    label: genome fasta file
    doc: Genome fasta file used for annotation

steps:
  prodigal:
   run: ../prodigal/prodigal.cwl
   in:
    input_fasta: fasta
    meta_mode: metagenomics
    single_mode: isolate
   out: [predicted_proteins_out, predicted_proteins_ffn, predicted_proteins_faa]
############################
  # interproscan:
  #   label: "InterProScan: protein sequence classifier"
  #   run: ../interproscan/InterProScan.cwl
  #   in:
  #     input_fasta: prodigal/predicted_proteins_faa
  #   out: [annotations]
  eggnog:
    label: "eggNOG"
    run: ../eggnog/eggnog.cwl
    in:
      input_fasta: prodigal/predicted_proteins_faa
    out: [output_annotations, output_orthologs]


outputs:
  # Prodigal outputs
  prodigal_output_predicted_proteins_out: 
    type: File
    outputSource: prodigal/predicted_proteins_out
  prodigal_output_predicted_proteins_ffn:
    type: File
    outputSource: prodigal/predicted_proteins_ffn
  prodigal_output_predicted_proteins_faa:
    type: File
    outputSource: prodigal/predicted_proteins_faa
    
#   spades_files_to_folder:
#     type: Directory
#     outputSource: spades_files_to_folder/results

#   prodigal_files_to_folder:
#     type: Directory
#     outputSource: prodigal_files_to_folder/results


s:author:
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
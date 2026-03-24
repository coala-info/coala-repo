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

label: Microbial (meta-)? genome conversion and annotation
doc: Workflow for the assembly, conversion, gene predication and annotation for microbial systems

inputs:
  isolate:
    type: boolean?
    doc: this flag is highly recommended for high-coverage isolate and multi-cell data
    label: high-coverage mode
  metagenomics:
    type: boolean?
    doc: this flag is required for metagenomic sample data
    label: metagenomics sample
  biosyntheticSPAdes:
    type: boolean?
    doc: this flag is required for biosyntheticSPAdes mode
    label: biosynthetic spades mode
  rna:
    type: boolean?
    doc: this flag is required for RNA-Seq data
    label: rnaseq data
  plasmid:
    type: boolean?
    doc: runs plasmidSPAdes pipeline for plasmid detection
    label: plasmid spades run
  IonTorrent:
    type: boolean?
    doc: this flag is required for IonTorrent data
    label: iontorrent data
  forward_reads:
    type: File[]
    doc: The file containing the forward reads
    label: Forward reads
  reverse_reads:
    type: File[]
    doc: The file containing the reverse reads
    label: Reverse reads
  pacbio_reads:
    type: File[]?
    doc: file with PacBio reads
    label: pacbio reads
  threads:
    type: int
    doc: number of threads to use
    label: threads
  memory:
    type: int
    doc: Memory used in megabytes

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
  spades:
    run: ../assembly/spades.cwl
    in:
      isolate: isolate
      metagenomics: metagenomics
      biosyntheticSPAdes: biosyntheticSPAdes
      rna: rna
      plasmid: plasmid
      IonTorrent: IonTorrent
      forward_reads: forward_reads
      reverse_reads: reverse_reads
      pacbio_reads: pacbio_reads
      threads: threads
      memory: memory
    out: [stdout, stderr, contigs, scaffolds, assembly_graph, contigs_assembly_graph, scaffolds_assembly_graph, contigs_before_rr, params, log, internal_config]
############################
  prodigal:
   run: ../prodigal/prodigal.cwl
   in:
    input_fasta: spades/scaffolds
    meta: metagenomics
    single: isolate
   out: [stdout, stderr, predicted_proteins_out, predicted_proteins_ffn, predicted_proteins_faa]
############################
#  interproscan:
#   run: ../sapp/interproscan.cwl
#   in:
#    input: prodigal/output
#    output: output
#   out: [output]
############################
  spades_files_to_folder:
    run: ../expressions/files_to_folder.cwl
    in:
      files: 
        source: [spades/stdout, spades/stderr, spades/contigs, spades/scaffolds, spades/assembly_graph, spades/contigs_assembly_graph, spades/scaffolds_assembly_graph, spades/contigs_before_rr, spades/params, spades/log, spades/internal_config]
      folder: 
        default: "1_Assembly"
    out:
      [results]
############################
  prodigal_files_to_folder:
    run: ../expressions/files_to_folder.cwl
    in:
      files: 
        source: [prodigal/predicted_proteins_out, prodigal/predicted_proteins_ffn, prodigal/predicted_proteins_faa, prodigal/stdout, prodigal/stderr]
      folder: 
        default: "2_GenePrediction"
    out:
      [results]

outputs:
  spades_files_to_folder:
    type: Directory
    outputSource: spades_files_to_folder/results

  prodigal_files_to_folder:
    type: Directory
    outputSource: prodigal_files_to_folder/results


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
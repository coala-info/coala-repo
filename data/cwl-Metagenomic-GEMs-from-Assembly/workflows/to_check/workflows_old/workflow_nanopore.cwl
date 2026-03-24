#!/usr/bin/env cwltool
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Nanopore Guppy Basecalling Assembly Workflow
doc: |
  Workflow for sequencing with ONT Nanopore, from basecalling to assembly.
    - Guppy (basecalling of raw reads)
    - MinIONQC (quality check)
    - FASTQ merging from multi into one file
    - Kraken2 (taxonomic classification)
    - Krona (classification visualization)
    - Flye (de novo assembly)
    - Medaka (assembly polishing)
    - QUAST (assembly quality reports)

  **All tool CWL files and other workflows can be found here:**<br>
    Tools: https://git.wur.nl/unlock/cwl/-/tree/master/cwl<br>
    Workflows: https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows<br>

  The dependencies are either accessible from https://unlock-icat.irods.surfsara.nl (anonymous,anonymous)<br>
  and/or<br>
  By using the conda / pip environments as shown in https://git.wur.nl/unlock/docker/-/blob/master/kubernetes/scripts/setup.sh<br>
      
outputs:
  guppy_output:
    label: Guppy for CPU
    doc: Basecalling of raw reads with Guppy
    type: Directory
    outputSource: guppy_files_to_folder/results
  fastqc_output:
    label: FASTQC report
    doc: FASTQC quality html report files
    type: Directory
    outputSource: workflow_nanopore_assembly/fastqc_output
  # minionqc_output:
  #   label: MinION-Quality-Check
  #   doc: Quality check of basecalling with MinIONQC
  #   type: Directory
  #   outputSource: minionqc_files_to_folder/results
  # merge_output:
    # label: FASTQ files merged
    # doc: Concatenation of FASTQ files from Guppy
    # type: Directory
  kraken2_output:
    label: Kraken2 reports
    doc: Kraken2 taxonomic classification reports
    type: Directory 
    outputSource: workflow_nanopore_assembly/kraken2_output
  flye_output:
    label: Flye de novo assembler for single-molecule reads
    doc: Flye output directory
    type: Directory
    outputSource: workflow_nanopore_assembly/flye_output
  medaka_output:
    label: Medaka polisher
    doc: Polishing of Flye assembly
    type: Directory
    outputSource: workflow_nanopore_assembly/medaka_output
  metaquast_output:
    label: QUAlity assessment
    doc: QUAST analysis output
    type: Directory
    outputSource: workflow_nanopore_assembly/metaquast_output

inputs:
# General
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    default: 2
# Guppy
  fast5_files:
    type: string[]?
    doc: list of files with Nanopore raw reads
    label: nanopore reads
# FASTQ additional files
  fastq_files:
    type: string[]?
    doc: list of file paths with Nanopore raw reads in fastq format
    label: nanopore reads
# Guppy
  fast5_directory:
    type: string?
    doc: folder with Nanopore raw reads
    label: folder with nanopore reads
  configuration_command:
    type: string
# Kraken2
  kraken_database:
    type: string 
    doc: database location of kraken2
# Medaka
  basecall_model:
    type: string
    doc: basecalling model used with Guppy
    label: basecalling model
  # Flye
  metagenome:
    type: boolean?
    doc: Metagenome option for the flye assembly
    label: when working with metagenomes
    default: true

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
#############################################
#### basecalling with Guppy for CPU
  workflow_basecalling:
    label: Guppy-CPU basecalling
    doc: Basecalling with Guppy for CPU of raw reads to FASTQ reads with summary
    run: ../guppy/guppy.cwl
    in:
      fast5_files: fast5_files
      fast5_directory: fast5_directory
      configuration_command: configuration_command
      threads: threads
    out: [reads_directory, fastq_reads, summary, telemetry, guppy_log]
#############################################
#### merging of FASTQ files to only one for Kraken2
  merge_fastq: 
    run: ../bash/concatenate.cwl
    in:
      identifier: identifier
      infiles: 
        source: [workflow_basecalling/fastq_reads]
        linkMerge: merge_flattened
        pickValue: all_non_null
      file_paths:
        source: [fastq_files]
        linkMerge: merge_flattened
        pickValue: all_non_null
      outname: 
        valueFrom: $(inputs.identifier).fastq
    out: [output]
#############################################
#### Gzip compression of files
  fastq_compress:
    run: ../bash/compress.cwl
    in:
      infile: merge_fastq/output
    out: [output]
#############################################
#### Nanopore classification and assembly workflow
  workflow_nanopore_assembly:
    label: Nanopore workflow
    doc: The rest of the nanopore workflow without basecalling
    run: workflow_nanopore_assembly.cwl
    in:
      identifier: identifier
      threads: threads
      # bam_workers: threads
      metagenome: metagenome
      nanopore_fastq_reads:
        source: [fastq_compress/output]
        linkMerge: merge_nested
      kraken_database: kraken_database
      basecall_model: basecall_model
    out: [fastqc_output, kraken2_output, flye_output, medaka_output, metaquast_output]
############################################# LOCAL INSTALL, BUT USE CONDA IF NO CONFLICTS
#### quality check of basecalling with MinIONQC
  # workflow_minionqc:
  #   label: MinIONQC quality check
  #   doc: Plots and statistics generated with MinIONQC from basecalling with Guppy
  #   run: ../minionqc/minionqc.cwl
  #   in:
  #     seq_summary: workflow_basecalling/summary
  #     threads: threads
  #   out: [qc_files]
#############################################
#### Move to folder if not part of a workflow
  guppy_files_to_folder:
    doc: Preparation of Guppy output files to a specific output folder
    label: Guppy output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [workflow_basecalling/summary, workflow_basecalling/telemetry, workflow_basecalling/guppy_log, fastq_compress/output]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("0.1_Guppy_basecalling")
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  # minionqc_files_to_folder:
  #   doc: Preparation of MinIONQC output files to a specific output folder
  #   label: MinIONQC output folder
  #   run: ../expressions/files_to_folder.cwl
  #   in:
  #     files:
  #       source: [workflow_minionqc/qc_files]
  #       linkMerge: merge_flattened
  #     destination:
  #       valueFrom: $("0.2_MinIONQC_qualitycheck")
  #   out:
  #     [results]
#############################################

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5516-8391
    s:email: mailto:german.royvalgarcia@wur.nl
    s:name: Germán Royval
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
s:dateCreated: "2021-12-10"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
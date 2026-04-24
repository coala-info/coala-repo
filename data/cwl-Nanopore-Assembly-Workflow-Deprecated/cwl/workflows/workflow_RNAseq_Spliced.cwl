#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Spliced RNAseq workflow
doc: | 
  Workflow for Spliced RNAseq data
  Steps:  
      - workflow_illumina_quality:
          - FastQC (Read Quality Control)
          - fastp (Read Trimming)
      - STAR (Read mapping)
      - featurecounts (transcript read counts)
      - kallisto (transcript [pseudo]counts)

outputs:
  filtered_stats:
    label: Filtered statistics
    doc: Statistics on quality and preprocessing of the reads
    type: Directory
    outputSource: workflow_quality/reports_folder
  STAR_output:
    type: Directory
    label: STAR output folder
    doc: STAR results folder. Contains logs, bam file, readcounts per gene and splice_junctions.
    outputSource: STAR_files_to_folder/results
  featurecounts_output:
    type: Directory
    label: FeatureCounts output
    doc: FeatureCounts results folder. Contains readcounts, summary and mapping statistics (stdout).
    outputSource: featurecounts_files_to_folder/results
  kallisto_output:
    type: Directory
    label: kallisto output
    doc: kallisto results folder. Contains transcript abundances, run info and summary.
    outputSource: kallisto_files_to_folder/results

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
  memory:
    type: int?
    doc: maximum memory usage in megabytes
    label: maximum memory usage in megabytes
  filter_rrna:
    type: boolean
  forward_reads:
    type: string[]
    doc: forward sequence file locally
    label: forward reads
  reverse_reads:
    type: string[]
    doc: reverse sequence file locally
    label: reverse reads

  STAR-indexfolder: 
    type: Directory
    label: folder where the STAR indices are
  kallisto-indexfolder:
    type: Directory?
    label: folder where the kallisto indices are

  gtf:
    type: File
    doc: gtf file

  quantMode:
    type:
     - "null"
     - type: enum
       symbols:
        - None
        - TranscriptomeSAM
        - GeneCounts
    doc: Run with get gene quantification

  contamination_references:
    type: string[]
    doc: bbmap reference fasta file for contamination filtering
    label: contamination reference file

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
  #########################################
  # Workflow for quality and filtering of raw reads
  workflow_quality:
    label: Quality and filtering workflow
    doc: Quality assessment of illumina reads with rRNA filtering option
    run: workflow_illumina_quality.cwl
    in:
      forward_reads: forward_reads
      reverse_reads: reverse_reads
      filter_references: contamination_references
      memory: memory
      threads: threads
      identifier: identifier
      filter_rrna: filter_rrna
      step: 
    out: [QC_reverse_reads, QC_forward_reads, reports_folder]
  #########################################
  # STAR alignment
  STAR:
    label: STAR
    doc: runs STAR alignment on the genome with the quality filtered reads.
    in:
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads

      OutFileNamePrefix:
        source: identifier
        valueFrom: $(self+"_")
      genomeDir: STAR-indexfolder
      sjdbGTFfile: gtf
      quantMode: quantMode
   
      memory: memory
      threads: threads
    run: ../RNAseq/star/star_align.cwl
    out: 
      [bam, log_file,final_log_file, reads_per_gene, splice_junctions]
  #########################################
  # FeatureCounts
  featurecounts:
    label: FeatureCounts
    doc: Calculates gene counts with bowtie2 mapped data and input GTF file with FeatureCounts.
    in:
      prefix: identifier
      bam: STAR/bam
      gtf: gtf
      threads: threads
    run: ../RNAseq/featurecounts.cwl
    out: 
      [readcounts, summary, overview]
  #########################################
  # kallisto transcript abundances
  kallisto:
    label: kallisto
    doc: Calculates transcript abundances
    in:
      prefix: identifier
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
      indexfolder: kallisto-indexfolder
      threads: threads
    run: ../RNAseq/kallisto/kallisto_quant.cwl
    out:
      [abundance.h5, abundance.tsv, run_info, summary]

#############################################
#### Move to folder if not part of a workflow
  STAR_files_to_folder:
    label: STAR output
    doc: Preparation of STAR output files to a specific output folder
    in:
      files:
        source: [STAR/bam, STAR/log_file, STAR/final_log_file, STAR/reads_per_gene, STAR/splice_junctions]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
    run: ../expressions/files_to_folder.cwl
    out:
      [results]

  featurecounts_files_to_folder:
    label: FeatureCounts output
    doc: Preparation of FeatureCounts output files to a specific output folder    
    in:
      files: 
        source: [featurecounts/readcounts, featurecounts/summary, featurecounts/overview]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
    run: ../expressions/files_to_folder.cwl
    out:
      [results]

  kallisto_files_to_folder:
    label: kallisto output
    doc: Preparation of kallisto output files to a specific output folder
    in:
      files: 
        source: [kallisto/abundance.h5, kallisto/abundance.tsv, kallisto/run_info, kallisto/summary]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
    run: ../expressions/files_to_folder.cwl
    out:
      [results]
#############################################

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

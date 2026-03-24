#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: NonSpliced RNAseq workflow
doc: | 
  Workflow for NonSpliced RNAseq data alignment with multiple aligners.
  Steps:  
      - workflow_illumina_quality.cwl:
          - FastQC (control)
          - fastp (trimming)
      - bowtie2 (read mapping)
      - sam_to_sorted-bam
      - featurecounts (transcript read counts)
      - kallisto (transcript [pseudo]counts)

outputs:
  filtered_stats:
    label: Filtered statistics
    doc: Statistics on quality and preprocessing of the reads
    type: Directory
    outputSource: workflow_quality/reports_folder
  bowtie2_output:
    type: Directory
    label: bowtie2 output
    doc: bowtie2 mapping results folder. Contains sorted bam file, metrics file and mapping statistics (stdout).
    outputSource: bowtie2_files_to_folder/results
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
    default: 2
  memory:
    type: int?
    doc: maximum memory usage in megabytes
    label: Max memory
    default: 4000
  filter_rrna:
    type: boolean
    label: Filter rRNA
    doc: Filter rRNA from reads if true
    default: false
  forward_reads:
    type: string[]
    doc: forward sequence file locally
    label: forward reads
  reverse_reads:
    type: string[]
    doc: reverse sequence file locally
    label: reverse reads
  bowtie2-indexfolder:
    type: Directory
    label:  bowtie2 index
    doc: Folder location of the bowtie2 index files.
  kallisto-indexfolder:
    type: Directory?
    label: kallisto index
    doc: Folder location of the kallisto index file.
  gtf:
    type: File?
    label: GTF file
    doc: GTF file location

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
        default: 1
    out: [QC_reverse_reads, QC_forward_reads, reports_folder]
  #########################################
  # bowtie2 alignment
  bowtie2:
    label: bowtie2
    doc: runs bowtie2 alignment on the genome with the quality filtered reads.
    run: ../tools/bowtie2/bowtie2_align_simple.cwl
    in:
      prefix: identifier
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
      indexfolder: bowtie2-indexfolder
      threads: threads
    out:     
      [sam, metricsfile,bowtie2_stats]
  #########################################
  # convert sam file to sorted bam file
  sam_to_sorted-bam:
    label: sam to sorted bam
    doc: Converts a SAM file to a sorted BAM file
    run: ../tools/samtools/sam_to_sorted-bam.cwl
    in:
      identifier: 
       source: identifier
       valueFrom: $(self+"_bowtie2")
      sam: bowtie2/sam
      threads: threads
    out: 
      [sortedbam]
  #########################################
  # Feature counts with GTF file and with bowtie2 mapped output
  featurecounts:
    label: FeatureCounts
    doc: Calculates gene counts with bowtie2 mapped data and input GTF file with FeatureCounts.
    run: ../tools/RNAseq/featurecounts.cwl
    in:
      prefix: identifier
      bam: sam_to_sorted-bam/sortedbam
      gtf: gtf
      threads: threads
    when: $(inputs.gtf != undefined)
    out: 
      [readcounts, summary, overview]
  #########################################
  # kallisto transcript abundances
  kallisto:
    label: kallisto
    doc: Calculates transcript abundances
    run: ../tools/RNAseq/kallisto/kallisto_quant.cwl
    in:
      gtf: gtf
      identifier: identifier
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
      index: kallisto-indexfolder
      threads: threads
    when: $(inputs.gtf != undefined)
    out:
      [abundance.h5, abundance.tsv, run_info, summary]

#############################################
#### Move to folder if not part of a workflow
  bowtie2_files_to_folder:
    label: bowtie2 output
    doc: Preparation of bowtie2 output files to a specific output folder
    run: ../tools/expressions/files_to_folder.cwl
    in:
      files: 
        source: [sam_to_sorted-bam/sortedbam, bowtie2/metricsfile, bowtie2/bowtie2_stats]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        default: "3_bowtie2-alignment"
    out:
      [results]

  featurecounts_files_to_folder:
    label: FeatureCounts output
    doc: Preparation of FeatureCounts output files to a specific output folder
    run: ../tools/expressions/files_to_folder.cwl
    in:
      gtf: gtf
      files: 
        source: [featurecounts/readcounts, featurecounts/summary, featurecounts/overview]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        default: "4_FeatureCounts"
    when: $(inputs.gtf != undefined)
    out:
      [results]
      
  kallisto_files_to_folder:
    label: kallisto output
    doc: Preparation of kallisto output files to a specific output folder
    run: ../tools/expressions/files_to_folder.cwl
    in:
      gtf: gtf
      files: 
        source: [kallisto/abundance.h5, kallisto/abundance.tsv, kallisto/run_info, kallisto/summary]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination: 
        default: "5_Kallisto"
    when: $(inputs.gtf != undefined)
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
  
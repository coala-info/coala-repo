#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Metagenomics workflow
doc: |
    Workflow for Metagenomics from raw reads to annotated bins.
    Steps:
      - workflow_illumina_quality.cwl:
          - FastQC (control)
          - fastp (quality trimming)
          - bbmap contamination filter
      - SPAdes isolate (Assembly)
      - Pilon (Assembly polishing)
      - QUAST (Assembly quality report)
      - BUSCO (Assembly completeness)

outputs:
  filtered_stats:
    label: Filtered statistics
    doc: Statistics on quality and preprocessing of the reads
    type: Directory
    outputSource: workflow_quality/reports_folder
  spades_output:
    label: SPAdes
    doc: Metagenome assembly output by SPADES
    type: Directory
    outputSource: spades_files_to_folder/results
  pilon_output:
    type: Directory
    outputSource: pilon_files_to_folder/results
  quast_output:
    label: QUAST
    doc: Quast analysis output folder
    type: Directory
    outputSource: quast_files_to_folder/results
  busco_output:
    label: BUSCO
    doc: BUSCO analysis output folder
    type: Directory
    outputSource: busco_files_to_folder/results

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  forward_reads:
    type: File[]
    doc: Forward sequence file locally
    label: forward reads
  reverse_reads:
    type: File[]
    doc: Reverse sequence file locally
    label: reverse reads
  mapped_reads:
    type: boolean
    doc: Continue with mapped reads the reference
    label: Keep mapped reads
    default: false
  deduplicate:
    type: boolean?
    doc: Remove exact duplicate reads with fastp
    label: Deduplicate reads
    default: false
  threads:
    type: int?
    doc: Number of threads to use for computational processes
    label: number of threads
    default: 2
  memory:
    type: int?
    doc: Maximum memory usage in megabytes
    label: memory usage (MB)
    default: 4000
  filter_references:
    type: string[]
    doc: Reference fasta file for contamination filtering
    label: Reference files (filter)
  busco_prok:
    type: boolean?
    default: false
    label: BUSCO prokaryote
    doc: Run BUSCO with auto prokaryote lineage
  busco_euk:
    type: boolean?
    default: false
    label: BUSCO eukaryote
    doc: run BUSCO with auto eukaryote lineage
  busco_dataset:
    type: string
    default: "/unlock/references/databases/BUSCO/BUSCO_odb10"
    label: BUSCO dataset
    doc: Path to the BUSCO dataset download location

steps:
#############################################
#### Workflow for quality and filtering using fastqc, fastp and optionally bbduk
  workflow_quality:
    label: Quality and filtering workflow
    doc: Quality assessment of illumina reads with rRNA filtering option
    run: workflow_illumina_quality.cwl
    in:
      forward_reads: forward_reads
      reverse_reads: reverse_reads
      filter_references: filter_references
      output_mapped: mapped_reads
      deduplicate: deduplicate
      memory: memory
      threads: threads
      identifier: identifier
      step: 
        default: 1
    out: [QC_reverse_reads, QC_forward_reads, reports_folder]
#############################################
#### SPADes assembly
  workflow_spades:
    doc: Genome assembly using spades with illumina/pacbio reads
    label: SPAdes assembly
    run: ../spades/spades.cwl
    in:
      forward_reads:
        source: [ workflow_quality/QC_forward_reads ]
        linkMerge: merge_nested
      reverse_reads: 
        source: [ workflow_quality/QC_reverse_reads ]
        linkMerge: merge_nested
      memory: memory
      threads: threads
      isolate:
        default: true
    out: [contigs, scaffolds, assembly_graph, contigs_assembly_paths, scaffolds_assembly_paths, contigs_before_rr, params, log, internal_config, internal_dataset]
#############################################
#### BBamp read mapping
  workflow_bbmap:
    label: bbmap read mapping
    doc: Illumina read mapping using BBmap on assembled contigs
    run: ../bbmap/bbmap.cwl
    in:
      identifier: identifier
      reference: workflow_spades/scaffolds
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
      memory: memory
    out: [sam, stats, covstats, log]
#############################################
#### Convert sam file to sorted bam
  workflow_sam_to_sorted_bam:
    label: sam conversion to sorted bam
    doc: Sam file conversion to a sorted bam file
    run: ../samtools/sam_to_sorted-bam.cwl
    in:
      identifier: identifier
      sam: workflow_bbmap/sam
      threads: threads
    out: [sortedbam]
#############################################
#### Index bam file
  workflow_sam_index:
    label: samtools index
    doc: Index file generation for sorted bam file
    run: ../samtools/samtools_index.cwl
    in:
      bam_file: workflow_sam_to_sorted_bam/sortedbam
      threads: threads
    out: [bam_index]
#############################################
#### Create hybrid bam bai file for Pilon cwl
  workflow_expressiontool_bam_index:
    run: ../samtools/expression_bam_index.cwl
    in:
      bam_file:
          source: workflow_sam_to_sorted_bam/sortedbam
      bam_index: workflow_sam_index/bam_index
    out: [hybrid_bamindex]
#############################################
#### Pilon
  workflow_pilon:
    label: pilon
    doc: Pilon draft assembly polishing with the mapped reads 
    run: ../pilon/pilon.cwl
    in:
      identifier: identifier
      assembly: workflow_spades/scaffolds
      bam_file: workflow_expressiontool_bam_index/hybrid_bamindex
    out: [pilon_polished_assembly, pilon_vcf]
#############################################
#### QUAST assembly quality assessment
  workflow_quast:
    doc: Genome assembly quality assessment using Quast
    label: Quast workflow
    run: ../quast/quast.cwl
    in:
      assembly: workflow_pilon/pilon_polished_assembly
    out: [basicStats, icarusDir, icarusHtml, quastReport, quastLog, transposedReport]
#############################################
#### BUSCO assembly completeness
  workflow_busco:
    doc: BUSCO assembly completeness workflow
    label: BUSCO workflow
    run: ../busco/busco.cwl
    in:
      identifier: identifier
      sequence_file: workflow_pilon/pilon_polished_assembly
      mode:
        valueFrom: "geno"
      auto-lineage-prok: busco_prok
      auto-lineage-euk: busco_euk
      threads: threads
      dataset: busco_dataset
    out: [logs, run_folders, short_summaries]

#############################################
#### Move to folder if not part of a workflow
  spades_files_to_folder:
    doc: Preparation of SPAdes output files to a specific output folder
    label: SPADES output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [workflow_spades/scaffolds, workflow_spades/contigs, workflow_spades/params, workflow_spades/log, workflow_spades/internal_config, workflow_spades/internal_dataset, workflow_bbmap/stats, workflow_bbmap/covstats, workflow_bbmap/log]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("2_SPAdes_Assembly")
    out:
      [results]

#############################################
#### Move to folder if not part of a workflow
  pilon_files_to_folder:
    doc: Preparation of quast output files to a specific output folder
    label: QUAST output folder
    run: ../expressions/files_to_folder.cwl
    in:
      identifier: identifier
      files: 
        source: [workflow_pilon/pilon_vcf, workflow_pilon/pilon_polished_assembly]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("3_Polished_assembly")
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  quast_files_to_folder:
    doc: Preparation of quast output files to a specific output folder
    label: QUAST output folder
    run: ../expressions/files_to_folder.cwl
    in:
      identifier: identifier
      files: 
        source: [workflow_quast/quastLog, workflow_quast/icarusHtml, workflow_quast/quastReport, workflow_quast/transposedReport]
        linkMerge: merge_flattened
      folders:
        source: [workflow_quast/basicStats, workflow_quast/icarusDir]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("4_Quast_AsssemblyQuality_")$(inputs.identifier)
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  busco_files_to_folder:
    doc: Preparation of BUSCO output files to a specific output folder
    label: BUSCO output folder
    run: ../expressions/files_to_folder.cwl
    in:
      identifier: identifier
      files: 
        source: [workflow_busco/short_summaries]
        linkMerge: merge_flattened
      folders:
        source: [workflow_busco/run_folders, workflow_busco/logs]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("5_BUSCO_AsssemblyCompleteness")
    out:
      [results]

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
s:dateCreated: "2022-02-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

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
      - workflow_quality.cwl:
          - FastQC (control)
          - fastp (quality trimming)
          - bbmap contamination filter
      - SPAdes (Assembly)
      - QUAST (Assembly quality report)
      - BBmap (Read mapping to assembly)
      - Contig binning (OPTIONAL)

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
  quast_output:
    label: QUAST
    doc: Quast analysis output folder
    type: Directory
    outputSource: quast_files_to_folder/results
  bam_output:
    label: BAM files
    doc: Mapping results in indexed BAM format
    type: Directory
    outputSource: sorted_bam_files_to_folder/results
  binning_output:
    label: BAM files
    doc: Mapping results in indexed BAM format
    type: Directory
    outputSource: binning_files_to_folder/results

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  forward_reads:
    type: File[]
    doc: forward sequence file locally
    label: forward reads
  reverse_reads:
    type: File[]
    doc: reverse sequence file locally
    label: reverse reads
  threads:
    type: int?
    doc: number of threads to use for computational processes
    label: number of threads
    default: 2
  memory:
    type: int?
    doc: maximum memory usage in megabytes
    label: memory usage (MB)
    default: 4000
  pacbio_reads:
    type: File[]?
    doc: file with PacBio reads locally
    label: pacbio reads
  contamination_references:
    type: string[]
    doc: bbmap reference fasta file for contamination filtering
    label: contamination reference file
  binning:
    type: boolean?
    label: Run binning workflow
    doc: Run with contig binning workflow
    default: true

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.


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
      filter_references: contamination_references
      memory: memory
      threads: threads
      identifier: identifier
      step: 
        default: 1
    out: [QC_reverse_reads, QC_forward_reads, reports_folder]
#############################################
#### assembly using SPADES
  workflow_spades:
    doc: Genome assembly using spades with illumina/pacbio reads
    label: SPAdes assembly
    run: ../assembly/spades.cwl
    in:
      forward_reads:
        source: [ workflow_quality/QC_forward_reads ]
        linkMerge: merge_nested
      reverse_reads: 
        source: [ workflow_quality/QC_reverse_reads ]
        linkMerge: merge_nested
      pacbio_reads: pacbio_reads
      metagenomics:
        default: true
      memory: memory
      threads: threads
    out: [contigs, scaffolds, assembly_graph, contigs_assembly_paths, scaffolds_assembly_paths, contigs_before_rr, params, log, internal_config, internal_dataset]
#############################################
#### assembly quality assessment using quast
  workflow_quast:
    doc: Genome assembly quality assessment using Quast
    label: Quast workflow
    run: ../quast/quast.cwl
    in:
      assembly: workflow_spades/contigs
    out: [basicStats, icarusDir, icarusHtml, quastReport, quastLog, transposedReport]
#############################################
#### read mapping using bbmap
  workflow_bbmap:
    label: bbmap read mapping
    doc: Illumina read mapping using BBmap on assembled contigs
    run: ../bbmap/bbmap.cwl
    in:
      identifier: identifier
      reference: workflow_spades/contigs
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
      memory: memory
    out: [sam, stats, covstats, rpkm, log]
#############################################
#### Convert sam file to sorted bam
  workflow_sam_to_sorted_bam:
    label: sam conversion to sorted bam
    doc: Sam file conversion to a sorted indexed bam file
    run: ../samtools/sam_to_sorted-bam.cwl
    in:
      identifier: identifier
      sam: workflow_bbmap/sam
      threads: threads
    out: [sortedbam]
#############################################
#### reports per contig alignment statistics
  workflow_contig_read_counts:
    label: samtools idxstats
    doc: Reports alignment summary statistics
    run: ../samtools/samtools_idxstats.cwl
    in:
      identifier: identifier
      bam_file: workflow_sam_to_sorted_bam/sortedbam
      threads: threads
    out: [contigReadCounts]
#############################################
#### Compress large Spades output
  compress_spades:
    label: SPAdes compressed
    doc: Compress the large Spades assembly output files
    run: ../bash/pigz.cwl
    scatter: [inputfile]
    scatterMethod: dotproduct
    in:
      threads: threads
      inputfile:
        source: [workflow_spades/contigs, workflow_spades/scaffolds,workflow_spades/assembly_graph,workflow_spades/contigs_before_rr, workflow_spades/contigs_assembly_paths,workflow_spades/scaffolds_assembly_paths]
        linkMerge: merge_flattened
        pickValue: all_non_null
    out: [outfile]
#############################################
#### Binning workflow
  workflow_binning:
    label: Binning workflow
    doc: Binning workflow to create bins
    when: $(inputs.binning)
    run: workflow_metagenomics_binning.cwl
    in:
      binning: binning
      identifier: identifier
      assembly: workflow_spades/contigs
      bam_file: workflow_sam_to_sorted_bam/sortedbam
      threads: threads
      memory: memory
      step: 
        default: 1
    out: [metabat2_output,checkm_output,gtdbtk_output]

#############################################
#### Move to folder if not part of a workflow
  spades_files_to_folder:
    doc: Preparation of SPAdes output files to a specific output folder
    label: SPADES output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [compress_spades/outfile, workflow_spades/params, workflow_spades/log, workflow_spades/internal_config, workflow_spades/internal_dataset]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("2_SPAdes_Assembly")
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
        valueFrom: $("3_Quast_AsssemblyQuality_")$(inputs.identifier)
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  sorted_bam_files_to_folder:
    doc: Preparation of mapped reads (sorted bam files) to a specific output folder
    label: Mapped reads output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files: 
        source: [workflow_sam_to_sorted_bam/sortedbam, workflow_bbmap/stats, workflow_contig_read_counts/contigReadCounts, workflow_bbmap/covstats, workflow_bbmap/rpkm, workflow_bbmap/log]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("4_BBMAP_ReadMapping")
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  binning_files_to_folder:
    doc: Preparation of quast output files to a specific output folder
    label: Binning output folder
    when: $(inputs.binning)
    run: ../expressions/files_to_folder.cwl
    in:
      binning: binning
      folders:
        source: [workflow_binning/metabat2_output,workflow_binning/checkm_output,workflow_binning/gtdbtk_output]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("5_Binning")
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
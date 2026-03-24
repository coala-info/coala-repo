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
          - kraken2 (taxonomy)
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
  kraken2_output:
    label: Kraken2 reports
    doc: Kraken2 taxonomic classification reports
    type: Directory
    outputSource: kraken2_files_to_folder/results
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
    type: Directory?
    outputSource: sorted_bam_files_to_folder/results
  binning_output:
    label: Binning output
    doc: Binning outputfolders
    type: Directory?
    outputSource: binning_files_to_folder/results

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  illumina_forward_reads:
    type: string[]
    doc: forward sequence file path
    label: forward reads
  illumina_reverse_reads:
    type: string[]
    doc: reverse sequence file path
    label: reverse reads
  pacbio_reads:
    type: File[]?
    doc: file with PacBio reads locally
    label: pacbio reads
  nanopore_reads:
    type: File[]?
    doc: file with PacBio reads locally
    label: pacbio reads
  filter_references:
    type: string[]
    doc: bbmap reference fasta file paths for contamination filtering
    label: contamination reference file
  use_reference_mapped_reads:
    type: boolean
    doc: Continue with reads mapped to the given reference
    label: Keep mapped reads
    default: false
  deduplicate:
    type: boolean?
    doc: Remove exact duplicate reads with fastp
    label: Deduplicate reads
    default: false
  kraken_database:
    type: string
    doc: Absolute path with database location of kraken2
    label: Kraken2 database
    default: "/unlock/references/databases/Kraken2/K2_PlusPF_20210517"

  binning:
    type: boolean?
    label: Run binning workflow
    doc: Run with contig binning workflow
    default: true
  # There are some issues with the --tmpdir-prefix option in cwltool and the gtdbtk tool
  run_gtdbtk:
    type: boolean
    label: Run GTDB-Tk
    doc: Run GTDB-Tk taxonomic bin classification when true
    default: false

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
      forward_reads: illumina_forward_reads
      reverse_reads: illumina_reverse_reads
      filter_references: filter_references
      keep_reference_mapped_reads: use_reference_mapped_reads
      deduplicate: deduplicate
      memory: memory
      threads: threads
      identifier: identifier
      step:
        default: 1
    out: [QC_reverse_reads, QC_forward_reads, reports_folder]

#############################################
#### Kraken2
  kraken2:
    label: Taxonomic classification with Kraken2
    doc: Taxonomic classification of unfiltered FASTQ reads
    run: ../kraken2/kraken2.cwl
    in:
      tmp_id: identifier
      identifier: 
        valueFrom: $(inputs.tmp_id)_illumina_filtered
      threads: threads
      database: kraken_database
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
      paired_end: 
        default: true
    out: [standard_report, sample_report]

  kraken2_compress:
    run: ../bash/pigz.cwl
    in:
      inputfile: kraken2/standard_report
      threads: threads
    out: [outfile]

  kraken2_krona:
    label: taxonomic classification visualization
    doc: visualization of taxonomic classification with Krona
    run: ../krona/krona.cwl
    in:
      kraken: kraken2/sample_report
    out: [krona_html]

#############################################
#### Assembly using SPADES
  spades:
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
      nanopore_reads: nanopore_reads
      metagenomics:
        default: true
      memory: memory
      threads: threads
    out: [contigs, scaffolds, assembly_graph, contigs_assembly_paths, scaffolds_assembly_paths, contigs_before_rr, params, log, internal_config, internal_dataset]
#############################################
#### Assembly quality assessment using quast
  quast:
    doc: Genome assembly quality assessment using Quast
    label: Quast workflow
    run: ../quast/quast.cwl
    in:
      assembly: spades/contigs
    out: [basicStats, icarusDir, icarusHtml, quastReport, quastLog, transposedReport]
#############################################
#### Read mapping using BBmap
  bbmap:
    label: BBmap read mapping
    doc: Illumina read mapping using BBmap on assembled contigs
    run: ../bbmap/bbmap.cwl
    in:
      identifier: identifier
      reference: spades/contigs
      forward_reads: workflow_quality/QC_forward_reads
      reverse_reads: workflow_quality/QC_reverse_reads
      memory: memory
    out: [sam, stats, covstats, log]
#############################################
#### Convert sam file to sorted bam
  sam_to_sorted_bam:
    label: sam conversion to sorted bam
    doc: Sam file conversion to a sorted indexed bam file
    run: ../samtools/sam_to_sorted-bam.cwl
    in:
      identifier: identifier
      sam: bbmap/sam
      threads: threads
    out: [sortedbam]
#############################################
#### reports per contig alignment statistics
  contig_read_counts:
    label: samtools idxstats
    doc: Reports alignment summary statistics
    run: ../samtools/samtools_idxstats.cwl
    in:
      identifier: identifier
      bam_file: sam_to_sorted_bam/sortedbam
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
        source: [spades/contigs, spades/scaffolds,spades/assembly_graph,spades/contigs_before_rr, spades/contigs_assembly_paths,spades/scaffolds_assembly_paths]
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
      assembly: spades/contigs
      bam_file: sam_to_sorted_bam/sortedbam
      threads: threads
      memory: memory
      run_gtdbtk: run_gtdbtk
      step: 
        default: 1
    out: [metabat2_output,checkm_output,gtdbtk_output,busco_output]

#############################################    
#### Move to folder if not part of a workflow
  kraken2_files_to_folder:
    doc: Preparation of Kraken2 output files to a specific output folder
    label: Kraken2 output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [kraken2_compress/outfile, kraken2_krona/krona_html, kraken2/sample_report]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("2_Kraken2_classification")
    out:
      [results]
#############################################
#### Move to folder if not part of a workflow
  spades_files_to_folder:
    doc: Preparation of SPAdes output files to a specific output folder
    label: SPADES output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [compress_spades/outfile, spades/params, spades/log, spades/internal_config, spades/internal_dataset]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("3_SPAdes_Assembly")
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
        source: [quast/quastLog, quast/icarusHtml, quast/quastReport, quast/transposedReport]
        linkMerge: merge_flattened
      folders:
        source: [quast/basicStats, quast/icarusDir]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("4_Quast_AsssemblyQuality_")$(inputs.identifier)
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
        source: [sam_to_sorted_bam/sortedbam, bbmap/stats, contig_read_counts/contigReadCounts, bbmap/covstats, bbmap/log]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("5_BBMAP_ReadMapping")
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
        source: [workflow_binning/metabat2_output,workflow_binning/checkm_output, workflow_binning/gtdbtk_output, workflow_binning/busco_output]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("6_Binning")
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
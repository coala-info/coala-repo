#!/usr/bin/env cwltool
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Nanopore assembly workflow
doc: |
  **Workflow for sequencing with ONT Nanopore data, from basecalled reads to (meta)assembly and binning**<br>
    - Workflow Nanopore Quality
    - Kraken2 taxonomic classification of FASTQ reads
    - Flye (de-novo assembly)
    - Medaka (assembly polishing)
    - metaQUAST (assembly quality reports)

  **When Illumina reads are provided:** 
    - Workflow Illumina Quality: https://workflowhub.eu/workflows/336?version=1	
    - Assembly polishing with Pilon<br>
    - Workflow binnning https://workflowhub.eu/workflows/64?version=11
        - Metabat2
        - CheckM
        - BUSCO
        - GTDB-Tk

  **All tool CWL files and other workflows can be found here:**<br>
    Tools: https://git.wur.nl/unlock/cwl/-/tree/master/cwl<br>
    Workflows: https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows<br>

  The dependencies are either accessible from https://unlock-icat.irods.surfsara.nl (anonymous,anonymous)<br>
  and/or<br>
  By using the conda / pip environments as shown in https://git.wur.nl/unlock/docker/-/blob/master/kubernetes/scripts/setup.sh<br>

outputs:
  nanopore_quality_output:
    label: Read quality and filtering reports
    doc: Quality reports
    type: Directory
    outputSource: workflow_quality_nanopore/reports_folder
  illumina_quality_stats:
    label: Filtered statistics
    doc: Statistics on quality and preprocessing of the reads
    type: Directory
    outputSource: workflow_quality_illumina/reports_folder
  kraken2_output:
    label: Kraken2 reports
    doc: Kraken2 taxonomic classification reports
    type: Directory
    outputSource: kraken2_files_to_folder/results
  assembly_output:
    label: Assembly output
    doc: Output from different assembly steps
    type: Directory
    outputSource: assembly_files_to_folder/results

  binning_output:
    label: Binning output
    doc: Binning outputfolders
    type: Directory
    outputSource: binning_files_to_folder/results

inputs:
  # General
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: Identifier used
  threads:
    type: int?
    doc: Number of threads to use for computational processes
    label: Number of threads
  memory:
    type: int?
    doc: Maximum memory usage in megabytes
    label: Maximum memory in MB
    default: 40000
  nanopore_fastq_files:
    type: string[]?
    doc: List of file paths with Nanopore raw reads in fastq format
    label: Nanopore reads
  nanopore_fastq_reads:
    type: File[]?
    doc: File(s) of FASTQ reads in gzip format
    label: Nanopore FASTQ reads
  illumina_forward_reads:
    type: string[]?
    doc: illumina sequenced forward read file
    label: illumina forward reads
  illumina_reverse_reads:
    type: string[]?
    doc: illumina sequenced reverse file
    label: illumina reverse reads
  use_reference_mapped_reads:
    type: boolean
    doc: Continue with reads mapped to the given reference
    label: Use mapped reads
    default: false
  deduplicate:
    type: boolean?
    doc: Remove exact duplicate reads (Illumina) with fastp 
    label: Deduplicate reads
    default: false

  kraken_database:
    type: string
    doc: Absolute path with database location of kraken2
    label: Kraken2 database
    default: "/unlock/references/databases/Kraken2/K2_PlusPF_20210517"
  # Medaka
  basecall_model:
    type: string
    doc: Basecalling model used with Guppy
    label: Basecalling model
  # bam_workers:
    # type: int
    # doc: number of workers for bam
    # label: number of workers
  
  # Flye
  metagenome:
    type: boolean?
    default: true
    doc: Metagenome option for the flye assembly
    label: When working with metagenomes
  # Filtering
  filter_references:
    type: string[]
    doc: Reference fasta file(s) for contamination filtering
    label: Contamination reference file(s)
  pilon_fixlist:
    type: string
    label: Pilon fix list
    doc: A comma-separated list of categories of issues to try to fix
    default: "snps,gaps,local"

  binning:
    type: boolean?
    label: Run binning workflow
    doc: Run with contig binning workflow
    default: false

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
#############################################
#### Quality Nanopore
  workflow_quality_nanopore:
    label: Nanopore quality and filtering workflow
    doc: Quality and filtering workflow for nanopore reads
    run: workflow_nanopore_quality.cwl
    in:
      reads: nanopore_fastq_files
      filter_references: filter_references
      keep_reference_mapped_reads: use_reference_mapped_reads
      threads: threads
      identifier: identifier
      step: 
        default: 1
    out: [filtered_reads, reports_folder]
#############################################
#### Quality Illumina
  workflow_quality_illumina:
    label: Illumina quality and filtering workflow
    doc: Quality and filtering workflow for illumina reads
    when: $(inputs.binning)
    run: workflow_illumina_quality.cwl
    in:
      binning: binning
      forward_reads: illumina_forward_reads
      reverse_reads: illumina_reverse_reads
      filter_references: filter_references
      deduplicate: deduplicate
      keep_reference_mapped_reads: use_reference_mapped_reads
      memory: memory
      threads: threads
      identifier: identifier
      step: 
        default: 2
    out: [QC_reverse_reads, QC_forward_reads, reports_folder]
#############################################
#### Taxonomic classification of with Kraken2
  nanopore_kraken2:
    label: Kraken2 Nanopore
    doc: Taxonomic classification of Nanopore reads
    run: ../kraken2/kraken2.cwl
    in:
      tmp_id: identifier
      identifier: 
        valueFrom: $(inputs.tmp_id)_filtered_nanopore
      threads: threads
      nanopore: workflow_quality_nanopore/filtered_reads
      database: kraken_database
    out: [standard_report, sample_report]

  illumina_kraken2:
    label: Kraken2 Illumina
    doc: Taxonomic classification of FASTQ reads
    when: $(inputs.binning)
    run: ../kraken2/kraken2.cwl
    in:
      binning: binning
      tmp_id: identifier
      identifier: 
        valueFrom: $(inputs.tmp_id)_filtered_illumina
      threads: threads
      database: kraken_database
      forward_reads: workflow_quality_illumina/QC_forward_reads
      reverse_reads: workflow_quality_illumina/QC_forward_reads
      paired_end: 
        default: true
    out: [standard_report, sample_report]

  kraken2_compress:
    run: ../bash/pigz.cwl
    label: Compress kraken2
    doc: Compress large kraken2 report file 
    scatter: inputfile
    in:
      inputfile: [nanopore_kraken2/standard_report, illumina_kraken2/standard_report]
      threads: threads
    out: [outfile]

  kraken2_krona:
    label: Krona Kraken2
    doc: Visualization of kraken2 with Krona
    run: ../krona/krona.cwl
    scatter: kraken
    in:
      kraken: [nanopore_kraken2/sample_report, illumina_kraken2/sample_report]
    out: [krona_html]

#############################################
#### De novo assembly with Flye
  flye:
    label: Nanopore Flye assembly
    doc: De novo assembly of single-molecule reads with Flye
    run: ../flye/flye.cwl
    in:
      nano_raw: workflow_quality_nanopore/filtered_reads
      threads: threads
      metagenome: metagenome
    out: [00_assembly, 10_consensus, 20_repeat, 30_contigger, 40_polishing, assembly, assembly_info, flye_log, params]
#############################################
#### Polishing of assembled genome with Medaka
  medaka:
    label: Medaka polishing of assembly
    doc: Medaka for polishing of assembled genome
    run: ../medaka/medaka_py.cwl
    in:
      threads: threads
      draft_assembly: flye/assembly
      reads: workflow_quality_nanopore/filtered_reads
      basecall_model: basecall_model
    out: [polished_assembly, gaps_in_draft_coords] # probs, calls_to_draft
#############################################
#### Assembly evaluation with QUAST
  metaquast_medaka:
    label: assembly evaluation
    doc: evaluation of polished assembly with metaQUAST
    run: ../metaquast/metaquast.cwl
    in:
      assembly: medaka/polished_assembly
    out: [metaquast_outdir, meta_combined_ref, meta_icarusDir, metaquast_krona, not_aligned, meta_downloaded_ref, runs_per_reference, meta_summary, meta_icarus, metaquast_log, metaquast_report, basicStats, quast_icarusDir, quast_icarusHtml, quastReport, quastLog, transposedReport]

#############################################
#### Workflow Pilon assembly polishing
  workflow_pilon:
    label: Pilon worklow
    doc: Illumina reads assembly polishing with Pilon
    when: $(inputs.binning)
    run: workflow_pilon_mapping.cwl
    in:
      binning: binning
      identifier: identifier
      assembly: medaka/polished_assembly
      illumina_forward_reads: workflow_quality_illumina/QC_forward_reads
      illumina_reverse_reads: workflow_quality_illumina/QC_reverse_reads
      fixlist: pilon_fixlist
      threads: threads
      memory: memory
    out: [pilon_polished_assembly, vcf, log]

#############################################
#### Assembly evaluation with QUAST
  metaquast_nanopore_pilon:
    label: Illumina assembly evaluation
    doc: Illumina evaluation of pilon polished assembly with metaQUAST
    when: $(inputs.binning)
    run: ../metaquast/metaquast.cwl
    in:
      binning: binning
      assembly: workflow_pilon/pilon_polished_assembly
    out: [metaquast_outdir, meta_combined_ref, meta_icarusDir, metaquast_krona, not_aligned, meta_downloaded_ref, runs_per_reference, meta_summary, meta_icarus, metaquast_log, metaquast_report, basicStats, quast_icarusDir, quast_icarusHtml, quastReport, quastLog, transposedReport]

#############################################
#### BBmap read mapping (illumina reads) for binning
  illumina_pilon_readmapping:
    label: Read mapping
    doc: Illumina read mapping on pilon assembly for binning
    when: $(inputs.binning)
    run: ../bbmap/bbmap.cwl
    in:
      binning: binning
      identifier: identifier
      reference: workflow_pilon/pilon_polished_assembly
      forward_reads: workflow_quality_illumina/QC_forward_reads
      reverse_reads: workflow_quality_illumina/QC_reverse_reads
      threads: threads
      memory: memory
    out: [sam, stats, covstats, log]
#############################################
#### Convert sam file to sorted bam
  illumina_pilon_sam_to_sorted_bam:
    label: sam conversion to sorted bam
    doc: Sam file conversion to a sorted bam file
    when: $(inputs.binning)
    run: ../samtools/sam_to_sorted-bam.cwl
    in:
      binning: binning
      identifier: identifier
      sam: illumina_pilon_readmapping/sam
      threads: threads
    out: [sortedbam]

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
      assembly: workflow_pilon/pilon_polished_assembly
      bam_file: illumina_pilon_sam_to_sorted_bam/sortedbam
      threads: threads
      step: 
        default: 1
    out: [metabat2_output, checkm_output, gtdbtk_output, busco_output, bins_summary]

#############################################    
#### Move to folder if not part of a workflow
  kraken2_files_to_folder:
    doc: Preparation of Kraken2 output files to a specific output folder
    label: Kraken2 output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [kraken2_compress/outfile, kraken2_krona/krona_html, nanopore_kraken2/sample_report, illumina_kraken2/sample_report]
        linkMerge: merge_flattened
      destination:
        valueFrom: $("2_Kraken2_classification")
    out:
      [results]

#############################################
#### Move to folder if not part of a workflow
  flye_files_to_folder:
    doc: Preparation of Flye output files to a specific output folder
    label: Flye output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [flye/assembly, flye/assembly_info, flye/flye_log, flye/params]
        linkMerge: merge_flattened
      # folders:
        # source: [workflow_flye/00_assembly, workflow_flye/10_consensus, workflow_flye/20_repeat, workflow_flye/30_contigger, workflow_flye/40_polishing]
        # linkMerge: merge_flattened
      destination:
        valueFrom: $("1_Fly_Assembly")
    out:
      [results]

#############################################
#### Move to folder if not part of a workflow
  metaquast_medaka_files_to_folder:
    doc: Preparation of metaQUAST output files to a specific output folder
    label: Nanopore metaQUAST output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files: 
        source: [metaquast_medaka/metaquast_report, metaquast_medaka/quastReport]
        linkMerge: merge_flattened
        pickValue: all_non_null
      folders:
        source: [metaquast_medaka/metaquast_krona, metaquast_medaka/not_aligned, metaquast_medaka/runs_per_reference]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("QUAST_Nanopore_assembly_quality")
    out:
      [results]

#############################################
#### Move to folder if not part of a workflow
  medaka_files_to_folder:
    doc: Preparation of Medaka output files to a specific output folder
    label: Medaka output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [medaka/polished_assembly, medaka/gaps_in_draft_coords] # , workflow_medaka/probs, workflow_medaka/calls_to_draft
        linkMerge: merge_flattened
        pickValue: all_non_null
      folders:
        source: [metaquast_medaka_files_to_folder/results]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("2_Nanopore_assembly_polishing")
    out:
      [results]

#############################################
#### Move to folder if not part of a workflow
  metaquast_pilon_files_to_folder:
    doc: Preparation of QUAST output files to a specific output folder
    label: Illumina metaQUAST output folder
    when: $(inputs.binning)
    run: ../expressions/files_to_folder.cwl
    in:
      binning: binning
      files: 
        source: [metaquast_nanopore_pilon/metaquast_report, metaquast_nanopore_pilon/quastReport]
        linkMerge: merge_flattened
        pickValue: all_non_null
      folders:
        source: [metaquast_nanopore_pilon/metaquast_krona, metaquast_nanopore_pilon/not_aligned]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("QUAST_Illumina_polished_assembly_quality")
    out:
      [results]

#############################################
#### Move to folder if not part of a workflow
  pilon_files_to_folder:
    doc: Preparation of pilon output files to a specific output folder
    label: Pilon output folder
    when: $(inputs.binning)
    run: ../expressions/files_to_folder.cwl
    in:
      binning: binning
      files: 
        source: [workflow_pilon/vcf, workflow_pilon/pilon_polished_assembly, workflow_pilon/log]
        linkMerge: merge_flattened
        pickValue: all_non_null
      folders:
        source: [metaquast_pilon_files_to_folder/results]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("3_Illumina_polished_assembly")
    out:
      [results]
  
#############################################
#### Move to folder if not part of a workflow
  assembly_files_to_folder:
    doc: Preparation of Flye output files to a specific output folder
    label: Flye output folder
    run: ../expressions/files_to_folder.cwl
    in:
      folders:
        source: [flye_files_to_folder/results, medaka_files_to_folder/results, pilon_files_to_folder/results]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("3_Assembly")
    out:
      [results]

#### Move to folder if not part of a workflow
  binning_files_to_folder:
    doc: Preparation of quast output files to a specific output folder
    label: Binning output folder
    when: $(inputs.binning)
    run: ../expressions/files_to_folder.cwl
    in:
      binning: binning
      files: 
        source: [workflow_binning/bins_summary]
        linkMerge: merge_flattened
        pickValue: all_non_null
      folders:
        source: [workflow_binning/metabat2_output, workflow_binning/checkm_output, workflow_binning/gtdbtk_output, workflow_binning/busco_output]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        valueFrom: $("4_Binning")
    out:
      [results]
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
s:dateCreated: "2021-12-23"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
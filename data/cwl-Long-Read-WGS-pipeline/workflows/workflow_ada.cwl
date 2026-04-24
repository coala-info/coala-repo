#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

label: Long Read WGS pipeline
doc: |
  **Workflow for long read quality control, contamination filtering, assembly, variant calling and annotation.**
  - Preprocessing of reference file
  - LongReadSum before and after filtering (read quality control)
  - Filtlong filter on quality and length 
  - Flye assembly
  - Minimap2 mapping of reads and assembly
  - Clair3 variant calling of reads
  - Freebayes variant calling of assembly
  - Optional Bakta annotation of genomes with no reference
  - SnpEff building or downloading of a database
  - SnpEff functional annotation
  - Liftoff annotation lift over

  This workflow on WorkflowHub: https://workflowhub.eu/workflows/1868

  **All tool CWL files and other workflows can be found here:**
    Tools: https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/tools
    Workflows: https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/workflows

inputs:
  input_read:
    type: File
    label: long reads input
    doc: Long read sequence file in FASTQ format.
  sample_name:
    type: string?
    label: sample name
    doc: Sample name, by default is extracted from the file input. Used as output names for LongReadSum, Filtlong, and minimap2.
  reference_gb:
    type: File?
    label: reference GenBank file
    doc: Reference file in GenBank format. If not provided requires NCBI identifier.   
  plasmids:
    type: File[]?
    label: plasmid file(s)
    doc: Input plasmid GenBank files, which will be merged with the reference.
    
# Settings about which tools to use 
  skip_qc_unfiltered:
    type: boolean?
    label: skip LongReadSum before filtering
    doc: Skip LongReadSum analyses of unfiltered input data, default is false.
  skip_qc_filtered:
    type: boolean?
    label: skip LongReadSum after filtering
    doc: Skip LongReadSum analyses of filter input data, default is false.
  include_reads:
    type: boolean
    label: include filtered reads
    doc:  Will include mapping and variant calling filtered reads in the pipeline, default is true.
  include_assembly:
    type: boolean
    label: include assembly
    doc:  Will include mapping and variant calling an assembly in the pipeline, default is true.
  include_strainy:
    type: boolean
    label: include strainy
    doc:  Will include strain level analysis on the filtered reads, default is false.
  include_snpeff:
    type: boolean
    label: include SnpEff
    doc:  Will include functional interpretation of variants with SnpEff in the pipeline, default is true.
  snpeff_database_exists:
    type: boolean?
    label: existing SnpEff database
    doc: The used genome has an existing database within SnpEff, instead of building a database, the existing database will be downloaded, default is false.
  ncbi_data_exists:
    type: boolean?
    label: existing NCBI data
    doc: The used genome has an existing NCBI identifier, instead of annotating genes, the genbank file from NCBI will be used to build a database.
  transfer_annotation:
    type: boolean?
    label: transfer annotation
    doc: Whether the annotation of the reference should be carried over to the new assembly (use Liftoff), default is false.

# Tool settings
# LongReadSum parameters
  input_type:
    type:
      - type: enum
        symbols: [fa, fq, f5, f5s, seqtxt, bam, rrms]
    label: input file type
    doc: |
      Acceptable input types:
        fa      FASTA file input
        fq      FASTQ file input
        f5      FAST5 file input
        f5s     FAST5 file input with signal statistics output
        seqtxt  sequencing_summary.txt input
        bam     BAM file input
        rrms    RRMS BAM file input
      Defaults to FQ file in this workflow.
  log_level:
    type: int?
    label: level of logging
    doc: "Logging level (1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL), defaults to 2."
  seed:
    type: int?
    label: random seed
    doc: |
      Sets the random seed for reproducability. 
      Using the same seed number for random seed.
      Default is set to 1.
# Filtlong parameters, defaults taken from nf-core MAG
  target_bases:
    type: int?
    label: target bases
    doc: Keep only the best reads up to this many total bases.
  keep_percent:
    type: float?
    label: Maximum read length threshold
    doc: Maximum read length threshold (default 90).
  minimum_length:
    type: int?
    label: Minimum read length
    doc: Minimum read length threshold (default 1000).
  maximum_length:
    type: int?
    label: maximum length
    doc: Maximum read length threshold.
  length_weight:
    type: float?
    label: Length weigth
    doc: Weight given to the length score (default 10).
  min_mean_q:
    type: float?
    label: minimum mean quality
    doc: Minimum mean quality threshold.
  min_window_q:
    type: float?
    label: minimum window quality
    doc: Minimum window quality threshold.
# Deeptools settings
  file_format:
    type: 
      - type: enum
        symbols: [ bigwig, bedgraph ]
    label: input file type
    doc: Input file type. Possible choices are bigwig or bedgraph. Defaults to bigwig in this workflow.
# Clair3 parameters
  model_path:
    type: string
    label: Clair3 Model Directory
    doc: Path to the Clair3 model inside the Docker container.
  haploid_sensitive:
    type: boolean?
    label: haploid calling mode
    doc: Set to true to enable haploid calling mode, this is an experimental flag.
  no_phasing_for_fa: # as of now (07/05/25), this flag breaks the pipeline in downstream steps
    type: boolean?
    label: no phasing in full alignment
    doc: Set to true to skip whatshap phasing in full alignment, this is an experimental flag.
# Flye parameters
  genome_size:
    type: string?
    label: Genome size
    doc: Estimated genome size (for example, 5m or 2.6g).
  coverage_threshold:
    type: int?
    label: assembly coverage
    doc: |
      Reduced coverage for the initial disjointig assembly. 
      If set, Flye will downsample the reads to the specified coverage before assembly.
      Useful for high-coverage datasets to reduce memory usage. 
      If not set, Flye will use all available reads.
# freebayes parameters
  ploidy:
    type: int?
    label: ploidy settings
    doc: Settings of the ploidy, for haploid organisms, set to 1 (default).
  min_alt_count:
    type: int?
    label: min_alt_count
    doc: Require at least this count of observations supporting an alternate allele. Defaults to 1 in this pipeline.
# Bakta parameters
  bakta_db:
    type: Directory?
    label: Bakta DB
    doc: Bakta database directory (default bakta-db_v5.1-light built in the container).
# SnpEff parameters
  snpeff_genome:
    type: string?
    label: genome/database identifier
    doc: | 
      Identifier for the SnpEff database to download or build (e.g. 'GRCh37.75' for human, or a custom name for microbial strains). 
  NCBI_identifier:
    type: string?
    label: NCBI genome identifier
    doc: | 
      NCBI Identifier of a genome for SnpEff to extract a genbank file and build a custom database out of. 
  no_upstream:
    type: boolean?
    label: no upstream changes
    doc: Set to true to omit upstream changes.
  no_downstream:
    type: boolean?
    label: no downstream changes
    doc: Set to true to omit downstream changes.
# Liftoff inputs
  annotation_file:
    type: File?
    label: annotation file to lift over
    doc: GFF or GTF file containing the annotations to lift over.
# Merging script
  merging_script:
    type: File?
    label: merging script
    doc: Python script that merges input from both Clair3 and freebayes. Passed externally within the git structure to avoid having to host a new python docker.
      class: File
      path: ../tools/scripts/combine_variant_calling.py
  
# Pipeline settings
  threads:
    type: int?
    doc: Number of threads to use for computational processes.
    label: Number of threads
  provenance:
    type: boolean
    label: include provenance information
    doc:  Will include metadata on tool performance of LongReadSum, Filtlong, and Flye, default is true.

# Dummy files, only used to prevent pipeline crashes before evaluation of conditionals, will never actually parse so actual file / folder is irrelevant.
  dummy_annotation_file:
    type: File?
      class: File
      path: ../tools/scripts/combine_variant_calling.py
  dummy_database_folder:
    type: Directory?
      class: Directory
      path: ../tools/scripts

steps:
#############################################
#### Preprocessing reference
  preprocess_reference:
    label: plasmid preprocessing
    doc: Pre-processing of reference, merging reference with optional plasmid input and extracting GenBank, GFF3 and FASTA files.
    run: workflow_preprocess_reference.cwl
    when: $(inputs.reference_gb !== null || inputs.NCBI_identifier !== null)
    in:
      reference_gb: reference_gb
      NCBI_identifier: NCBI_identifier
      reference_file: reference_gb
      plasmids: plasmids
      accession_number: NCBI_identifier
    out: [ genbank_final, fasta_final, gff3 ]
#############################################
#### Quality Control before filtering with LongReadSum
  longreadsum_unfiltered:
    label: LongReadSum unfiltered
    doc: LongReadSum Quality assessment of reads prior to filtering.
    run: ../tools/longreadsum/longreadsum.cwl
    when: $(inputs.skip_longreadsum_unfiltered == false)
    in:
      skip_longreadsum_unfiltered: skip_qc_unfiltered
      input_type: input_type
      single_read_input: input_read
      log_level: log_level
      seed: seed
      sample_name: sample_name
      outputfolder: 
        valueFrom: "longreadsum_unfiltered_output"
      log_file:
        valueFrom: "longreadsum_unfiltered.log"
      threads: threads
      outprefix:
        valueFrom: |
          ${
            var name = inputs.sample_name || inputs.single_read_input.nameroot;
            return name + "_unfiltered_";
          }
    out: [ longreadsum_outdir, log_file_out ]
#############################################
#### Filtering with Filtlong 
  filtlong:
    label: long read filtering
    doc: Filter long reads based on set parameters.
    run: ../tools/filtlong/filtlong.cwl
    in:
      sample_name: sample_name
      long_reads: input_read
      output_filename:
        valueFrom: |
          ${
            var name = inputs.sample_name || inputs.long_reads.nameroot;
            return name;
          }
      minimum_length: minimum_length
      keep_percent: keep_percent
      length_weight: length_weight
      target_bases: target_bases
      maximum_length: maximum_length
      min_mean_q: min_mean_q
      min_window_q: min_window_q
    out: [ output_reads, log]
#############################################
#### Quality Control after filtering with LongReadSum
  longreadsum_filtered:
    label: LongReadSum filtered
    doc: LongReadSum Quality assessment of reads after filtering.
    run: ../tools/longreadsum/longreadsum.cwl
    when: $(inputs.skip_longreadsum_filtered == false)
    in:
      skip_longreadsum_filtered: skip_qc_filtered
      input_type: input_type
      single_read_input: filtlong/output_reads
      log_level: log_level
      seed: seed
      sample_name: sample_name
      outputfolder: 
        valueFrom: "longreadsum_filtered_output"
      log_file:
        valueFrom: "longreadsum_filtered.log"
      threads: threads
      outprefix:
        valueFrom: |
          ${
            var name = inputs.sample_name || inputs.single_read_input.nameroot;
            return name + "_filtered_";
          }
    out: [ longreadsum_outdir, log_file_out ]
#############################################
#### Reads mapping with Minimap2
  minimap2_reads:
    label: Minimap2 read mapping
    doc: Read mapping of filtered reads using Minimap2.
    when: $(inputs.include_reads == true)
    run: ../tools/minimap2/minimap2_to_sorted-bam.cwl
    in:
      include_reads: include_reads
      threads: threads
      input_read: input_read
      identifier: 
        valueFrom: |
          ${
            var base = inputs.sample_name || inputs.input_read.nameroot;
            return base + "_reads";
          }
      reference: preprocess_reference/fasta_final
      reads: filtlong/output_reads
      preset:
        valueFrom: "map-ont"
    out: [bam]
#############################################
#### Indexing reads BAM file with samtools index
  samtools_reads_index:
    label: samtools index reads
    doc: Indexing of reads BAM file with samtools index.
    when: $(inputs.include_reads == true)
    run: ../tools/samtools/samtools_index.cwl
    in:
      include_reads: include_reads
      bam_file: minimap2_reads/bam
      threads: threads
    out: [bam_index]
#############################################
#### Generating coverage track with deeptools bamCoverage
  deeptools_bamcoverage:
    label: deeptools bamCoverage
    doc: Generating coverage track with deeptools bamCoverage.
    when: $(inputs.include_reads == true)
    run: ../tools/deeptools/deeptools_bamcoverage.cwl
    in:
      include_reads: include_reads
      sequence_alignment: minimap2_reads/bam
      file_format: file_format
      indexed_sequence_alignment: samtools_reads_index/bam_index
    out: [output_file]
#############################################
#### Indexing reference FASTA file with samtools faidx
  samtools_faidx_reads:
    label: samtools faidx
    doc: Indexing of FASTA file with samtools faidx.
    when: $(inputs.include_reads || inputs.include_assembly)
    run: ../tools/samtools/samtools_faidx.cwl
    in:
      include_reads: include_reads
      include_assembly: include_assembly
      fasta_file: preprocess_reference/fasta_final
      threads: threads
    out: [fasta_index]
#############################################
#### Variant calling with Clair3
  clair3:
    label: Clair3 variant calling
    doc: Variant calling of filtered reads with Clair3 using input models.
    when: $(inputs.include_reads == true)
    run: ../tools/clair3/clair3.cwl
    in:
      include_reads: include_reads
      bam_file: minimap2_reads/bam
      reference_file: preprocess_reference/fasta_final
      indexed_bam_file: samtools_reads_index/bam_index
      indexed_fasta_file: samtools_faidx_reads/fasta_index
      threads: threads
      platform:
        valueFrom: "ont"
      model_path: model_path
      haploid_sensitive: haploid_sensitive
      no_phasing_for_fa: no_phasing_for_fa
    out: [ output_dir, merge_output_vcf]
#############################################
#### Strain level analysis with strainy
  strainy:
    label: Strainy strain level analysis
    doc: Strain level analysis on assembled reads. Produces multi-allelic phasing, individual haplotypes and strain-specific variant calls.
    when: $(inputs.include_strainy == true)
    run: ../tools/strainy/strainy.cwl
    in:
      include_strainy: include_strainy
      input_reads: filtlong/output_reads
      #reference_fasta: preprocess_reference/fasta_final use FASTA as input
      reference: flye/assembly_graph # use gfa file
      read_type: 
        valueFrom: "nano"
      threads: threads
    out: [strainy_outdir]
#############################################
#### De novo assembly with Flye
  flye:
    label: Flye assembly
    doc: De novo assembly of single-molecule reads with Flye.
    when: $(inputs.include_assembly == true)
    run: ../tools/flye/flye.cwl
    in:
      include_assembly: include_assembly
      nano_high_quality: filtlong/output_reads
      threads: threads
      genome_size: genome_size
      coverage_threshold: coverage_threshold
    out: [00_assembly, 10_consensus, 20_repeat, 30_contigger, 40_polishing, assembly, assembly_info, flye_log, params, assembly_graph]
#############################################
#### Assembly evaluation with QUAST
  quast:
    label: QUAST quality assessment
    doc: Quality assessment of assembly with QUAST.
    when: $(inputs.include_assembly == true)
    run: ../tools/quast/quast.cwl
    in:
      include_assembly: include_assembly
      assembly: flye/assembly
      reference_genome: preprocess_reference/fasta_final
      threads: threads
    out: [quast_outdir]
#############################################
#### Assembly indexing FASTA file with samtools faidx
  samtools_faidx_assembly:
    label: samtools faidx assembly
    doc: Indexing of FASTA file with samtools faidx.
    when: $(inputs.include_assembly == true)
    run: ../tools/samtools/samtools_faidx.cwl
    in:
      fasta_file: flye/assembly
      threads: threads
    out: [fasta_index]
#############################################
#### Assembly mapping with Minimap2
  minimap2_assembly:
    label: Minimap2 assembly mapping
    doc: Assembly mapping of filtered reads using Minimap2.
    when: $(inputs.include_assembly == true)
    run: ../tools/minimap2/minimap2_to_sorted-bam.cwl
    in:
      include_assembly: include_assembly
      input_read: input_read
      threads: threads
      identifier: 
        valueFrom: |
          ${
            var base = inputs.sample_name || inputs.input_read.nameroot;
            return base + "_assembly";
          }
      reference: preprocess_reference/fasta_final
      reads: flye/assembly
      preset:
        valueFrom: "asm5"
    out: [bam]
#############################################
#### Conversion of BAM file to BED with bedtools bamtobed
  bedtools_bamtobed:
    label: bedtools bamtobed
    doc: Conversion of BAM file to BED with bedtools bamtobed
    when: $(inputs.include_assembly == true)
    run: ../tools/bedtools/bedtools_bamtobed.cwl
    in:
      include_assembly: include_assembly
      sequence_alignment: minimap2_assembly/bam
    out: [bed_file]
#############################################
#### Indexing assembly BAM file with samtools index
  samtools_assembly_index:
    label: samtools index assembly
    doc: Indexing of assembly BAM file with samtools index.
    when: $(inputs.include_assembly == true)
    run: ../tools/samtools/samtools_index.cwl
    in:
      include_assembly: include_assembly
      bam_file: minimap2_assembly/bam
      threads: threads
    out: [bam_index]
#############################################
#### Variant calling with FreeBayes
  freebayes:
    label: FreeBayes variant calling
    doc: Variant calling of assembly with FreeBayes.
    when: $(inputs.include_assembly == true)
    run: ../tools/freebayes/freebayes.cwl
    in:
      include_assembly: include_assembly
      reference_fasta: preprocess_reference/fasta_final
      reference_fasta_index: samtools_faidx_reads/fasta_index
      bam_file: minimap2_assembly/bam
      min_alt_count: min_alt_count
      ploidy: ploidy
    out: [vcf]
#############################################
#### Unzipping Clair3 output
  unzip:
    label: unzipping clair3
    doc: Unzipping Clair3 VCF file.
    when: $(inputs.include_assembly == true && inputs.include_reads == true && inputs.include_snpeff == true)
    run: ../tools/gunzip/gunzip.cwl
    in:
      include_assembly: include_assembly
      include_reads: include_reads
      include_snpeff: include_snpeff
      input_gz: clair3/merge_output_vcf
    out: [unzipped_file]
#############################################
#### Variant merging
  merging_vcfs:
    label: merging vcf files
    doc: Merging the VCF output from Clair3 and freebayes.
    when: $(inputs.include_assembly == true && inputs.include_reads == true && inputs.include_snpeff == true)
    run: ../tools/scripts/combine_variant_calling.cwl
    in:
      include_assembly: include_assembly
      include_reads: include_reads
      include_snpeff: include_snpeff
      script: merging_script
      clair3_vcf: unzip/unzipped_file
      freebayes_vcf: freebayes/vcf
    out: [merged_vcf]
#############################################
#### SnpEff Database downloading
  snpeff_download:
    label: SnpEff database downloading
    doc: Downloading of a SnpEff database based on the genome name within the database.
    when: $(inputs.include_snpeff == true && inputs.snpeff_database_exists == true)
    run: ../tools/snpeff/snpeff_download.cwl
    in:
      include_snpeff: include_snpeff
      snpeff_database_exists: snpeff_database_exists
      genome: snpeff_genome
    out: [database_dir]
#############################################
#### Genome annotation with Bakta
  bakta:
    label: bakta genome annotation
    doc: Bacterial genome annotation, only runs when no reference (genbank file(s) or NCBI identifier) is supplied.
    when: $(inputs.include_snpeff == true && inputs.snpeff_database_exists == false && !inputs.NCBI_identifier && !inputs.reference_gb)
    run: ../tools/bakta/bakta.cwl
    in:
      include_snpeff: include_snpeff
      snpeff_database_exists: snpeff_database_exists
      NCBI_identifier: NCBI_identifier
      reference_gb: reference_gb
      fasta_file:
        source: [flye/assembly, preprocess_reference/fasta_final]
        pickValue: first_non_null
      #fasta_file: flye/assembly
    out: [ output_dir, annotation_gbff ]
#############################################
#### SnpEff Database building
  snpeff_build:
    label: SnpEff database building
    doc: Downloading of a SnpEff database based on the genome name within the database.
    when: $(inputs.include_snpeff === true && inputs.snpeff_database_exists === false && (inputs.include_reads == true || inputs.include_assembly == true))
    run: ../tools/snpeff/snpeff_build.cwl
    in:
      include_snpeff: include_snpeff
      snpeff_database_exists: snpeff_database_exists
      include_reads: include_reads
      include_assembly: include_assembly
      NCBI_identifier: NCBI_identifier
      genbank_file: preprocess_reference/genbank_final
    out: [ database_dir, config_file ]
#############################################
#### SnpEff reads
  snpeff_reads:
    label: SnpEff reads
    doc: Running SnpEff on the reads variant output of Clair3.
    when: $(inputs.include_snpeff == true && inputs.include_reads == true && inputs.include_assembly == false)
    run: ../tools/snpeff/snpeff.cwl
    in:
      include_snpeff: include_snpeff
      include_reads: include_reads
      include_assembly: include_assembly
      no_upstream: no_upstream
      no_downstream: no_downstream
      genome:
        source: [NCBI_identifier, snpeff_genome]
        pickValue: first_non_null
      database_dir:
        source: [snpeff_download/database_dir, snpeff_build/database_dir, dummy_database_folder]
        pickValue: first_non_null
      variants: clair3/merge_output_vcf
      config_file: snpeff_build/config_file
    out: [ annotated_vcf, summary_report, summary_report_csv, fasta_prot_file ]
#############################################
#### SNPEff assembly
  snpeff_assembly:
    label: SnpEff assembly
    doc: Running SnpEff on the assembly variant output of freebayes.
    when: $(inputs.include_snpeff == true && inputs.include_assembly == true && inputs.include_reads == false)
    run: ../tools/snpeff/snpeff.cwl
    in:
      include_snpeff: include_snpeff
      include_assembly: include_assembly
      include_reads: include_reads
      genome:
        source: [NCBI_identifier, snpeff_genome]
        pickValue: first_non_null
      database_dir:
        source: [snpeff_download/database_dir, snpeff_build/database_dir, dummy_database_folder]
        pickValue: first_non_null
      variants: freebayes/vcf
      config_file: snpeff_build/config_file
    out: [ annotated_vcf, summary_report, summary_report_csv, fasta_prot_file ]
#############################################
#### SNPEff merged
  snpeff_merged:
    label: SnpEff merged
    doc: Running SnpEff on the merged variant output of both Clair3 and freebayes.
    when: $(inputs.include_snpeff == true && inputs.include_assembly == true && inputs.include_reads == true)
    run: ../tools/snpeff/snpeff.cwl
    in:
      include_snpeff: include_snpeff
      include_assembly: include_assembly
      include_reads: include_reads
      genome:
        source: [NCBI_identifier, snpeff_genome]
        pickValue: first_non_null
      database_dir:
        source: [snpeff_download/database_dir, snpeff_build/database_dir, dummy_database_folder]
        pickValue: first_non_null
      variants: merging_vcfs/merged_vcf
      config_file: snpeff_build/config_file
    out: [ annotated_vcf, summary_report, summary_report_csv, fasta_prot_file ]
#############################################
#### Liftoff annotation lift over
  liftoff:
    label: Liftoff annotation lift over
    doc: Lifting over annotations from reference to assembly.
    when: $(inputs.include_assembly === true && inputs.transfer_annotation === true)
    run: ../tools/liftoff/liftoff.cwl
    in:
      include_assembly: include_assembly
      transfer_annotation: transfer_annotation
      target_genome: flye/assembly
      reference_genome: preprocess_reference/fasta_final
      annotation_file: 
        source: [annotation_file, preprocess_reference/gff3, dummy_annotation_file]
        pickValue: first_non_null
      parallel_processes: threads
    out: [ output_gff, unmapped_features_out, intermediate_dir_out]
#############################################
#### Prepare output
  filtlong_files_to_folder:
    label: Filtlong folder
    doc: Preparation of Filtlong output files to a specific output folder.
    in:
      files:
        source: [ filtlong/output_reads, filtlong/log ]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
    run: ../tools/expressions/files_to_folder.cwl
    out:
      [results]
  flye_files_to_folder:
    label: Flye output folder
    doc: Preparation of Flye output files to a specific output folder.
    when: $(inputs.include_assembly == true)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      include_assembly: include_assembly
      files:
        source: [ flye/assembly, flye/assembly_info, flye/params, flye/assembly_graph ]
        linkMerge: merge_flattened
        pickValue: all_non_null
      # folders:
        # source: [workflow_flye/00_assembly, workflow_flye/10_consensus, workflow_flye/20_repeat, workflow_flye/30_contigger, workflow_flye/40_polishing]
        # linkMerge: merge_flattened
      destination:
    out:
      [results]
  snpeff_reads_files_to_folder:
    label: SnpEff reads output folder
    doc: Preparation of SnpEff reads output files to a specific output folder.
    when: $(inputs.include_reads == true && inputs.include_assembly == false)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      include_reads: include_reads
      include_assembly: include_assembly
      files:
        source: [ snpeff_reads/annotated_vcf, snpeff_reads/summary_report, snpeff_reads/summary_report_csv, snpeff_reads/fasta_prot_file ]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
    out:
      [results]
  snpeff_assembly_files_to_folder:
    label: SnpEff assembly output folder
    doc: Preparation of SnpEff assembly output files to a specific output folder.
    when: $(inputs.include_assembly == true && inputs.include_reads == false)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      include_assembly: include_assembly
      include_reads: include_reads
      files:
        source: [ snpeff_assembly/annotated_vcf, snpeff_assembly/summary_report, snpeff_assembly/summary_report_csv, snpeff_assembly/fasta_prot_file ]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
    out:
      [results]
  snpeff_merged_files_to_folder:
    label: SnpEff merged output folder
    doc: Preparation of SnpEff merged output files to a specific output folder.
    when: $(inputs.include_assembly == true && inputs.include_reads == true)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      include_assembly: include_assembly
      include_reads: include_reads
      files:
        source: [ snpeff_merged/annotated_vcf, snpeff_merged/summary_report, snpeff_merged/summary_report_csv, snpeff_merged/fasta_prot_file ]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
    out:
      [results]
  liftoff_files_to_folder:
    label: liftoff assembly output folder
    doc: Preparation of Liftoff output files to a specific output folder.
    when: $(inputs.include_assembly == true)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      include_assembly: include_assembly
      files:
        source: [ liftoff/output_gff, liftoff/unmapped_features_out]
        linkMerge: merge_flattened
        pickValue: all_non_null
      #folder:
      #  source:  [liftoff/intermediate_dir_out]
      #  linkMerge: merge_flattened
      destination:
    out:
      [results]
  provenance_files_to_folder:
    label: provenance output folder
    doc: Preparation of provenance output files to a specific output folder.
    when: $(inputs.provenance == true)
    run: ../tools/expressions/files_to_folder.cwl
    in:
      provenance: provenance
      files:
        source: [ longreadsum_unfiltered/log_file_out, longreadsum_filtered/log_file_out, filtlong/log, flye/flye_log ]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
    out:
      [results]

outputs:
  longreadsum_unfiltered_outdir:
    type: Directory?
    label: LongReadSum folder
    doc: Folder with LongReadSum output files.
    outputSource: longreadsum_unfiltered/longreadsum_outdir
  filtlong_outdir:
    type: Directory?
    label: Filtlong folder
    doc: Folder with Filtlong output files.
    outputSource: filtlong_files_to_folder/results
  longreadsum_filtered_outdir:
    type: Directory?
    label: LongReadSum folder 2
    doc: Folder with LongReadSum output files.
    outputSource: longreadsum_filtered/longreadsum_outdir
  clair3_outdir:
    type: Directory?
    label: Clair3 output directory
    doc: Clair3 output directory containing the vcf file.
    outputSource: clair3/output_dir
  clair3_vcf:
    type: File?
    label: Clair3 output file
    doc: Output variant file from Clair3.
    outputSource: unzip/unzipped_file
  freebayes_output:
    type: File?
    label: freebayes output file
    doc: Output variant file from freebayes.
    outputSource: freebayes/vcf
  merged_output:
    type: File?
    label: merged output file
    doc: Merged output variant file from both Clair3 and freebayes.
    outputSource: merging_vcfs/merged_vcf
  flye_outdir:
    type: Directory?
    label: Filtlong folder
    doc: Folder with Filtlong output files.
    outputSource: flye_files_to_folder/results 
  quast_outdir:
    type: Directory?
    label: Filtlong folder
    doc: Folder with Filtlong output files.
    outputSource: quast/quast_outdir
  minimap2_reads_bam:
    type: File?
    label: mapped reads
    doc: Filtered reads mapped by minimap2.
    outputSource: minimap2_reads/bam
  reads_bam_index_out:
    type: File?
    label: indexed mapped reads
    doc: Indexed filtered mapped reads.
    outputSource: samtools_reads_index/bam_index
  minimap2_assembly_bam:
    type: File?
    label: mapped assembly
    doc: Assembly mapped by minimap2.
    outputSource: minimap2_assembly/bam
  assembly_bam_index_out:
    type: File?
    label: indexed mapped assembly
    doc: Indexed mapped assembly.
    outputSource: samtools_assembly_index/bam_index
  bedtools_bamtobed_out:
    type: File?
    label: output BED file
    doc: The output BED file.
    outputSource: bedtools_bamtobed/bed_file
  reads_fasta_index_out:
    type: File?
    label: indexed reference
    doc: Indexed reference FASTA file.
    outputSource: samtools_faidx_reads/fasta_index
  deeptools_bamcoverage_out:
    type: File?
    label: coverage track output
    doc: Output coverage track file. Either in bigWig or bedGraph format.
    outputSource: deeptools_bamcoverage/output_file
  assembly_fasta_index_out:
    type: File?
    label: indexed reference
    doc: Indexed reference FASTA file.
    outputSource: samtools_faidx_assembly/fasta_index
  bakta_outdir:
    type: Directory?
    label: bakta folder
    doc: Folder with bakta output files.
    outputSource: bakta/output_dir
  strainy_outdir:
    type: Directory?
    label: strainy folder
    doc: Folder with strainy output files.
    outputSource: strainy/strainy_outdir
  snpeff_reads_outdir:
    type: Directory?
    label: SnpEff reads folder
    doc: Folder with SnpEff reads output files.
    outputSource: snpeff_reads_files_to_folder/results 
  snpeff_assembly_outdir:
    type: Directory?
    label: SnpEff assembly folder
    doc: Folder with SnpEff assembly output files.
    outputSource: snpeff_assembly_files_to_folder/results
  snpeff_merged_outdir:
    type: Directory?
    label: SnpEff merged folder
    doc: Folder with SnpEff merged output files.
    outputSource: snpeff_merged_files_to_folder/results 
  liftoff_outdir:
    type: Directory?
    label: Liftoff folder
    doc: Folder with liftoff output files.
    outputSource: liftoff_files_to_folder/results
  logs_outdir:
    type: Directory?
    label: logs folder
    doc: Folder with provenance information.
    outputSource: provenance_files_to_folder/results
  preprocessed_genbank:
    type: File?
    label: preprocessed GenBank file
    doc: The preprocessed GenBank file. This file only differs from the input GenBank file (if provided) when plasmids are included.
    outputSource: preprocess_reference/genbank_final
  preprocessed_fasta:
    type: File?
    label: preprocessed FASTA file
    doc: The preprocessed FASTA file. This file is extracted from the above GenBank file.
    outputSource: preprocess_reference/fasta_final
  preprocessed_gff3:
    type: File?
    label: preprocessed GFF3 file
    doc: The preprocessed GFF3 file. This file is extracted from the above GenBank file.
    outputSource: preprocess_reference/gff3


$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: placeholder
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis/cwl
s:dateCreated: "2025-02-14"
s:dateModified: "2025-08-28"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "Laboratory of Systems and Synthetic Biology"
#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Illumina read quality control, trimming and contamination filter. 
doc: | 
  **Workflow for Illumina paired read quality control, trimming and filtering.**<br />
  Multiple paired datasets will be merged into single paired dataset.<br />
  Summary:
  - FastQC on raw data files<br />
  - fastp for read quality trimming<br />
  - BBduk for phiX and (optional) rRNA filtering<br />
  - Kraken2 for taxonomic classification of reads (optional)<br />
  - BBmap for (contamination) filtering using given references (optional)<br />
  - FastQC on filtered (merged) data<br />

  **All tool CWL files and other workflows can be found here:**<br>
  Tools: https://git.wur.nl/unlock/cwl/-/tree/master/cwl<br>
  Workflows: https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows<br>

  WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default


outputs:
  reports_folder:
    type: Directory
    label: Filtering reports folder
    doc: Folder containing all reports of filtering and quality control  
    outputSource: reports_files_to_folder/results
  QC_forward_reads:
    type: File
    label: Filtered forward read
    doc: Filtered forward read
    outputSource: phix_filter/out_forward_reads
  QC_reverse_reads:
    type: File
    label: Filtered reverse read
    doc: Filtered reverse read
    outputSource: phix_filter/out_reverse_reads
  
  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  threads:
    type: int?
    doc: Number of threads to use for computational processes
    label: Number of threads
  memory:
    type: int?
    doc: Maximum memory usage in MegaBytes
    label: Maximum memory in MB
  filter_rrna:
    type: boolean    
    doc: Optionally remove rRNA sequences from the reads.
    label: filter rRNA
  forward_reads:
    # type: File[]
    type: string[]
    doc: Forward sequence fastq file(s) locally
    label: Forward reads
  reverse_reads:
    # type: File[]
    type: string[]
    doc: Reverse sequence fastq file(s) locally
    label: Reverse reads
  filter_references:
    type: string[]?
    doc: References fasta file(s) for filtering    
    label: Filter reference file(s)
    # ["/unlock/references/databases/bbduk/GCA_000001405.28_GRCh38.p13_genomic.fna.gz"] # HUMAN
  deduplicate:
    type: boolean?
    doc: Remove exact duplicate reads with fastp
    label: Deduplicate reads
  kraken_database:
    type: string[]?
    doc: Kraken2 database location
    label: Kraken2 database
  
  keep_reference_mapped_reads:
    type: boolean
    doc: Keep with reads mapped to the given reference
    label: Keep mapped reads

  step:
    type: int?
    doc: Step number for output folder numbering
    label: Output Step number

steps:
#############################################
#### FASTQC
  fastqc_illumina_before:
    label: FastQC before
    doc: Quality assessment and report of reads
    run: ../fastqc/fastqc.cwl
    in:
      fastq_path:
        source: [forward_reads, reverse_reads]
        linkMerge: merge_flattened
        pickValue: all_non_null
      threads: threads
    out: [html_files, zip_files]

#############################################
#### merging of FASTQ files to only one
  fastq_merge_fwd:
    label: Merge forward reads
    doc: Merge multiple forward fastq reads to a single file
    run: ../bash/concatenate.cwl
    in:
      identifier: identifier
      # infiles:
      #   source: [nanopore_fastq_reads]
      #   linkMerge: merge_flattened
      #   pickValue: all_non_null
      file_paths:
        source: forward_reads
        linkMerge: merge_flattened
        pickValue: all_non_null
      outname: 
        valueFrom: $(inputs.identifier)_illumina_merged_1.fq.gz
    out: [output]

  fastq_merge_rev:
    label: Merge reverse reads
    doc: Merge multiple reverse fastq reads to a single file
    run: ../bash/concatenate.cwl
    in:
      identifier: identifier
      # infiles:
      #   source: [nanopore_fastq_reads]
      #   linkMerge: merge_flattened
      #   pickValue: all_non_null
      file_paths:
        source: reverse_reads
        linkMerge: merge_flattened
        pickValue: all_non_null
      outname:
        valueFrom: $(inputs.identifier)_illumina_merged_2.fq.gz
    out: [output]

#############################################
#### fastp read quality filtering
  fastp:
    label: fastp
    doc: Read quality filtering and (barcode) trimming.
    run: ../fastp/fastp.cwl
    in:
      identifier: identifier
      forward_reads: fastq_merge_fwd/output
      reverse_reads: fastq_merge_rev/output
      deduplicate: deduplicate
      threads: threads
    out: [out_forward_reads, out_reverse_reads, html_report, json_report]

#############################################
#### rRNA filter
  rrna_filter:
    label: rRNA filter (bbduk)
    doc: Filters rRNA sequences from reads using bbduk
    when: $(inputs.filter_rrna)
    run: ../bbmap/bbduk_filter.cwl
    in:
      identifier:
        source: identifier
        valueFrom: $(self+"_rRNA-filter")
      filter_rrna: filter_rrna
      forward_reads: fastp/out_forward_reads
      reverse_reads: fastp/out_reverse_reads
      reference:
        valueFrom: "/unlock/references/databases/riboKmers.fa.gz"
      threads: threads
      memory: memory
    out: [out_forward_reads, out_reverse_reads, summary, stats_file]

#############################################
#### Filter PhiX
  phix_filter:
    label: PhiX filter (bbduk)
    doc: Filters illumina spike-in PhiX sequences from reads using bbduk
    run: ../bbmap/bbduk_filter.cwl
    in:
      identifier:
        source: identifier
        valueFrom: $(self+"_illumina_filtered")
      forward_reads:
        source:
        - rrna_filter/out_forward_reads
        - reference_filter_illumina/out_forward_reads
        pickValue: first_non_null
      reverse_reads:
        source:
        - rrna_filter/out_reverse_reads
        - reference_filter_illumina/out_reverse_reads
        pickValue: first_non_null
      reference:
        valueFrom: "/unlock/references/databases/phix.fasta"
      threads: threads
      memory: memory
    out: [out_forward_reads, out_reverse_reads, summary, stats_file]

#############################################
#### Kraken2
  illumina_quality_kraken2:
    label: Kraken2
    doc: Taxonomic classification of FASTQ reads
    when: $(inputs.kraken_database !== null)
    run: ../kraken2/kraken2.cwl
    scatter: database
    in:
      tmp_id: identifier
      identifier:
        valueFrom: $(inputs.tmp_id)_Qfiltered
      threads: threads
      kraken_database: kraken_database
      database: kraken_database
      forward_reads: phix_filter/out_forward_reads
      reverse_reads: phix_filter/out_reverse_reads
      paired_end: 
    out: [sample_report]
  
  illumina_quality_kraken2_krona:
    label: Krona
    doc: Visualization of Kraken2 classification with Krona
    when: $(inputs.kraken_database !== null)
    run: ../krona/krona.cwl
    scatter: kraken
    in:
      kraken_database: kraken_database
      kraken: illumina_quality_kraken2/sample_report
    out: [krona_html]

#############################################
#### Merging of reference files
  combine_references:
    label: Combine references
    doc: Combine references to a single fasta file
    when: $(inputs.filter_references !== null)
    run: ../bash/concatenate.cwl
    in:
      # infiles:
      #   source: references
      #   linkMerge: merge_flattened
      #   pickValue: all_non_null
      filter_references: filter_references
      file_paths:
        source: filter_references
        linkMerge: merge_flattened
        pickValue: all_non_null
      outname:
        valueFrom: "combined_references.fasta.gz"
    out: [output]
#########################################
#### Read mapping 
  reference_filter_illumina:
    label: Reference read mapping
    doc: Map reads against references using BBMap
    when: $(inputs.filter_references !== null)
    run: ../bbmap/bbmap_filter-reads.cwl
    in:
      filter_references: filter_references
      identifier: identifier
      forward_reads: fastp/out_forward_reads
      reverse_reads: fastp/out_reverse_reads
      reference: combine_references/output
      output_mapped: keep_reference_mapped_reads
      threads: threads
      memory: memory
    out: [out_forward_reads, out_reverse_reads, log, stats, covstats]

#############################################
#### FASTQC
  fastqc_illumina_after:
    label: FastQC after
    doc: Quality assessment and report of reads
    run: ../fastqc/fastqc.cwl
    in:
      fastq: [phix_filter/out_forward_reads, phix_filter/out_reverse_reads]
      threads: threads
    out: [html_files, zip_files]

#############################################
#### Move to folder if not part of a workflow
  reports_files_to_folder:
    label: Reports to folder
    doc: Preparation of fastp output files to a specific output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [fastqc_illumina_before/html_files, fastqc_illumina_before/zip_files, fastqc_illumina_after/html_files, fastqc_illumina_after/zip_files, fastp/html_report, fastp/json_report, reference_filter_illumina/stats, reference_filter_illumina/covstats, reference_filter_illumina/log, illumina_quality_kraken2/sample_report, illumina_quality_kraken2_krona/krona_html, phix_filter/summary, phix_filter/stats_file, rrna_filter/summary, rrna_filter/stats_file]
        linkMerge: merge_flattened
        pickValue: all_non_null
      step: step
      destination:
        valueFrom: $(inputs.step)_Illumina_Read_Quality
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
s:dateCreated: "2020-00-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/
#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

label: Illumina read quality control, trimming and contamination filter. 
doc: | 
  **Workflow for Illumina paired read quality control, trimming and filtering.**<br />
  Multiple paired datasets will be merged into single paired dataset.<br />
  Summary:
  - Sequali QC on raw data files<br />
  - fastp for read quality trimming<br />
  - BBduk for phiX and rRNA filtering (optional)<br />
  - Filter human reads using Hostile (optional)<br />
  - Custom read filtering using Hostile (optional)<br />
  - Sequali QC on filtered (merged) data<br />

  Other UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>

  **All tool CWL files and other workflows can be found at:**<br>
  https://gitlab.com/m-unlock/cwl

  **How to setup and use an UNLOCK workflow:**<br>
  https://docs.m-unlock.nl/docs/workflows/setup.html<br>

outputs:
  reports_folder:
    type: Directory
    label: Filtering reports folder
    doc: Folder containing all reports of filtering and quality control  
    outputSource: reports_files_to_folder/results
  QC_forward_reads:
    type: File?
    label: Filtered forward read
    doc: Filtered forward read
    outputSource: out_fwd_reads/fwd_out
  QC_reverse_reads:
    type: File?
    label: Filtered reverse read
    doc: Filtered reverse read
    outputSource: out_rev_reads/rev_out

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow.
    label: Identifier
  threads:
    type: int
    doc: Number of threads to use for computational processes. (default 2)
    label: Number of threads
  memory:
    type: int
    doc: Maximum memory usage in MegaBytes. (default 8000)
    label: Maximum memory in MB

  forward_reads:
    type: File[]
    doc: Forward sequence fastq file(s) locally
    label: Forward reads
    loadListing: no_listing
  reverse_reads:
    type: File[]
    doc: Reverse sequence fastq file(s) locally
    label: Reverse reads
    loadListing: no_listing

  do_not_output_filtered_reads:
    type: boolean
    label: Don't output reads.
    doc: Do not output filtered reads. (default false)

  skip_qc_unfiltered:
    type: boolean
    doc: Skip FastQC analyses of raw input reads (default false)
    label: Skip QC unfiltered
  skip_qc_filtered:
    type: boolean
    doc: Skip FastQC analyses of filtered input reads (default false)
    label: Skip QC filtered

  filter_rrna:
    type: boolean
    doc: Optionally remove rRNA sequences from the reads (default false)
    label: filter rRNA
  deduplicate:
    type: boolean
    doc: Remove exact duplicate reads with fastp. (default false)
    label: Deduplicate reads
  
  humandb:
    type: Directory?
    doc: Bowtie2 index folder. Provide the folder in which the in index files are located.
    label: Filter human reads
    loadListing: no_listing

  reference_filter_db:
    type: Directory?
    doc: | 
      Custom reference database for filtering with Hostile. 
      Provide the folder in which the bowtie2 index files are located. (default false)
    label: Filter reference file(s)
    loadListing: no_listing
  keep_reference_mapped_reads:
    type: boolean
    doc: Discard unmapped and keep reads mapped to the given reference. Default false (discard mapped)
    label: Keep mapped reads

  # Input provenance (used in cwl-prov)
  destination:
    type: string?
    label: Output Destination
    doc: Optional output destination only used for cwl-prov reporting.
  source:
    label: Input URLs used for this run
    doc: A provenance element to capture the original source of the input data
    type: string[]?

steps:
#############################################
#### Merging of FASTQ files to only one
  workflow_merge_pe_reads:
    label: Merge paired reads
    doc: Merge multiple forward and reverse fastq reads to single file objects
    run: workflow_merge_pe_reads.cwl
    in:
      identifier: identifier
      filename: 
        source: identifier
        valueFrom: $(self)_illumina_merged
      forward_reads: forward_reads
      reverse_reads: reverse_reads
    out: [forward_reads_out, reverse_reads_out]

#############################################
#### Quality control before
  sequali_illumina_before:
    label: Sequali before
    doc: Quality assessment and report of reads before filtering
    run: ../tools/sequali/sequali.cwl
    when: $(!inputs.skip_qc_unfiltered)
    in:
      skip_qc_unfiltered: skip_qc_unfiltered
      input_file: workflow_merge_pe_reads/forward_reads_out
      paired_input: workflow_merge_pe_reads/reverse_reads_out
      threads: threads
    out: [report_html, report_json]

#############################################
#### fastp read quality filtering
  fastp:
    label: fastp
    doc: Read quality filtering and (barcode) trimming.
    run: ../tools/fastp/fastp.cwl
    in:
      identifier: identifier
      forward_reads: workflow_merge_pe_reads/forward_reads_out
      reverse_reads: workflow_merge_pe_reads/reverse_reads_out
      deduplicate: deduplicate
      threads: threads
    out: [out_forward_reads, out_reverse_reads, html_report, json_report]

#############################################
#### rRNA filter
  rrna_filter:
    label: rRNA filter (bbduk)
    doc: Filters rRNA sequences from reads using bbduk
    when: $(inputs.filter_rrna)
    run: ../tools/bbmap/bbduk_filter.cwl
    in:
      identifier:
        source: identifier
        valueFrom: $(self+"_rRNA-filter")
      filter_rrna: filter_rrna
      forward_reads: fastp/out_forward_reads
      reverse_reads: fastp/out_reverse_reads
      reference:
        valueFrom: "/opt/conda/opt/bbmap-39.06-0/resources/riboKmers.fa.gz"
      threads: threads
      memory: memory
    out: [out_forward_reads, out_reverse_reads, summary, stats_file]

#############################################
#### Filter Human reads
  human_filter:
    label: Human filter
    doc: Filter human reads from the dataset using Hostile
    when: $(inputs.indexfolder !== null)
    run: ../tools/hostile/hostile_clean_shortreads.cwl
    in:
      output_filename_prefix:
        source: identifier
        valueFrom: $(self+"_human-filter")

      indexfolder: humandb
      forward_reads: 
        source:
        - rrna_filter/out_forward_reads
        - fastp/out_forward_reads
        pickValue: first_non_null     
      reverse_reads:
        source:
        - rrna_filter/out_reverse_reads
        - fastp/out_reverse_reads
        pickValue: first_non_null

      threads: threads
    out: [out_forward_reads, out_reverse_reads, summary]

#############################################
#### Custom reference filter using kraken2
  reference_filter:
    label: Custom reference filter
    doc: Filter reads using custom references with Hostile
    when: $(inputs.indexfolder !== null)
    run: ../tools/hostile/hostile_clean_shortreads.cwl
    in:
      identifier: identifier
      
      output_filename_prefix:
        source: identifier
        valueFrom: $(self+"_ref-filter")
      
      indexfolder: reference_filter_db
      forward_reads:
        source:
         - human_filter/out_forward_reads
         - rrna_filter/out_forward_reads
         - fastp/out_forward_reads
        pickValue: first_non_null
      reverse_reads:
        source:
         - human_filter/out_reverse_reads
         - rrna_filter/out_reverse_reads
         - fastp/out_reverse_reads
        pickValue: first_non_null
      
      invert: keep_reference_mapped_reads
    out: [out_forward_reads, out_reverse_reads, summary]

#############################################
#### Filter PhiX
  phix_filter:
    label: PhiX filter (bbduk)
    doc: Filters illumina spike-in PhiX sequences from reads using bbduk
    run: ../tools/bbmap/bbduk_filter.cwl
    in:
      identifier:
        source: identifier
        valueFrom: $(self+"_illumina_filtered")
      forward_reads:
        source:
         - reference_filter/out_forward_reads
         - human_filter/out_forward_reads
         - rrna_filter/out_forward_reads
         - fastp/out_forward_reads
        pickValue: first_non_null
      reverse_reads:
        source:
         - reference_filter/out_reverse_reads
         - human_filter/out_reverse_reads
         - rrna_filter/out_reverse_reads
         - fastp/out_reverse_reads
        pickValue: first_non_null
      reference:
        valueFrom: "/opt/conda/opt/bbmap-39.06-0/resources/phix174_ill.ref.fa.gz"
      threads: threads
      memory: memory
    out: [out_forward_reads, out_reverse_reads, summary, stats_file]

#############################################
#### Quality control after
  sequali_illumina_after:
    label: Sequali after
    doc: Quality assessment and report of reads after filtering
    run: ../tools/sequali/sequali.cwl
    when: $(!inputs.skip_qc_filtered)
    in:
      skip_qc_filtered: skip_qc_filtered
      input_file: phix_filter/out_forward_reads
      paired_input: phix_filter/out_reverse_reads
      threads: threads
    out: [report_html, report_json]

#############################################
#### Move files to a specific folder
  reports_files_to_folder:
    label: Reports to folder
    doc: Preparation of QC output files to a specific output folder
    run: ../tools/expressions/files_to_folder.cwl
    in:
      files:
        source: [sequali_illumina_before/report_html, sequali_illumina_before/report_json, sequali_illumina_after/report_html, sequali_illumina_after/report_json, fastp/html_report, fastp/json_report, human_filter/summary, reference_filter/summary, phix_filter/summary, phix_filter/stats_file, rrna_filter/summary, rrna_filter/stats_file]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
    out:
      [results]

#############################################
#### Output reads 
  out_fwd_reads:
    label: Output fwd reads
    doc: Step needed to output filtered reads because there is an option to not to.
    when: $(!inputs.do_not_output_filtered_reads)
    run:
      class: ExpressionTool
      requirements:
        InlineJavascriptRequirement: {}
      inputs:
        fwd_in: File
      outputs:
        fwd_out: File
      expression: |
        ${ return {'fwd_out': inputs.fwd_in}; }
    in:
      do_not_output_filtered_reads: do_not_output_filtered_reads
      fwd_in: phix_filter/out_forward_reads
    out:
      [fwd_out]

  out_rev_reads:
    label: Output rev reads
    doc: Step needed to output filtered reads because there is an option to not to.
    when: $(!inputs.do_not_output_filtered_reads)
    run:
      class: ExpressionTool
      requirements:
        InlineJavascriptRequirement: {}
      inputs:
        rev_in: File
      outputs:
        rev_out: File
      expression: |
       ${ return {'rev_out': inputs.rev_in}; }
    in:
      do_not_output_filtered_reads: do_not_output_filtered_reads
      rev_in: phix_filter/out_reverse_reads
    out: 
      [rev_out]

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2025-04-24"
s:dateModified: "2025-07-25"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/

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
  - FastQC on raw data files<br />
  - fastp for read quality trimming<br />
  - BBduk for phiX and (optional) rRNA filtering<br />
  - Kraken2 for taxonomic classification of reads (optional)<br />
  - BBmap for (contamination) filtering using given references (optional)<br />
  - FastQC on filtered (merged) data<br />

  Other UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>

  **All tool CWL files and other workflows can be found here:**<br>
    Tools: https://gitlab.com/m-unlock/cwl<br>
    Workflows: https://gitlab.com/m-unlock/cwl/workflows<br>

  **How to setup and use an UNLOCK workflow:**<br>
  https://m-unlock.gitlab.io/docs/setup/setup.html<br>


outputs:
  reports_folder:
    type: Directory
    label: Filtering reports folder
    doc: Folder containing all reports of filtering and quality control  
    outputSource: reports_files_to_folder/results
  kraken2_folder:
    type: Directory?
    label: Kraken2 folder
    doc: Folder with Kraken2 output files
    outputSource: kraken2_files_to_folder/results
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

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  threads:
    type: int?
    doc: Number of threads to use for computational processes
    label: Number of threads
    default: 2
  memory:
    type: int?
    doc: Maximum memory usage in MegaBytes
    label: Maximum memory in MB
    default: 4000

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

  skip_qc_unfiltered:
    type: boolean?
    doc: Skip FastQC analyses of raw input reads (default false)
    label: Skip QC unfiltered
    default: false
  skip_qc_filtered:
    type: boolean?
    doc: Skip FastQC analyses of filtered input reads (default false)
    label: Skip QC filtered
    default: false

  filter_rrna:
    type: boolean?
    doc: Optionally remove rRNA sequences from the reads (default false)
    label: filter rRNA
    default: false
  filter_references:
    type: File[]?
    doc: References fasta file(s) for filtering    
    label: Filter reference file(s)
    loadListing: no_listing
  deduplicate:
    type: boolean?
    doc: Remove exact duplicate reads with fastp
    label: Deduplicate reads
    default: false

  kraken2_confidence:
    type: float?
    label: Kraken2 confidence threshold
    doc: Confidence score threshold (default 0.0) must be between [0, 1]
  kraken2_database:
    type: Directory[]?
    label: Kraken2 database
    doc: Kraken2 database location, multiple databases is possible
    default: []
    loadListing: no_listing
  kraken2_standard_report:
    type: boolean
    label: Kraken2 standard report
    doc: Also output Kraken2 standard report with per read classification. These can be large. (default false)
    default: false    

  keep_reference_mapped_reads:
    type: boolean?
    doc: Keep with reads mapped to the given reference (default false)
    label: Keep mapped reads
    default: false
  prepare_reference:
    type: boolean
    doc: |
          Prepare references to a single fasta file and unique headers (default true).
          When false a single fasta file as reference is expected with unique headers
    label: Prepare references
    default: true

  step:
    type: int?
    doc: Step number for output folder numbering (default 1)
    label: Output Step number
    default: 1

  destination:
    type: string?
    label: Output Destination
    doc: Optional output destination only used for cwl-prov reporting.
    
steps:
#############################################
#### FASTQC
  fastqc_illumina_before:
    label: FastQC before
    doc: Quality assessment and report of reads
    run: ../fastqc/fastqc.cwl
    when: $(inputs.skip_qc_unfiltered == false)
    in:
      skip_qc_unfiltered: skip_qc_unfiltered

      fastq:
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
    when: $(inputs.forward_reads.length > 1)
    run: ../bash/concatenate.cwl
    in:
      forward_reads: forward_reads
      infiles:
        source: forward_reads
        linkMerge: merge_flattened
        pickValue: all_non_null
      outname: 
        source: identifier
        valueFrom: $(self)_illumina_merged_1.fq.gz
    out: [output]

  fastq_merge_rev:
    label: Merge reverse reads
    doc: Merge multiple reverse fastq reads to a single file
    when: $(inputs.reverse_reads.length > 1)
    run: ../bash/concatenate.cwl
    in:
      reverse_reads: reverse_reads
      infiles:
        source: reverse_reads
        linkMerge: merge_flattened
        pickValue: all_non_null
      outname:
        source: identifier
        valueFrom: $(self)_illumina_merged_2.fq.gz
    out: [output]
#############################################
#### merging of FASTQ files to only one
  fastq_fwd_array_to_file:
    label: Fwd reads array to file
    doc: Forward file of single file array to file object
    when: $(inputs.forward_reads.length === 1)
    run: ../expressions/array_to_file.cwl
    in:
      forward_reads: forward_reads
      files: forward_reads
    out: [file]
  fastq_rev_array_to_file:
    label: Rev reads array to file
    doc: Forward file of single file array to file object
    when: $(inputs.reverse_reads.length === 1)
    run: ../expressions/array_to_file.cwl
    in:
      reverse_reads: reverse_reads
      files: reverse_reads
    out: [file]

#############################################
#### fastp read quality filtering
  fastp:
    label: fastp
    doc: Read quality filtering and (barcode) trimming.
    run: ../fastp/fastp.cwl
    in:
      identifier: identifier
      forward_reads: 
        source:
          - fastq_merge_fwd/output
          - fastq_fwd_array_to_file/file
        pickValue: first_non_null      
      reverse_reads: 
        source:
          - fastq_merge_rev/output
          - fastq_rev_array_to_file/file
        pickValue: first_non_null
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
        valueFrom: "/venv/opt/bbmap-39.01-0/resources/riboKmers.fa.gz"
      threads: threads
      memory: memory
    out: [out_forward_reads, out_reverse_reads, summary, stats_file]
#############################################
#### Preparation of reference files
  reference_array_to_file:
    label: Reference array to file
    doc: Array to file object when the reference does not need to be prepared
    when: $(inputs.prepare_reference == false && inputs.files.length !== 0)
    run: ../expressions/array_to_file.cwl
    in:
      prepare_reference: prepare_reference
      files: filter_references
    out: [file]

  prepare_fasta_db:
    label: Prepare references
    doc: Prepare references to a single fasta file and unique headers
    when: $(inputs.prepare_reference && inputs.fasta_input !== null && inputs.fasta_input.length !== 0)
    run: workflow_prepare_fasta_db.cwl
    in:
      prepare_reference: prepare_reference

      make_headers_unique:
        default: prepare_reference
      fasta_input: filter_references
      output_name: identifier
    out: [fasta_db]
#########################################
#### Reference filtering (Read mapping) 
  reference_filter_illumina:
    label: Reference read mapping
    doc: Map reads against references using BBMap
    when: $(inputs.filter_references !== null && inputs.filter_references.length !== 0)
    run: ../bbmap/bbmap_filter-reads.cwl
    in:
      filter_references: filter_references

      identifier:
        source: identifier
        valueFrom: $(self+"_ref-filter")      
      
      # REFERENCES INPUT
      # All null in pickValue is not (yet) allowed
      # This can happen because it's conditional step
      # https://github.com/common-workflow-language/cwl-v1.3/issues/3
      prepared_reference: prepare_fasta_db/fasta_db
      non_prepared_reference: reference_array_to_file/file
      reference:
        # source:
        # - prepare_fasta_db/fasta_db
        # - reference_array_to_file/file
        # pickValue: first_non_null
        valueFrom:
          ${
            var ref = null;
            if (inputs.prepared_reference) {
              ref = inputs.prepared_reference;
            } else if (inputs.non_prepared_reference) {
              ref = inputs.non_prepared_reference;
            }
            console.log(ref);
            return ref;
          }

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
      output_mapped: keep_reference_mapped_reads
      threads: threads
      memory: memory
    out: [out_forward_reads, out_reverse_reads, log, stats, covstats]
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
         - reference_filter_illumina/out_forward_reads
         - rrna_filter/out_forward_reads
         - fastp/out_forward_reads
        pickValue: first_non_null
      reverse_reads:
        source:
         - reference_filter_illumina/out_reverse_reads
         - rrna_filter/out_reverse_reads
         - fastp/out_reverse_reads
        pickValue: first_non_null
      reference:
        valueFrom: "/venv/opt/bbmap-39.01-0/resources/phix174_ill.ref.fa.gz"
      threads: threads
      memory: memory
    out: [out_forward_reads, out_reverse_reads, summary, stats_file]

#############################################
#### Kraken2
  illumina_kraken2_unfiltered:
    label: Kraken2 unfiltered
    doc: Taxonomic classification on unfiltered files
    when: $(inputs.database !== null && inputs.database.length !== 0)
    run: ../kraken2/kraken2.cwl
    scatter: database
    in:
      identifier:
        source: identifier
        valueFrom: $(self+"illumina_filtered")
      threads: threads
      database: kraken2_database
      confidence: kraken2_confidence
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
      paired_end:
        default: true
    out: [sample_report, standard_report]

  illumina_kraken2_filtered:
    label: Kraken2 unfiltered
    doc: Taxonomic classification on unfiltered files
    when: $(inputs.database !== null && inputs.database.length !== 0)
    run: ../kraken2/kraken2.cwl
    scatter: database
    in:
      identifier:
        source: identifier
        valueFrom: $(self+"illumina_filtered")
      threads: threads
      database: kraken2_database
      confidence: kraken2_confidence
      forward_reads: phix_filter/out_forward_reads
      reverse_reads: phix_filter/out_reverse_reads
      paired_end:
        default: true
    out: [sample_report, standard_report]
  
  illumina_kraken2_compress:
    label: Compress kraken2
    doc: Compress large kraken2 report file
    when: $(inputs.kraken2_database !== null && inputs.kraken2_database.length !== 0  && inputs.kraken2_standard_report)
    run: ../bash/pigz.cwl
    scatter: inputfile
    in:
      kraken2_database: kraken2_database
      kraken2_standard_report: kraken2_standard_report

      inputfile:
        source: [illumina_kraken2_unfiltered/standard_report, illumina_kraken2_filtered/standard_report]
        linkMerge: merge_flattened
        pickValue: all_non_null
      threads: threads
    out: [outfile]

  illumina_kraken2_krona:
    label: Krona Kraken2
    doc: Visualization of kraken2 with Krona
    when: $(inputs.kraken2_database !== null && inputs.kraken2_database.length !== 0)
    run: ../krona/krona.cwl
    scatter: kraken
    in:
      kraken2_database: kraken2_database

      kraken:
        source: [illumina_kraken2_unfiltered/sample_report, illumina_kraken2_filtered/sample_report]
        linkMerge: merge_flattened
        pickValue: all_non_null
    out: [krona_html]

#############################################
#### FASTQC
  fastqc_illumina_after:
    label: FastQC after
    doc: Quality assessment and report of reads
    run: ../fastqc/fastqc.cwl
    when: $(inputs.skip_qc_filtered == false)
    in:
      skip_qc_filtered: skip_qc_filtered

      fastq: [phix_filter/out_forward_reads, phix_filter/out_reverse_reads]
      threads: threads
    out: [html_files, zip_files]

#############################################
#### Move files to a specific folder
  reports_files_to_folder:
    label: Reports to folder
    doc: Preparation of fastp output files to a specific output folder
    run: ../expressions/files_to_folder.cwl
    in:
      files:
        source: [fastqc_illumina_before/html_files, fastqc_illumina_before/zip_files, fastqc_illumina_after/html_files, fastqc_illumina_after/zip_files, fastp/html_report, fastp/json_report, reference_filter_illumina/stats, reference_filter_illumina/covstats, reference_filter_illumina/log, phix_filter/summary, phix_filter/stats_file, rrna_filter/summary, rrna_filter/stats_file]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        default: "Illumina_quality_reports"
    out:
      [results]

  kraken2_files_to_folder:
    label: Kraken2 folder
    doc: Kraken2 files to single folder
    when: $(inputs.kraken2_database !== null && inputs.kraken2_database.length !== 0)
    in:
      kraken2_database: kraken2_database

      files:
        source: [illumina_kraken2_unfiltered/sample_report, illumina_kraken2_filtered/sample_report, illumina_kraken2_krona/krona_html, illumina_kraken2_compress/outfile]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        default: "Kraken2_Illumina"
    run: ../expressions/files_to_folder.cwl
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
s:dateCreated: "2022-06-14"
s:dateModified: "2023-03-03"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/

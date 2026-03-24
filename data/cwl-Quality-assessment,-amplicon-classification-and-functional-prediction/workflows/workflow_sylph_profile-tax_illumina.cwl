#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
   - class: StepInputExpressionRequirement
   - class: SubworkflowFeatureRequirement
   - class: InlineJavascriptRequirement
   - class: MultipleInputFeatureRequirement

label: Sylph profile and sylph-tax
doc:  Taxonomic profiling of Illumina reads using Sylph and convert to taxonomy abundances with sylph-tax. Including quality filtering (optional)
      
outputs:
  sylph_profile:
    type: File
    doc: Output directory
    outputSource: sylph_profile_run/sylph_profile

  tax_file:
    type: File
    doc: Output directory
    outputSource: sylph_tax/sylph_tax
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
  quality_reports:
    type: Directory?
    doc: Quality reports output directory
    outputSource: workflow_illumina_quality/reports_folder

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow.
    label: identifier used
  threads:
    type: int
    doc: Maximum threads to use. (Default 3)
    label: Threads
    default: 3

  forward_reads:
    type: File[]?
    doc: The file containing the forward reads. (fastx/gzip)
    label: Forward reads
  reverse_reads:
    type: File[]?
    doc: The file containing the reverse reads. (fastx/gzip)
    label: Reverse reads

  # Sylph parameters
  database:
    type: File
    doc: Sylph database
    label: Database
  taxonomy_metadata:
    type:
      - type: record
        name: builtin_taxonomy_metadata
        fields:
          builtin_taxonomy_metadata:
            type:
              - "null"
              - type: enum
                symbols:
                  - GTDB_r214
                  - GTDB_r220
                  - GTDB_r226
                  - IMGVR_4.1
                  - SoilSMAG
                  - OceanDNA
                  - TaraEukaryoticSMAG
                  - FungiRefSeq-2024-07-25
            doc: Provided taxonomy metadata from default sylph databases. (only available when running with the container image)
            label: Taxonomy metadata
      - type: record
        name: taxonomy_metadata_file
        fields:
          taxonomy_metadata_file:
            type: File
            doc: Taxonomy metadata file(s) that are not incorporated in the docker image.
            label: Taxonomy metadata file
  estimate_unknown:
    type: boolean
    doc: Estimate true coverage and scale sequence abundance in `profile` by estimated unknown sequence percentage. Default false
    label: Estimate unknown
    default: true
  annotate_virus_hosts:
    type: boolean
    doc: Add additional column(s) by integrating viral-host information available (currently available for IMGVR4.1). Default false
    label: Annotate virus hosts
    default: false

  # Read filtering parameters
  skip_read_filter:
    type: boolean
    label: Skip quality filtering
    doc: Skip quality reporting, filtering and contamination. (Default false)
    default: false

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
  use_reference_mapped_reads:
    type: boolean
    doc: Use mapped reads mapped to the custom reference db. (Default false, discard mapped)
    label: Use mapped reads
    default: false

  output_filtered_reads:
    type: boolean
    label: Output filtered reads
    doc: Output filtered reads when filtering is applied. (Default false)
    default: false
 
  destination:
    type: string?
    label: Output Destination
    doc: Output destination used for cwl-prov reporting. 

steps:
#############################################
#### Merge reads
  workflow_merge_reads:
    label: Merge paired reads
    doc: Creates a single file object. Also merges reads if multiple files are given.
    when: $(inputs.skip_read_filter)
    run: workflow_merge_pe_reads.cwl
    in:
      skip_read_filter: skip_read_filter
      filename: 
        source: identifier
        valueFrom: $(self)_merged
      forward_reads: forward_reads
      reverse_reads: reverse_reads
    out: [forward_reads_out, reverse_reads_out]
#############################################
#### Quality workflow Oxford Nanopore
  workflow_illumina_quality:
    label: Oxford Nanopore quality workflow
    doc: Quality, filtering and taxonomic classification workflow for Oxford Nanopore reads
    when: $(!inputs.skip_read_filter)
    run: workflow_illumina_quality.cwl
    in:
      skip_read_filter: skip_read_filter

      identifier: identifier

      forward_reads: forward_reads
      reverse_reads: reverse_reads

      humandb: humandb
      reference_filter_db: reference_filter_db
      keep_reference_mapped_reads: use_reference_mapped_reads

      threads: threads
    out: [QC_forward_reads, QC_reverse_reads, reports_folder]
#############################################
#### Sylph
  sylph_profile_run:
    run: ../tools/sylph/sylph_profile.cwl
    in:
      output_filename_prefix: identifier
      forward_reads: 
        source:
        - workflow_illumina_quality/QC_forward_reads
        - workflow_merge_reads/forward_reads_out
        pickValue: first_non_null
      reverse_reads:
        source:
        - workflow_illumina_quality/QC_reverse_reads
        - workflow_merge_reads/reverse_reads_out
        pickValue: first_non_null

      estimate_unknown: estimate_unknown
      database: database
      threads: threads
    out: [sylph_profile]

  sylph_tax:
    run: ../tools/sylph/sylph_tax.cwl
    in:
      output_filename_prefix: identifier
      sylph_profile: sylph_profile_run/sylph_profile
      taxonomy_metadata: taxonomy_metadata
      annotate_virus_hosts: annotate_virus_hosts
    out: [sylph_tax]

#############################################
#### Output reads 
  out_fwd_reads:
    label: Output fwd reads
    doc: Step needed to output filtered reads because there is an option to not to.
    when: $(!inputs.skip_read_filter && inputs.output_filtered_reads)
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
      output_filtered_reads: output_filtered_reads
      skip_read_filter: skip_read_filter
      fwd_in: workflow_illumina_quality/QC_forward_reads
    out:
      [fwd_out]

  out_rev_reads:
    label: Output rev reads
    doc: Step needed to output filtered reads because there is an option to not to.
    when: $(!inputs.skip_read_filter && inputs.output_filtered_reads)
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
      output_filtered_reads: output_filtered_reads
      skip_read_filter: skip_read_filter
      rev_in: workflow_illumina_quality/QC_reverse_reads
    out: 
      [rev_out]


s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-07-29"
s:dateCreated: "2025-07-29"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
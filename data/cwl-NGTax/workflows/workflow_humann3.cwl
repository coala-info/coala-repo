#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  InlineJavascriptRequirement: {}
  StepInputExpressionRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: HUMAnN 3 workflow
doc: | 
  Runs MetaPhlAn 4 and HUMAnN 3 pipeline. Including illumina quality control reads. (Only paired end) \
  Includes renormalizing and all regroupings to other functional categories (EC,KO.. etc)

outputs:
  humann_genefamilies_out:
    type: File
    label: Gene families
    doc: HUMAnN 3 Gene families abundances
    outputSource: humann/genefamilies_out
  humann_pathabundance_out:
    type: File
    label: Pathway abundances
    doc: HUMAnN 3 pathway abundances
    outputSource: humann/pathabundance_out
  humann_pathcoverage_out:
    type: File
    label: Pathway coverage
    doc: HUMAnN 3 pathway coverage
    outputSource: humann/pathcoverage_out
  humann_log_out:
    type: File
    label: HUMAnN 3 log
    doc: HUMAnN 3
    outputSource: humann/log_out
  humann_stdout_out:
    type: File
    label: HUMAnN 3 stdout
    doc: HUMAnN 3 standard out
    outputSource: humann/stdout_out
  humann_pathways_unpacked:
    type: File
    label: Pathways unpacked
    doc: HUMAnN 3 pathways gene abundances
    outputSource: humann_unpack_pathways/pathway_genes_abundances
  
  regrouped_tables:
    type: File[]
    label: Regrouped tables
    doc: Regrouped tabes unnormalized
    outputSource: humann_regroup_table/regrouped_table
  normalized_tables:
    type: Directory
    label: Normalized tables
    doc: Normalized tables Director
    outputSource: files_to_folder_normalized/results

  metaphlan_profile:
    type: File
    label: MetaPhlAn4 profile
    doc: MetaPhlAn4 profile tsv
    outputSource: metaphlan/profile
  metaphlan_bt2out:
    type: File
    label: MetaPhlAn4 bt2out
    doc: MetaPhlAn4 bowtie 2 output
    outputSource: metaphlan/bowtie2out

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
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  threads:
    type: int
    doc: Number of threads to use for computational processes
    label: Number of threads
  memory:
    type: int
    doc: Maximum memory usage in megabytes (default 8000)
    label: Memory usage (MB)

  forward_reads:
    type: File[]
    doc: Forward sequence fastq file
    label: Forward reads
    loadListing: no_listing
  reverse_reads:
    type: File[]
    doc: Reverse sequence fastq file
    label: Reverse reads
    loadListing: no_listing

  # Read filtering parameters
  skip_read_filter:
    type: boolean
    label: Skip quality filtering
    doc: Skip quality filtering. (Default false)

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

  output_filtered_reads:
    type: boolean
    label: Output filtered reads
    doc: Output filtered reads when filtering is applied. (Default false)

  ## MetaPhlAn4
  metaphlan4_bt2_database:
    type: Directory
    label: MetaPhlAn4 database
    doc: MetaPhlAn4 database location
    loadListing: no_listing

  ## HUMAnN3
  uniref_dbtype:
    type:
      - type: enum
        symbols:
          - uniref50
          - uniref90
    doc: uniref50 or uniref90. Match this with your selected database!
    label: UniRef database type
  humann3_nucleotide_database:
    type: Directory
    label: HUMAnN3 nucleotide database
    doc: HUMAnN3 nucleotide database location
    loadListing: no_listing
  humann3_protein_database:
    type: Directory
    label: HUMAnN3 protein database
    doc: HUMAnN3 protein database location
    loadListing: no_listing

  # Input provenance (to be ignored when prov is not used)
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
#### Merge reads
  workflow_merge_reads:
    label: Merge paired reads
    doc: |
      This is workflow specific step and creates a single file object. 
      Also merges reads if multiple files are given. (not interleaving)
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
############################################
### Interleave reads
  interleave_fastq:
    label: Interleave fastq
    doc: Interleave QC forward and reverse files for subsequent tools
    run: ../tools/fastq/interleave_fastq.cwl
    in:
      identifier:
        source: identifier
        valueFrom: $(self)_interleaved
      threads: threads
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
    out: [fastq_out]

############################################
### MetaPhlAn 4
  metaphlan:
    label: MetaPhlAn 4
    doc: Profiling the composition of microbial communities
    run: ../tools/metaphlan/metaphlan4.cwl
    in:
      identifier: identifier
      threads: threads
      bowtie2db: metaphlan4_bt2_database
      reads: interleave_fastq/fastq_out
      analysis_type:
      input_type: 
    out: [profile, bowtie2out]
############################################
### HUMAnN
  humann:
    label: HUMAnN 3
    doc: HMP Unified Metabolic Analysis Network.
    run: ../tools/humann/humann.cwl
    in:
      uniref_dbtype: uniref_dbtype
      identifier:
        source: identifier
        valueFrom: $(self)_$(inputs.uniref_dbtype)
      threads: threads
      input_file: interleave_fastq/fastq_out
      taxonomic_profile: metaphlan/profile
      protein_database: humann3_protein_database
      nucleotide_database: humann3_nucleotide_database
    out: [genefamilies_out, pathabundance_out, pathcoverage_out, log_out, stdout_out]
############################################
### HUMAnN - unpack pathways
  humann_unpack_pathways:
    label: Unpack pathways
    doc: HUMAnN 3 Unpack pathways
    run: ../tools/humann/humann_unpack_pathways.cwl
    in:
      uniref_dbtype: uniref_dbtype
      identifier:
        source: identifier
        valueFrom: $(self)_$(inputs.uniref_dbtype)
      input_genes: humann/genefamilies_out
      input_pathways: humann/pathabundance_out
    out: [pathway_genes_abundances]
############################################
### HUMAnN - renormalize genefamilies
  humann_renorm_table_genefamilies:
    label: Renorm gene families
    doc: HUMAnN 3 renormalize genefamilies
    scatter: units
    scatterMethod: dotproduct
    run: ../tools/humann/humann_renorm_table.cwl
    in:
      input_table: humann/genefamilies_out
      units:
      mode:
      update-sname:
    out: [renormalized_table]
############################################
### HUMAnN - renormalize pathways
  humann_renorm_table_pathways:
    label: Renorm pathways
    doc: HUMAnN 3 renormalize pathways
    run: ../tools/humann/humann_renorm_table.cwl
    scatter: [units, input_table]
    scatterMethod: flat_crossproduct
    in:
      input_table:
        source: [humann/pathabundance_out, humann_unpack_pathways/pathway_genes_abundances]
        linkMerge: merge_flattened
        pickValue: all_non_null
      units:
      mode:
    out: [renormalized_table]
############################################
### HUMAnN - regroup genefamilies
  humann_regroup_table:
    label: Regroup unnormalized
    doc: HUMAnN 3 regroup genefamily
    run: ../tools/humann/humann_regroup_table.cwl
    in:
      input_table: humann/genefamilies_out
      group:
        # all = RXN,GO,KO,EC,Pfam,eggnog
      add_unireftype:
      uniref_type: uniref_dbtype
    out: [regrouped_table]
###########################################
## HUMAnN - regroup renormalized genefamilies
  humann_regroup_renorm_table:
    label: Regroup renormalized
    doc: HUMAnN 3 regroup renormalized genefamilies
    run: ../tools/humann/humann_regroup_table.cwl
    scatter: input_table
    scatterMethod: dotproduct
    in:
      input_table: 
        source: [humann_renorm_table_genefamilies/renormalized_table]
        linkMerge: merge_flattened
      group:
        # all = RXN,GO,KO,EC,Pfam,eggnog
      uniref_type: uniref_dbtype
      add_unireftype:
    out: [regrouped_table]
  renorm_groups_to_array:
    run: ../tools/expressions/merge_file_arrays.cwl
    label: Merge file arrays
    doc: Merges arrays of files in an array to an array of files
    in:
      input: humann_regroup_renorm_table/regrouped_table
    out: 
      [output]

#############################################
#### Prepare output
  files_to_folder_normalized:
    label: Normalized tables
    doc: Normalized tables folder
    in:
      files:
        source: [humann_renorm_table_genefamilies/renormalized_table, humann_renorm_table_pathways/renormalized_table, renorm_groups_to_array/output]
        linkMerge: merge_flattened
      destination:
    run: ../tools/expressions/files_to_folder.cwl
    out:
      [results]

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
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2024-05-21"
s:dateModified: "2025-07-30"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/

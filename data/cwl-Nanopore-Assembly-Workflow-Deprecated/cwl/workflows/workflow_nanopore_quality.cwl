#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Nanopore Quality Control and Filtering 
doc: | 
  **Workflow for nanopore read quality control and contamination filtering.**
  - FastQC before filtering (read quality control)
  - Kraken2 taxonomic read classification
  - Minimap2 read filtering based on given references
  - FastQC after filtering (read quality control)

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
  filtered_reads:
    type: File
    label: Filtered nanopore reads
    doc: Filtered nanopore reads
    outputSource: reference_filter_nanopore/fastq

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  reads:
    type: string[]
    doc: Forward sequence file locally
    label: Forward reads
  filter_references:
    type: string[]
    doc: Contamination references fasta file for contamination filtering
    label: Contamination reference file
    default: ["/unlock/references/databases/bbduk/GCA_000001405.28_GRCh38.p13_genomic.fna.gz"] # HUMAN
  
  keep_reference_mapped_reads:
    type: boolean
    doc: Keep with reads mapped to the given reference
    label: Keep mapped reads
    default: false
  
  run_kraken2:
    type: boolean?
    label: Kraken2
    doc: Optionally run kraken2 contamination inspection
    default: true
  kraken_database:
    type: string?
    label: Kraken2 database
    doc: Kraken2 database location
    default: "/unlock/references/databases/Kraken2/K2_PlusPF_20210517"
    
  threads:
    type: int?
    doc: Number of threads to use for computational processes
    label: Number of threads
    default: 2
  memory:
    type: int?
    doc: Maximum memory usage in megabytes
    label: Maximum memory in MB
    default: 4000

  step:
    type: int?
    label: CWL base step number
    doc: Step number for order of steps
    default: 1

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

steps:
#############################################
#### merging of FASTQ files to only one
  merge_nanopore_fastq: 
    label: Merge fastq files
    run: ../bash/concatenate.cwl
    in:
      identifier: identifier
      # infiles:
      #   source: [nanopore_fastq_reads]
      #   linkMerge: merge_flattened
      #   pickValue: all_non_null
      file_paths:
        source: reads
        linkMerge: merge_flattened
        pickValue: all_non_null
      outname: 
        valueFrom: $(inputs.identifier)_nanopore_raw.fastq.gz
    out: [output]
#############################################
#### FASTQC Before
  fastqc_nanopore_before:
    label: FastQC before
    doc: Quality assessment and report of reads before filter
    in:
      nanopore: merge_nanopore_fastq/output
      threads: threads
    run: ../fastqc/fastqc.cwl
    out: [html_files, zip_files]
#############################################
#### merging of contamination reference files
  combine_references: 
    label: Combine references
    run: ../bash/concatenate.cwl
    in:
      # infiles:
      #   source: contamination_references
      #   linkMerge: merge_flattened
      #   pickValue: all_non_null
      file_paths: 
        source: filter_references
        linkMerge: merge_flattened
        pickValue: all_non_null
      outname: 
        valueFrom: "combined_references.fasta.gz"
    out: [output]
#############################################
#### taxonomic classification of reads with Kraken2
  workflow_nanopore_kraken2:
    label: Kraken2
    doc: Taxonomic classification of FASTQ reads
    when: $(inputs.run_kraken2)
    run: ../kraken2/kraken2.cwl
    in:
      run_kraken2: run_kraken2
      tmp_id: identifier
      identifier: 
        valueFrom: $(inputs.tmp_id)_nanopore_unfiltered
      threads: threads
      nanopore: merge_nanopore_fastq/output
      database: kraken_database
    out: [sample_report]
#############################################
#### Visual representation of taxonomic classification
  workflow_krona:
    label: Krona
    doc: visualization of taxonomic classification with Krona
    run: ../krona/krona.cwl
    in:
      kraken: workflow_nanopore_kraken2/sample_report
    out: [krona_html]
#############################################
#### Contamination filter
  reference_filter_nanopore:
    label: Reference mapping
    doc: Removal of contaminated reads using minimap2 mapping
    run: ../minimap2/minimap2_to_fastq.cwl
    in:
      threads: threads
      identifier: identifier
      reference: combine_references/output
      reads: merge_nanopore_fastq/output
      output_mapped: keep_reference_mapped_reads
      preset:
        default: "map-ont"
    out: [fastq, log]

#############################################
#### FASTQC After
  fastqc_nanopore_after:
    label: FastQC after
    doc: Quality assessment and report of reads before filter
    in:
      nanopore: reference_filter_nanopore/fastq
      threads: threads
    run: ../fastqc/fastqc.cwl
    out: [html_files, zip_files]

#############################################
#### Move to folder if not part of a workflow
  reports_files_to_folder:
    label: Reports to folder
    doc: Preparation of fastp output files to a specific output folder
    in:
      files:
        source: [fastqc_nanopore_before/html_files, fastqc_nanopore_before/zip_files, fastqc_nanopore_after/html_files, fastqc_nanopore_after/zip_files, workflow_nanopore_kraken2/sample_report, workflow_krona/krona_html, reference_filter_nanopore/log]
        linkMerge: merge_flattened
        pickValue: all_non_null
      step: step
      destination:
        valueFrom: |
          ${
            var step = inputs.step;
            return step+"_Nanopore_Read_Quality";
          }
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
s:dateCreated: "2020-00-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/
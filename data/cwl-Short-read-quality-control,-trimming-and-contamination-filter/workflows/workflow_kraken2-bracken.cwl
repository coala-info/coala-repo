#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
  ScatterFeatureRequirement: {}

label: Kracken2 + Bracken
doc: | 
  Run Kraken2 Analysis + Krona visualization followed by Bracken. Currently only on illumina reads.

outputs:
  kraken2_folder:
    type: Directory
    label: Kraken2 folder
    doc: Folder with Kraken2 output files
    outputSource: files_to_folder_kraken/results
  bracken_folder:
    type: Directory
    label: Bracken folder
    doc: Folder with Bracken output files
    outputSource: files_to_folder_bracken/results

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

  illumina_forward_reads:
    type: File
    doc: Forward sequence fastq file(s) locally
    label: Forward reads
    loadListing: no_listing
  illumina_reverse_reads:
    type: File
    doc: Reverse sequence fastq file(s) locally
    label: Reverse reads
    loadListing: no_listing

  ## Kraken2
  kraken2_confidence:
    type: float?
    label: Kraken2 confidence threshold
    doc: Confidence score threshold (default 0.0) must be between [0, 1]
  kraken2_database:
    type: Directory
    label: Kraken2 database
    doc: Kraken2 database location
    loadListing: no_listing
  output_standard_report:
    type: boolean
    label: Kraken2 standard report
    doc: Also output Kraken2 standard report with per read classification. These can be large. (default true)
    default: true

  ## Bracken
  skip_bracken:
    type: boolean
    label: Run Bracken
    doc: Skip Bracken analysis. Default false.
    default: false
  read_length:
    type: int
    label: Read length
    doc: Read length to use in bracken
  bracken_reads_threshold:
    type: int
    label: Bracken reads threshold
    doc: Number of reads required PRIOR to abundance estimation to perform reestimation in bracken. Default 0
    default: 0
  bracken_levels:
    type: string[]
    label: Bracken levels
    doc: Taxonomy levels in bracken estimate abundances on. Default runs through; [P,C,O,F,G,S]
    default: [P,C,O,F,G,S]

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
############################################
### Kraken2
  illumina_kraken2:
    label: Kraken2
    doc: bla
    run: ../tools/kraken2/kraken2.cwl
    in:
      identifier: identifier
      threads: threads
      database: kraken2_database
      forward_reads: illumina_forward_reads
      reverse_reads: illumina_reverse_reads
      confidence: kraken2_confidence
      paired_end:
        default: true
    out: [sample_report, standard_report]
#############################################
#### Compress 
  kraken2_compress:
    label: Compress kraken2
    doc: Compress large kraken2 report file
    when: $(inputs.kraken2_standard_report)
    run: ../tools/bash/pigz.cwl
    in:
      kraken2_standard_report: output_standard_report
      inputfile: illumina_kraken2/standard_report
      threads: threads
    out: [outfile]
#############################################
#### Krona
  kraken2krona_txt:
    label: kraken2krona
    doc: Convert kraken2 report to krona format
    run: ../tools/krakentools/kreport2krona.cwl
    in:
      report: illumina_kraken2/sample_report
    out: [krona_txt]
  krona:
    label: Krona
    doc: Krona visualization of Kraken2
    run: ../tools/krona/krona_ktImportText.cwl
    in:
      input: kraken2krona_txt/krona_txt
    out: [krona_html]
#############################################
#### Bracken
  illumina_bracken:
    label: Illumina bracken
    doc: Bracken runs on Illumina reads
    run: ../tools/bracken/bracken.cwl
    when: $(!inputs.skip_bracken)
    scatter: level
    in:
      skip_bracken: skip_bracken
      identifier: identifier
      database: kraken2_database
      kraken_report: illumina_kraken2/sample_report
      read_length: read_length
      threshold: bracken_reads_threshold
      level: bracken_levels
    out: [output_report]

#############################################
#### Prepare output
  files_to_folder_kraken:
    label: Kraken2 folder
    doc: Kraken2 files to single folder
    in:
      files:
        source: [illumina_kraken2/sample_report, illumina_kraken2/sample_report, kraken2krona_txt/krona_txt, krona/krona_html, kraken2_compress/outfile]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        default: "Kraken2_Illumina"
    run: ../tools/expressions/files_to_folder.cwl
    out:
      [results]
  files_to_folder_bracken:
    label: Bracken folder
    doc: Bracken files to single folder
    in:
      files:
        source: [illumina_bracken/output_report]
        linkMerge: merge_flattened
        pickValue: all_non_null
      destination:
        default: "Bracken_Illumina"
    run: ../tools/expressions/files_to_folder.cwl
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
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: 2024-10-07
s:dateCreated: "2024-04-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/

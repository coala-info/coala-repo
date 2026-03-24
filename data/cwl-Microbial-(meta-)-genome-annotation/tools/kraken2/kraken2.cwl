#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "Kraken2"
doc: |
    Kraken2 metagenomics taxomic read classification.
    
    Updated databases available at: https://benlangmead.github.io/aws-indexes/k2 (e.g. PlusPF-8)
    Original db: https://ccb.jhu.edu/software/kraken2/index.shtml?t=downloads

    NOTE: This needs the docker container to function properly.

hints:
  SoftwareRequirement:
    packages:
      kraken2:
        version: ["2.1.5"]
        specs: ["https://anaconda.org/bioconda/kraken2", "doi.org/10.1186/s13059-019-1891-0","identifiers.org/RRID:SCR_026838"]

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "kraken2_output"
        writable: true
      - entryname: kraken2.sh
        entry: |-
          #!/bin/bash
          kraken2 $@
          threads=$2

          shopt -s nullglob
          for file in *.f*q; do
            if [ -e "$file" ]; then
              echo "Compressing: $file"
              pigz -p $threads "$file"
            fi
          done

  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/kraken2:2.1.5

baseCommand: [bash, kraken2.sh] # See script in requirements

arguments:
  # Generate standard output filename or to send to /dev/null when requested
  - valueFrom: |
      ${
        if (!inputs.no_standard_report) { 
          return inputs.identifier + '_' + inputs.database.path.split( '/' ).pop() + '_kraken2.tsv';
        }
        else { 
          return '/dev/null'; 
          }
      }
    prefix: --output
    position: 2

  # Generate filename aggregate counts/clade report
  - valueFrom: $(inputs.identifier)_$(inputs.database.path.split( '/' ).pop())_kraken2_report.txt
    prefix: --report
    position: 3

  # Generate (un)classified reads filenames when requested
  - valueFrom: |
      ${
        if (inputs.keep_classified_reads) {
          return '--classified-out';
        } else if (inputs.keep_unclassified_reads) {
          return '--unclassified-out';
        } else {
            return null;
        }
      }
    position: 20

  # Generate (un)classified reads filenames when requested
  - valueFrom: |
      ${
        if (inputs.keep_classified_reads){
          if (inputs.paired_end) {
            return inputs.identifier + "_classified#.fq";
          } else {
            return inputs.identifier + "_classified.fastq";
          }
        } else if (inputs.keep_unclassified_reads) {
            if (inputs.paired_end) {
              return inputs.identifier + "_unclassified#.fq";
            } else {
              return inputs.identifier + "_unclassified.fastq";
            }
        } else {
          return null;
        }
      }
    position: 21

inputs:
  threads:
    type: int?
    default: 1
    inputBinding:
      prefix: --threads
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  database:
    type: Directory
    label: Database
    doc: Database location of kraken2
    inputBinding:
      prefix: --db
      position: 4
  
  no_standard_report:
    type: boolean
    label: No kraken standard output
    doc: Do not output kraken's read classification output. Default false
    default: false

  forward_reads:
    type: File?
    label: Forward reads
    doc: Illumina forward read file
    inputBinding:
      position: 100
  reverse_reads:
    type: File?
    label: Reverse reads
    doc: Illumina reverse read file
    inputBinding:
      position: 101
  paired_end:
    type: boolean?
    label: Paired end
    doc: Data is paired end (separate files). Default false
    inputBinding:
      position: 5
      prefix: "--paired"
    default: false

  nanopore_reads:
    type: File?
    label: Nanopore reads
    doc: Oxford Nanopore Technologies reads in FASTQ
    inputBinding:
      position: 102

  confidence:
    type: float?
    label: Confidence
    doc: Confidence score threshold (default 0.0) must be in [0, 1]
    inputBinding:
      position: 6
      prefix: --confidence

  gzip:
    type: boolean
    label: Gzip input
    doc: "input data is gzip compressed"
    inputBinding:
      position: 5
      prefix: '--gzip-compressed'
    default: false
  bzip2:
    type: boolean
    label: Bzip2 input
    doc: "input data is gzip compressed"
    inputBinding:
      position: 7
      prefix: '--bzip2-compressed'
    default: false

  report_zero_counts:
    type: boolean
    label: Report zero counts
    doc: "With --report, report counts for ALL taxa, even if count is zero. default true"
    inputBinding:
      position: 8
      prefix: '--report-zero-counts'
    default: true
  memory_mapping:
    type: boolean
    label: Memory mapping
    doc: "Avoids loading database into RAM. default false"
    inputBinding:
      position: 9
      prefix: '--memory-mapping'
    default: false
  use_names:
    type: boolean
    label: Use names
    doc: "Print scientific names instead of just taxids. default true"
    inputBinding:
      position: 10
      prefix: '--use-names'
    default: true
   
  keep_classified_reads: 
    type: boolean
    label: Keep classified reads
    doc: Output classified reads. Default false
    default: false
  keep_unclassified_reads:
    type: boolean
    label: Keep unclassified reads
    doc: Output unclassified reads. Default false
    default: false

outputs:
  standard_report: 
    type: File?
    outputBinding:
      glob: $(inputs.identifier)_$(inputs.database.path.split( '/' ).pop())_kraken2.tsv
  sample_report:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_$(inputs.database.path.split( '/' ).pop())_kraken2_report.txt
  out_forward_reads:
    type: File?
    outputBinding:
      glob: '*_1.fq.gz'
  out_reverse_reads:
    type: File?
    outputBinding:
      glob: '*_2.fq.gz'
  out_single_end_reads:
    type: File?
    outputBinding:
      glob: '*.fastq.gz'

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
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
s:dateCreated: "2021-11-25"
s:dateModified: "2025-05-09"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
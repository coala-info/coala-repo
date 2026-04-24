#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

baseCommand: [ /unlock/infrastructure/binaries/kraken2-2.0.9-beta/kraken2 ]

label: "Kraken2 metagenomics read classification"
doc: |
    Kraken2 metagenomics read classification.
    
    Updated databases available at: https://benlangmead.github.io/aws-indexes/k2 (e.g. PlusPF-8)
    Original db: https://ccb.jhu.edu/software/kraken2/index.shtml?t=downloads

requirements:
  - class: InlineJavascriptRequirement

arguments:
  - valueFrom: $(inputs.identifier)_$(inputs.database.split( '/' ).pop())_kraken2.txt
    prefix: --output
  - valueFrom: $(inputs.identifier)_$(inputs.database.split( '/' ).pop())_kraken2_report.txt
    prefix: --report
  - "--report-zero-counts"
  - "--use-names"

inputs:
  threads:
    type: int?
    inputBinding:
      prefix: --threads
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
  database:
    type: string
    doc: database location of kraken2
    inputBinding:
      prefix: --db

# Short reads
  forward_reads:
    type: File?
    inputBinding:
      position: 100
  reverse_reads:
    type: File?
    inputBinding:
      position: 101
  paired_end:
    type:
    - "null"
    - boolean
    doc: "data paired end (separate files)"
    inputBinding:
      position: 2
      prefix: "--paired"

# Long reads
  nanopore: # Oxford Nanopore Technologies reads in FASTQ
    type: File?
    inputBinding:
      position: 102

  gzip:
    type:
    - "null"
    - boolean
    doc: "input data is gzip compressed"
    inputBinding:
      position: 3
      prefix: '--gzip-compressed'
  bzip2:
    type:
    - "null"
    - boolean
    doc: "input data is gzip compressed"
    inputBinding:
      position: 3
      prefix: '--bzip2-compressed'

outputs:
  standard_report: 
    type: File
    outputBinding:
      glob: $(inputs.identifier)_$(inputs.database.split( '/' ).pop())_kraken2.txt
  sample_report:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_$(inputs.database.split( '/' ).pop())_kraken2_report.txt

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
s:dateCreated: "2021-11-25"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
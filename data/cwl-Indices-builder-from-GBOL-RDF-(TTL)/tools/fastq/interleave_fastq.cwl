#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "Interleave fastq file"

doc: |
    Interleave forward and reverse compressed (gzipped) fastq files.
    paste <(zcat fwd_1.fq.gz \| paste - - - -) <(zcat rev_2.fq.gz \| paste - - - -) \| tr '\t' '\n' \| pigz -p 4 -c > identifier.fastq.gz

hints:
  SoftwareRequirement:
    packages:
      pigz:
        version: ["2.8"]
        specs: ["https://anaconda.org/conda-forge/pigz"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/pigz:2.8

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "interleave_fastq"
        writable: true
      - entryname: script.sh
        entry: |-
          #!/bin/bash
          paste <(zcat $1 | paste - - - -) <(zcat $2 | paste - - - -) | tr '\t' '\n' | pigz -p $3 -c

baseCommand: [bash, script.sh]

stdout: $(inputs.identifier).fastq.gz

inputs:
  identifier:
    type: string
    doc: Name of the output file
    label: output file name
  forward_reads:
    type: File
    doc: Compressed (gzip) forward sequence fastq file
    label: Forward reads
    inputBinding:
      position: 1
  reverse_reads:
    type: File
    doc: Compressed (gzip) reverse sequence fastq file
    label: Reverse reads
    inputBinding:
      position: 2
  threads:
    type: int
    doc: Number of compression threads
    label: Threads
    inputBinding:
      position: 3

outputs:
  fastq_out:
    type: stdout

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
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
s:dateModified: 2024-10-07
s:dateCreated: "2024-05-21"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

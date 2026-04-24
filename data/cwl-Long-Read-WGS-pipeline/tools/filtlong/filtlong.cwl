#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: Filtlong, a quality filtering tool for long reads

doc: |  
      Filtlong is a tool for filtering long reads by quality. It can take a set of long reads and produce a smaller, better subset. 
      It uses both read length (longer is better) and read identity (higher is better) when choosing which reads pass the filter.
      Documentation on how to install and run Filtlong can be found here:
      https://github.com/rrwick/Filtlong

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "filtlong"
        writable: true
      - entryname: script.sh
        entry: |-
          #!/bin/bash
          outname=$1
          longreads=$2
          shift;shift;
          filtlong $longreads $@ 2> >(tee -a $outname.filtlong.log>&2) | gzip > $outname.fastq.gz

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/filtlong:0.2.1--hd03093a_1 
  SoftwareRequirement:
    packages:
      filtlong:
        version: ["0.2.1"]
        specs: ["identifiers.org/RRID:SCR_024020"]     

baseCommand: [ bash, -x, script.sh ]

inputs:
  output_filename:
    type: string
    label: output filename
    doc: Output filename (fastq.gz will be added by default), defaults to filtered_read, advisable to use sample name here.
    inputBinding:
      position: -2
  long_reads:
    type: File
    #format: edam:format_1930
    streamable: true
    label: long read input
    doc: Long reads in FASTQ format.
    inputBinding:
      position: -1
  target_bases:
    type: int?
    label: target bases
    doc: Keep only the best reads up to this many total bases.
    inputBinding:
      prefix: --target_bases
  keep_percent:
    type: float?
    label: keep percentage
    doc: Keeps only this percentage of the best reads (measured by bases).
    inputBinding:
      prefix: --keep_percent
  minimum_length:
    type: int?
    label: minimum length
    doc: Minimum read length threshold.
    inputBinding:
      prefix: --min_length
  maximum_length:
    type: int?
    label: maximum length
    doc: Maximum read length threshold.
    inputBinding:
      prefix: --max_length
  min_mean_q:
    type: float?
    label: minimum mean quality
    doc: Minimum mean quality threshold.
    inputBinding:
      prefix: --min_mean_q
  min_window_q:
    type: float?
    label: minimum window quality
    doc: Minimum window quality threshold.
    inputBinding:
      prefix: --min_window_q
  trim:
    type: boolean?
    label: trim start and end
    doc: Set to true to trim non-k-mer-matching bases from start/end of reads. Requires assembly or read reference.
    inputBinding:
      prefix: --trim
  split:
    type: int?
    label: split reads
    doc: | 
      Split reads at this many (or more) consecutive non-k-mer-matching bases.
      This serves to remove very poor parts of reads while keeping the good parts.
      A lower value will split more aggressively and a higher value will be more conservative.
      Requires assembly or read reference.
    inputBinding:
      prefix: --split
#  External references (if provided, read quality will be determined using these instead of from the Phred scores)
  forward_reads:
    type: File?
    #format: edam:format_1930
    streamable: true
    label: forward reference reads
    doc: Forward reference Illumina reads in FASTQ format.
    inputBinding:
      prefix: -illumina_1
  reverse_reads:
    type: File?
    #format: edam:format_1930
    streamable: true
    label: reverse reference reads
    doc: Reverse reference Illumina reads in FASTQ format.
    inputBinding:
      prefix: -illumina_2
  assembly:
    type: File?
    #format: edam:format_1929
    streamable: true
    label: reference assembly
    doc: Reference assembly in FASTA format.
    inputBinding:
      prefix: --assembly
#  score weights (control the relative contribution of each score to the final read score):
  length_weight:
    type: float?
    label: length weight
    doc: Weight given to the length score (default; 1).
    inputBinding:
      prefix: --length_weight
  mean_q_weight:
    type: float?
    label: mean quality weight
    doc: Weight given to the mean quality score (default; 1).
    inputBinding:
      prefix: --mean_q_weight
  window_q_weight:
    type: float?
    label: mean window weight
    doc: Weight given to the window quality score (default; 1).
    inputBinding:
      prefix: --window_q_weight

outputs:
  output_reads:
    type: File
    format: edam:format_1930
    label: long read output
    doc: Filtered long read output in FASTQ format.
    outputBinding:
      glob: $(inputs.output_filename).fastq.gz
  log:
    type: File
    label: log file
    doc: A log file storing runtime logs and execution details for debugging and record-keeping.
    outputBinding:
      glob: $(inputs.output_filename).filtlong.log

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/ 
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
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2023-01-03"
s:dateModified: "2025-02-14"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"
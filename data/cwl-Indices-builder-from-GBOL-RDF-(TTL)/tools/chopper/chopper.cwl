#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: chopper

doc: |
  This tool, intended for long read sequencing such as PacBio or ONT, filters and trims a fastq file.
  Filtering is done on average read quality and minimal or maximal read length, 
  and applying a headcrop (start of read) and tailcrop (end of read) while printing the reads passing the filter.

hints:
  SoftwareRequirement:
    packages:
      sylph:
        version: ["0.9.1"]
        specs: ["https://anaconda.org/bioconda/chopper","https://identifiers.org/RRID:SCR_026486"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/chopper:0.9.1--hcdda2d0_0

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: chopper.sh
        entry: |-
          #!/bin/bash
          out_name=$1
          shift;
          echo -e "chopper $@ | gzip > $out_name.fastq.gz\n" >&2
          chopper $@ | gzip > $out_name.fastq.gz

baseCommand: [ bash, chopper.sh ]

stderr: $(inputs.output_filename_prefix+"_chopper.log")

inputs:
  output_filename_prefix:
    type: string
    doc: Name of the output file. .fastq.gz will be appended.
    label: Output filename (base)
    inputBinding:
      position: 0

  input:
    type: File
    doc: Input filename
    label: Input file
    inputBinding:
      prefix: --input
      position: 1      

  contam:
    type: File?
    doc: Fasta file with reference to check potential contaminants against
    label: Contaminant reference file
    inputBinding:
      prefix: --contam
      position: 100

  threads:
    type: int
    doc: Number of parallel threads to use. Default 4
    label: Threads
    default: 4
    inputBinding:
      prefix: --threads
      position: 101

  headcrop:
    type: int
    doc: Trim N nucleotides from the start of a read. Default 0
    label: Head crop
    default: 0
    inputBinding:
      prefix: --headcrop
      position: 102

  maxlength:
    type: int
    doc: Sets a maximum read length. Default 2147483647
    label: Maximum length
    default: 2147483647
    inputBinding:
      prefix: --maxlength
      position: 103    

  minlength:
    type: int
    doc: Sets a minimum read length. Default 1
    label: Minimum length
    default: 1
    inputBinding:
      prefix: --minlength
      position: 103

  quality:
    type: int
    doc: Sets a minimum Phred average quality score. Default 0
    label: Quality score
    default: 0
    inputBinding:
      prefix: --quality
      position: 104

  tailcrop:
    type: int
    doc: Trim N nucleotides from the end of a read. Default 0
    label: Tail crop
    default: 0
    inputBinding:
      prefix: --tailcrop
      position: 105

  maxgc:
    type: float
    doc: Sets a maximum GC content. Default 1.0
    label: Maximum GC content
    default: 1.0
    inputBinding:
      prefix: --maxgc
      position: 106

  mingc:
    type: float
    doc: Sets a minimum GC content. Default 0.0
    label: Minimum GC content
    default: 0.0
    inputBinding:
      prefix: --mingc
      position: 107

outputs:
  filtered_reads:
    type: File
    outputBinding: {glob: '*.fastq.gz'}
  log:
    type: File
    outputBinding:
      glob: $(inputs.output_filename_prefix+"_chopper.log")

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-02-28"
s:dateCreated: "2025-02-27"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

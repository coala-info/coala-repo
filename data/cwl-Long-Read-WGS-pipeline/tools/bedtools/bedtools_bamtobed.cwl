#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: bedtools bamtobed

doc: | 
  bedtools bamtobed - a conversion utility that converts sequence alignments in BAM format into BED, BED12, and/or BEDPE records.
  Documentation on this tool can be found here:
  https://bedtools.readthedocs.io/en/latest/content/tools/bamtobed.html
 
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
  SoftwareRequirement:
    packages:
      longreadsum:
        version: ["2.31.1"]
        specs: ["identifiers.org/RRID:SCR_006646"]
  
baseCommand: [bedtools, bamtobed]

stdout: output_file.bed

inputs:
  sequence_alignment:
    type: File
    label: input BAM file
    doc: BAM file input.
    inputBinding:
      prefix: -i
  bedpe:
    type: boolean?
    label: BEDPE format
    doc: |
       	Write BAM alignments in BEDPE format. Only one alignment from paired-end reads will be reported. Specifically, if each mate is aligned to the same chromosome, the BAM alignment reported will be the one where the BAM insert size is greater than zero. 
        When the mate alignments are interchromosomal, the lexicographically lower chromosome will be reported first. 
        Lastly, when an end is unmapped, the chromosome and strand will be set to “.” and the start and end coordinates will be set to -1. 
        By default, this is disabled and the output will be reported in BED format.
    inputBinding:
      prefix: -bedpe
  mate_one:
    type: boolean?
    label: mate one
    doc: When writing BEDPE (-bedpe) format, always report mate one as the first BEDPE “block”.
    inputBinding:
      prefix: -mate1
  bed_twelve:
    type: boolean?
    label: bed twelve
    doc: Write “blocked” BED (a.k.a. BED12) format. This will convert “spliced” BAM alignments (denoted by the “N” CIGAR operation) to BED12. Forces -split.
    inputBinding:
      prefix: -bed12
  split:
    type: boolean?
    label: split
    doc: Report each portion of a “split” BAM (i.e., having an “N” CIGAR operation) alignment as a distinct BED intervals.
    inputBinding:
      prefix: -split
  split_d:
    type: boolean?
    label: split and d operation
    doc: Report each portion of a “split” BAM while obeying both “N” CIGAR and “D” operation. Forces -split.
    inputBinding:
      prefix: -splitD
  edit_distance:
    type: boolean?
    label: edit distance
    doc: |
      Use the “edit distance” tag (NM) for the BED score field. Default for BED is to use mapping quality. Default for BEDPE is to use the minimum of the two mapping qualities for the pair. 
      When -ed is used with -bedpe, the total edit distance from the two mates is reported.
    inputBinding:
      prefix: -ed
  tag:
    type: boolean?
    label: use other tag
    doc: Use other numeric BAM alignment tag for BED score. Default for BED is to use mapping quality. Disallowed with BEDPE output.
    inputBinding:
      prefix: -tag
  color:
    type: boolean?
    label: set color
    doc: An R,G,B string for the color used with BED12 format. Default is (255,0,0).
    inputBinding:
      prefix: -color
  cigar:
    type: boolean?
    label: add cigar string
    doc: Add the CIGAR string to the BED entry as a 7th column.
    inputBinding:
      prefix: -cigar

outputs:
  bed_file:
    type: File
    format: edam:format_3003
    label: output BED file
    doc: The output BED file.
    outputBinding:
      glob: output_file.bed

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: placeholder 
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-08-28"
s:dateModified: "2025-08-28"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "Laboratory of Systems and Synthetic Biology"
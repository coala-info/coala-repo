#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: deeptools bamCoverage

doc: | 
  This tool takes an alignment of reads or fragments as input (BAM file) and generates a coverage track (bigWig or bedGraph) as output.
  The coverage is calculated as the number of reads per bin, where bins are short consecutive counting windows of a defined size.
  It is possible to extended the length of the reads to better reflect the actual fragment length.
  bamCoverage offers normalization by scaling factor, Reads Per Kilobase per Million mapped reads (RPKM), counts per million (CPM), bins per million mapped reads (BPM) and 1x depth (reads per genome coverage, RPGC).
  Documentation on this tool can be found here:
  https://deeptools.readthedocs.io/en/develop/content/tools/bamCoverage.html
 
requirements:
  #InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.sequence_alignment)
      - entry: $(inputs.indexed_sequence_alignment)

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
  SoftwareRequirement:
    packages:
      longreadsum:
        version: ["3.5.6"]
        specs: ["identifiers.org/RRID:SCR_016366"]
  
baseCommand: bamCoverage

inputs:
  sequence_alignment:
    type: File
    label: input BAM file
    doc: BAM file input.
    inputBinding:
      prefix: --bam
  indexed_sequence_alignment:
    type: File
    label: indexed BAM file
    doc: Indexed BAM file input.
  file_format:
    type: 
      - type: enum
        symbols: [ bigwig, bedgraph ]
    label: input file type
    doc: Input file type. Possible choices are bigwig or bedgraph.
    inputBinding:
      prefix: --outFileFormat
  output_filename:
    type: string
    label: output filename
    doc: Output filename, defaults to output_file, advisable to use sample name here.
    inputBinding:
      prefix: --outFileName
    default: output_file.bw


outputs:
  output_file:
    type: File?
    label: coverage track output
    doc: Output coverage track file. Either in bigWig or bedGraph format.
    outputBinding:
      glob: $(inputs.output_filename)

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
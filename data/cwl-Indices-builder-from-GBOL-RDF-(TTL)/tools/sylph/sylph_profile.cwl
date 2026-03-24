#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: sylph

doc: sylph is a program that performs ultrafast (1) ANI querying or (2) metagenomic profiling for metagenomic shotgun samples.

requirements:
 - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      sylph:
        version: ["0.8.1"]
        specs: ["https://identifiers.org/RRID:SCR_026478","https://anaconda.org/bioconda/sylph","https://doi.org/10.1038/s41587-024-02412-y"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/sylph:0.8.1--ha6fb395_0

baseCommand: [sylph, profile]

arguments:
  - prefix: "--output-file"
    valueFrom: $(inputs.output_filename_prefix+"."+inputs.database.basename.replace(/\.syldb$/, '')+".sylph-profile.tsv")

inputs:
  threads:
    type: int?
    doc: Maximum threads to use. Default 3
    label: Threads
    default: 3
    inputBinding:
      prefix: -t
      position: 10

  database:
    type: File
    doc: Sylph database
    label: Database
    inputBinding:
      position: 0

  single_end_reads:
    type: File?
    doc: Single end reads, for example long reads. (fastx/gzip)
    label: Single end reads
    inputBinding:
      position: 1

  output_filename_prefix:
    type: string
    doc: Name of the output file. (_sylph-profile.tsv will be appended)
    label: Output filename (base)

  forward_reads:
    type: File?
    doc: The file containing the forward reads. (fastx/gzip)
    label: Forward reads
    inputBinding:
      prefix: --first-pairs
      position: 11
  reverse_reads:
    type: File?
    doc: The file containing the reverse reads. (fastx/gzip)
    label: Reverse reads
    inputBinding:
      prefix: --second-pairs
      position: 12

  estimate_unknown:
    type: boolean?
    doc: Estimate true coverage and scale sequence abundance in `profile` by estimated unknown sequence percentage
    label: Estimate unknown
    inputBinding:
      prefix: --estimate-unknown
      position: 14

outputs:
  sylph_profile:
    type: File
    outputBinding: {glob: '*.tsv'}

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-02-21"
s:dateCreated: "2025-02-21"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

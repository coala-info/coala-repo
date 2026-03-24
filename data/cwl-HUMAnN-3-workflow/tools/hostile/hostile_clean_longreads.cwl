#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: Hostile
doc: |
    Read contamination filtering for longread paired end data. 
    It will use minimap2 as it's aligner.

requirements:
  InlineJavascriptRequirement: {}

hints:
  SoftwareRequirement:
    packages:
      hostile:
        version: ["2.0.1"]
        specs: ["https://anaconda.org/bioconda/hostile"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/hostile:2.0.1--pyhdfd78af_0

baseCommand: [hostile, clean]

stdout: $(inputs.output_filename_prefix)_summary.json

arguments:
  - prefix: "--aligner"
    valueFrom: "minimap2"
  - prefix: "--out"
    valueFrom: "hostile_out"

inputs:
  output_filename_prefix:
    type: string?
    doc: Name of the output file. (_1/_2).fq.gz will be appended to the reads. Default "hostile_clean"
    label: Output filename (base)
    default: "hostile_clean"

  reads:
    type: File?
    label: Reads
    doc: Long read file
    inputBinding:
      prefix: --fastq1

  index:
    type: File
    doc: Index file
    inputBinding:
      prefix: --index

  invert:
    type: boolean
    doc:  Keep only reads aligning to the index (and their mates if applicable) (default false)
    label: Invert
    default: false
    inputBinding:
      prefix: --invert

  threads:
    type: int
    doc: Number of parallel threads to use. Default 4
    label: Threads
    default: 4
    inputBinding:
      prefix: --threads

outputs:
  out_reads:
    type: File
    outputBinding:
      glob: 'hostile_out/*fastq.gz'
      outputEval: ${self[0].basename=inputs.output_filename_prefix+".fastq.gz"; return self;}
  summary:
    type: File
    outputBinding: 
      glob: '*.json'

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: "2025-07-25"
s:dateCreated: "2025-07-25"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

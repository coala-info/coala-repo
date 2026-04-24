#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

baseCommand: [ fastqc ]

label: "FASTQC"
doc: |
    Performs quality control on FASTQ files

requirements:
 - class: InlineJavascriptRequirement
 - class: InitialWorkDirRequirement
   listing:
    - entry: "$({class: 'Directory', listing: []})"
      entryname: "FASTQC"
      writable: true

hints:
  SoftwareRequirement:
    packages:
      fastqc :
        version: ["0.12.1"]
        specs: ["https://anaconda.org/bioconda/fastqc"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0

arguments: ["--outdir", "FASTQC"]

inputs:
  nanopore_reads: 
    type: File?
    doc: FastQ files list
    label: FASTQ files list
    inputBinding:
      position: 101
      prefix: --nano
  # nanopore_path: 
  #   type: string[]?
  #   doc: FastQ files list
  #   label: FASTQ files list
  #   inputBinding:
  #     position: 101
  #     prefix: --nano
  fastq:
    type: File[]?
    doc: FastQ file list
    label: FASTQ file list
    inputBinding:
      position: 100
  # fastq_path:
  #   # type: File[]?
  #   type: string[]?
  #   doc: FastQ file path list
  #   label: FastQ file paths
  #   inputBinding:
  #     position: 102
  threads:
    type: int?
    inputBinding:
      prefix: --threads

outputs:
  html_files: 
    type: File[]
    outputBinding:
      glob: "FASTQC/*.html"
  zip_files: 
    type: File[]
    outputBinding:
      glob: "FASTQC/*.zip"

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
s:dateCreated: "2021-11-26"
s:dateModified: "2022-04-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
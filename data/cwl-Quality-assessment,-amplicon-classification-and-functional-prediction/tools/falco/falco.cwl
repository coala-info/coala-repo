#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

baseCommand: [ falco ]

label: falco
doc: A C++ drop-in replacement of FastQC to assess the quality of sequence read data 
requirements:
 - class: InlineJavascriptRequirement

hints:
  SoftwareRequirement:
    packages:
      fastqc :
        version: ["1.2.2"]
        specs: ["https://anaconda.org/bioconda/falco", "doi.org/10.12688/f1000research.21142.2"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/falco:1.2.2--hdcf5f25_0


# arguments:
#   - valueFrom: $(inputs.fastq.basename.replace(/\.?(fastq\.gz|fastq|fq\.gz|fq)\.?/g, '')+"_FastQC.html")
#     prefix: -data-filename
#   - valueFrom: $(inputs.fastq.basename.replace(/\.?(fastq\.gz|fastq|fq\.gz|fq)\.?/g, '')+"_FastQC_report.txt")
#     prefix: -report-filename
#   - valueFrom: $(inputs.fastq.basename.replace(/\.?(fastq\.gz|fastq|fq\.gz|fq)\.?/g, '')+"_fastQC_summary.txt")
#     prefix: -summary-filename


inputs:
  nanopore_reads: 
    type: File?
    doc: FastQ files list
    label: FASTQ files list
    inputBinding:
      position: 101
      prefix: --nano
  fastq:
    type: File[]?
    doc: FastQ file list
    label: FASTQ file list
    inputBinding:
      position: 100
  threads:
    type: int?
    default: 1
    inputBinding:
      prefix: --threads

outputs:
  html_files: 
    type: File[]
    outputBinding:
      glob: "*.html"
  txt_files: 
    type: File[]
    outputBinding:
      glob: "*.txt"

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
s:dateCreated: "2024-04-19"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
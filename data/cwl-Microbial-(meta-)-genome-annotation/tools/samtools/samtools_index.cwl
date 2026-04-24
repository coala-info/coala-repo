#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "samtools index"
doc: "samtools index - creates an index file for bam file"

requirements:
 - class: InlineJavascriptRequirement 

hints:
  SoftwareRequirement:
    packages:
      samtools:
        version: ["1.19.2"]
        specs: ["https://anaconda.org/bioconda/samtools", "doi.org/10.1093/gigascience/giab008"]

  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.19.2--h50ea8bc_0

inputs:
  bam_file:
    type: File
    label: Bam file
    doc: (sorted) Bam file
    inputBinding:
      position: 1

  threads:
    type: int?
    label: Number of threads to use
    inputBinding:
      position: 0
      prefix: -@

# baseCommand: ["/unlock/infrastructure/binaries/samtools/samtools_v1.15/bin/samtools","index"]
baseCommand: ["samtools", "index"]

arguments:
  - valueFrom: $(inputs.bam_file.basename).bai
    position: 2

outputs:
  bam_index:
    type: File
    outputBinding:
      glob: $(inputs.bam_file.basename).bai

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
s:dateCreated: "2022-02-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
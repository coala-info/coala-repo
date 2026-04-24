#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: samtools index

doc: Samtools index BAM - creates index files

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.21--h50ea8bc_0
  SoftwareRequirement:
    packages:
      samtools:
        version: ["1.21"]
        specs: ["identifiers.org/RRID:SCR_002105"]
  
baseCommand: ["samtools", "index"]

arguments:
  - valueFrom: $(inputs.bam_file.basename).bai
    position: 2

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

outputs:
  bam_index:
    type: File
    outputBinding:
      glob: $(inputs.bam_file.basename).bai

$namespaces:
  s: https://schema.org/
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
s:dateModified: "2025-02-20"
s:dateCreated: "2022-02-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"
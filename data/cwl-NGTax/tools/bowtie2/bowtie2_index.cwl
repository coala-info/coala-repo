#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: "Bowtie2 indexer"

doc: |
    Creates the Genome index for bowtie2 (single fasta)

requirements:
 - class: InlineJavascriptRequirement
 - class: InitialWorkDirRequirement
   listing:
    - entry: "$({class: 'Directory', listing: []})"
      entryname: "bowtie2"
      writable: true

hints:
  SoftwareRequirement:
    packages:
      bowtie2:
        version: ["2.5.3"]
        specs: ["https://anaconda.org/bioconda/bowtie2", "doi.org/10.1093/bioinformatics/bty648"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/bowtie2:2.5.3--py310ha0a81b8_0

inputs:
  reference:
    label: Reference file
    doc: Reference file in fasta format
    type: File
    inputBinding:
      prefix: -f
  threads:
    type: int?
    default: 1
    inputBinding:
      prefix: --threads

arguments:
  - valueFrom: $("bowtie2/" + inputs.reference.nameroot)
    position: 100
  - valueFrom: $(runtime.cores)
    prefix: --threads

baseCommand: [bowtie2-build]

outputs:
  bowtie2_index_dir: 
    type: Directory
    outputBinding:
      glob: "bowtie2"


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
s:dateCreated: "2020-00-00"
s:dateModified: "2022-02-23"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"


$namespaces:
  s: https://schema.org/

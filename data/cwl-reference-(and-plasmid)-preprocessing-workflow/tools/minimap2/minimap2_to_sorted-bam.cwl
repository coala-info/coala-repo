#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: Minimap2 piped to sorted bam using a custom container
doc: |
  This tool runs Minimap2 piped to samtools to produce a sorted BAM file.
  It executes the following command pipeline:
  
      minimap2 --split-prefix temp -a -t <threads> -x <preset> <reference> <reads> \
      | samtools view -@ <threads> -hu - \
      | samtools sort -@ <threads> -o <identifier>.bam

requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}


hints:
  SoftwareRequirement:
    packages:
      minimap2:
        version: ["2.28"]
        specs: ["https://identifiers.org/RRID:SCR_018550"]
      samtools:
        version: ["1.20"]
        specs: ["https://identifiers.org/RRID:SCR_002105"]
  DockerRequirement:
    dockerPull: niemasd/minimap2_samtools  # this is very suboptimal, it's a docker image combining samtools and mininmap2, hosted by an external party: https://github.com/Niema-Docker/minimap2_samtools

# baseCommand: [ "bash", "-c" ] - this might be needed in another Docker image that doesn't call /bin/sh -c
arguments:
  - shellQuote: false
    valueFrom: $( "minimap2 --split-prefix temp -a -t " + inputs.threads +
                  " -x " + inputs.preset +
                  " " + inputs.reference.path +
                  " " + inputs.reads.path +
                  " | samtools view -@ " + inputs.threads +
                  " -hu - | samtools sort -@ " + inputs.threads +
                  " -o " + inputs.identifier + ".bam" )

inputs: # optimally would have separate cwls for these tasks and have it be streamable so not going to bother implementing all flags
  threads:
    type: int?
    label: number of CPU threads
    doc: |
      Specifies the number of CPU threads to use for parallel processing.
      Higher values can speed up execution but require more computational resources.
  identifier:
    type: string
    label: identifier used
    doc: Identifier for this dataset used in this workflow
  reference:
    label: reference file
    doc: Target sequence in FASTQ/FASTA format (can be gzipped).
    type: File
  reads:
    label: read input
    doc: Query sequence in FASTQ/FASTA format (can be gzipped).
    type: File
  preset:
    type: string  
    label: read type
    doc: |
      - map-pb/map-ont - PacBio CLR/Nanopore vs reference mapping
      - map-hifi - PacBio HiFi reads vs reference mapping
      - ava-pb/ava-ont - PacBio/Nanopore read overlap
      - asm5/asm10/asm20 - asm-to-ref mapping, for ~0.1/1/5% sequence divergence
      - splice/splice:hq - long-read/Pacbio-CCS spliced alignment
      - sr - genomic short-read mapping

outputs:
  bam: 
    type: File
    outputBinding:
      glob: $(inputs.identifier).bam

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
s:dateCreated: "2025-02-04"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"
#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "Minimap2 to (un)mapped long reads"
doc: |
  Get unmapped or mapped long reads reads in fastq.gz format using minimap2 and samtools. Mainly used for contamination removal.
   - requires pigz!
  minimap2 | samtools | pigz

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "minimap_run"
        writable: true
      - entryname: script.sh
        entry: |-
          #!/bin/bash
          # 1 $1 = ref
          # 2 $2 = forward_reads
          # 3 $3 = forward_reads
          # 4 $4 = threads
          # 5 $5 = identifier
          # 6 $6 = preset
          minimap2 --split-prefix temp -a -t $4 -x $6 $1 $2 $3 | samtools view -@ $4 -hu - | samtools sort -@ $4 -o $5_sorted.bam


baseCommand: [ bash, -x, script.sh ]

hints:
  SoftwareRequirement:
    packages:
      minimap2:
        version: ["2.28"]
        specs: ["https://anaconda.org/bioconda/minimap2", "doi.org/10.1093/bioinformatics/bty191"]
      samtools:
        version: ["1.19.2"]
        specs: ["https://anaconda.org/bioconda/samtools", "doi.org/10.1093/gigascience/giab008"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/minimap2:2.28

inputs:
  threads:
    type: int?
    doc: Maximum threads to use
    label: Threads
    inputBinding:
      position: 4
  identifier:
    type: string
    doc: Output prefix (_filtered.fastq.gz will be added)
    label: identifier
    inputBinding:
      position: 5
  reference:
    type: File
    doc: Target sequence in FASTQ/FASTA format (can be gzipped).
    label: Reference
    inputBinding:
      position: 1

  forward_reads:
    type: File
    doc: Forward sequence in FASTQ/FASTA format (can be gzipped).
    label: Forward reads
    inputBinding:
      position: 2
    
  reverse_reads:
    type: File
    doc: Reverse sequence in FASTQ/FASTA format (can be gzipped).
    label: Reverse reads
    inputBinding:
      position: 3

  preset:
    type: string
    doc: |
      - map-pb/map-ont - PacBio CLR/Nanopore vs reference mapping
      - map-hifi - PacBio HiFi reads vs reference mapping
      - ava-pb/ava-ont - PacBio/Nanopore read overlap
      - asm5/asm10/asm20 - asm-to-ref mapping, for ~0.1/1/5% sequence divergence
      - splice/splice:hq - long-read/Pacbio-CCS spliced alignment
      - sr - genomic short-read mapping
    label: Read type
    inputBinding:
      position: 6

#stderr: $(inputs.identifier)_minimap2.log

outputs:
  sorted_bam: 
    type: File
    outputBinding:
      glob: $(inputs.identifier)_sorted.bam
  # log: 
  #   type: stderr

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
s:dateModified: 2024-10-07
s:dateCreated: "2024-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
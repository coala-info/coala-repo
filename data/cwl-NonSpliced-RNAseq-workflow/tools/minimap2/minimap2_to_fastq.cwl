#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "Minimap2 to (un)mapped long reads"
doc: |
  Get unmapped or mapped long reads in fastq.gz format using minimap2 and samtools. Mainly used for contamination removal.
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
          #   $1 = mapped/unmapped (-F -f)
          # 1 $2 = ref
          # 2 $3 = fastq
          # 3 $4 = preset (map-ont)
          # 4 $5 = threads
          # 5 $6 = identifier

          minimap2 -a -t $5 -x $4 $2 $3 | samtools fastq -@ $5 -n $1 4 | pigz -p $5 > $6_filtered.fastq.gz

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
      pigz:
        version: ["2.8"]
        specs: ["https://anaconda.org/conda-forge/pigz"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/minimap2:2.28

arguments:
  - |
    ${
      if (inputs.output_mapped){
        return '-F';
      } else {
        return '-f';
      }
    }


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

  reads:
    type: File
    doc: Query sequence in FASTQ/FASTA format (can be gzipped).
    label: Reads
    inputBinding:
      position: 2
    
  output_mapped:
    type: boolean?
    doc: Keep only reads mapped to the reference (default = false / output only unmapped reads)
    label: Keep mapped
    inputBinding:
      position: 6

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
      position: 3

stderr: $(inputs.identifier)_minimap2.log

outputs:
  fastq: 
    type: File
    outputBinding:
      glob: $(inputs.identifier)_filtered.fastq.gz
  log: 
    type: stderr

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
s:dateCreated: "2022-03-00"
s:dateModified: "2022-04-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
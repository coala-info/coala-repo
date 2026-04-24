#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: "Kraken2 build"
doc: |
  Kraken2 build database. Requires known ncbi genomes, where the contig id can be mapped to a NCBI taxonomy.
   - downloads ncbi taxonomy (kraken2-build --download-taxonomy)
   - adds input genomes to the database
   - builds
  
  NOTE: It is slow...

hints:
  SoftwareRequirement:
    packages:
      kraken2:
        version: ["2.1.3"]
        specs: ["https://anaconda.org/bioconda/kraken2", "doi.org/10.1186/s13059-019-1891-0"]

  DockerRequirement:
    # dockerPull: quay.io/biocontainers/kraken2:2.1.3--pl5321hdcf5f25_0
    dockerPull: docker-registry.wur.nl/m-unlock/docker/kraken2:2.14

requirements:
  NetworkAccess:
    networkAccess: true
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: kraken2-build.sh
        entry: |-
          #!/bin/bash
          DBNAME=k2_$1
          threads=$2
          shift;shift;
          kraken2-build --download-taxonomy --db $DBNAME
          for file in "$@"
          do
              echo "Processing $file";
              kraken2-build --add-to-library $file --db $DBNAME
          done
          # kraken2-build --db KRAKEN2_PIG --download-taxonomy
          kraken2-build --threads $threads --build --db $DBNAME

baseCommand: ["bash","-x", "kraken2-build.sh"]         

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
    inputBinding:
      position: 1
  threads:
    type: int?
    inputBinding:
      position: 2
  references:
    type: File[]
    doc: List of genome references for kraken
    inputBinding:
      position: 10

outputs:
  kraken2_database: 
    type: Directory
    outputBinding:
      glob: k2_*


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
s:dateModified: 2025-03-03
s:dateCreated: 2022-01-01
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
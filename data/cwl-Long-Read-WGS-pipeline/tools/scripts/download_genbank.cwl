#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: custom GenBank downloading script

doc: A custom python script to download GenBank Files from accession numbers.

requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/wget:1.21.4
  NetworkAccess:
    networkAccess: true
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: staging_folder
        writable: true
        entry: $(null)
      - entryname: download_ncbi.sh
        entry: |-
          #!/bin/bash
          ID=$1 # NCBI identifier          
          echo "Downloading genome $ID from NCBI"
          wget "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=$ID&rettype=gbwithparts&retmode=text" -O "$ID.gb"

baseCommand: [ "bash", "download_ncbi.sh" ]

inputs:
  accession_number:
    type: string
    label: NCBI genome identifier
    doc: | 
      Required. NCBI accession number to download a GenBank file from.
    inputBinding: 
      position: 1

outputs:
  genbank_file:
    type: File
    label: downloaded GenBank File
    doc: The downloaded GenBank file.
    outputBinding:
      glob: "$(inputs.accession_number).gb"

$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-04-14"
s:dateModified: "2025-04-14"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"
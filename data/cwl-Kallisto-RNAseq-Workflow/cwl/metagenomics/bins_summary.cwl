#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "Bin assembly stats"

doc: |
    Table of all bins and there assembly statistics like size, N50, etc..
    + table of the bins and their respective assembly contigs names.

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
    - entry: "$({class: 'Directory', listing: []})"
      entryname: "Bins summary table"
      writable: true
    - entryname: script.sh
      entry: |-
        #!/bin/bash
        source /unlock/infrastructure/venv/bin/activate
        python3 /unlock/infrastructure/binaries/scripts/metagenomics/bins_summary.py $@


baseCommand: ["bash", "script.sh"] # see requirements

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used  
  bin_dir:
    type: Directory
    doc: Directory containing bins in fasta format from metagenomic binning
    label: Bins directory
    inputBinding:
      prefix: "--bin_dir"
  bin_depths:
    type: File
    doc: MetaBAT2 aggregateDepths file
    label: bin depths
    inputBinding:
      prefix: "--bin_depths"
  busco_dir:
    type: Directory 
    doc: Directory containing BUSCO reports
    label: BUSCO folder
    inputBinding:
      prefix: "--busco_dir"
  checkm:
    type: File
    doc: CheckM report file
    label: CheckM report
    inputBinding:
      prefix: "--checkm"

arguments:
  - prefix: "--output_file"
    valueFrom: $(inputs.identifier)_bins_summary.tsv

outputs:
  bins_summary:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_bins_summary.tsv
  bin_contigs:
    type: File
    outputBinding:
      glob: binContigs.tsv
      # outputEval: ${self[0].basename=inputs.identifier; return self;}
      

s:author:
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
s:dateCreated: "2021-00-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

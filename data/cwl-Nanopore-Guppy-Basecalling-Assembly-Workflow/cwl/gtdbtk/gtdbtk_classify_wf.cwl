#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "GTDBTK Classify Workflow"
 
doc: |
    Taxonomic genome classification workflow with GTDBTK. 
    !! Can use up to ~220GB RAM !!

baseCommand: ["bash", "script.sh"]

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "checkm_output"
        writable: true
      - entryname: script.sh
        entry: |-
          #!/bin/bash
          source /root/miniconda/bin/activate
          conda init bash
          conda activate /unlock/infrastructure/conda/gtdbtk_v1.7.0
          gtdbtk classify_wf $@

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used

  threads:
    type: int?
    label: Number of threads to use
    default: 8
    inputBinding:
      position: 0
      prefix: --cpus

  bin_dir:
    type: Directory
    doc: Directory containing bins in fasta format from metagenomic binning
    label: bins with directory
    inputBinding:
      position: 1
      prefix: --genome_dir

  fasta_extension: 
    type: string?
    label: fasta file extension
    inputBinding:
      position: 2
      prefix: --extension
    default: "fa"

arguments:
  - "--force"
  - prefix: "--prefix"
    valueFrom: $(inputs.identifier).gtdbtk
  - prefix: "--out_dir"
    valueFrom: $(inputs.identifier)_GTDB-Tk

stdout: $(inputs.identifier)_GTDB-Tk.stdout.log

outputs:
  gtdbtk_out_folder:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_GTDB-Tk
  gtdbtk_summary:
    type: File?
    outputBinding:
      glob: $(inputs.identifier)_GTDB-Tk/classify/$(inputs.identifier).gtdbtk.bac120.summary.tsv
  stdout_out:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_GTDB-Tk.stdout.log

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
s:dateModified: "2022-02-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
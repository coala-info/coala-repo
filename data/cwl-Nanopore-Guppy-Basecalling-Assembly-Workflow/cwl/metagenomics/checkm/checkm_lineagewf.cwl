#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "CheckM"

doc: |
    CheckM provides a set of tools for assessing the quality of genomes recovered from isolates, single cells, or metagenomes

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
          conda activate /unlock/infrastructure/conda/checkm_v1.1.3
          checkm lineage_wf $@

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used

  bin_dir:
    type: Directory
    doc: folder containing bins in fasta format from metagenomic binning
    label: bins folder

  threads:
    type: int?
    label: Number of threads to use
    default: 8
    inputBinding:
      position: 0
      prefix: -t

  fasta_extension: 
    type: string?
    label: fasta file extension
    inputBinding:
      position: 2
      prefix: -x
    default: "fa"

arguments:
  - "--reduced_tree"
  - prefix: "-f"
    valueFrom: $(inputs.identifier)_CheckM_report.txt
  - "$(inputs.bin_dir)"
  - "$(inputs.identifier)_checkm"

outputs:
  checkm_out_folder:
    type: Directory
    outputBinding:
      glob: $(inputs.identifier)_checkm
  checkm_out_table:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_CheckM_report.txt

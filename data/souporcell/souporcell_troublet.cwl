cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/troublet/target/release/troublet
label: souporcell_troublet
doc: "Intergenotypic doublet detection given cluster assignments and cell allele counts\n\nTool homepage: https://github.com/wheaton5/souporcell"
inputs:
  - id: alts
    type: File
    doc: "alt allele counts per cell in sparse matrix format out of vartrix"
    inputBinding:
      position: 11
      prefix: --alts
  - id: refs
    type: File
    doc: "ref allele counts per cell in sparse matrix format out of vartrix"
    inputBinding:
      position: 11
      prefix: --refs
  - id: clusters
    type: File
    doc: "cluster file output from souporcell"
    inputBinding:
      position: 11
      prefix: --clusters
  - id: debug
    type:
      - 'null'
      - type: array
        items: int
    doc: "print debug info for index of cells listed"
    inputBinding:
      position: 11
      prefix: --debug
  - id: doublet_prior
    type:
      - 'null'
      - float
    doc: "prior on doublets. Defaults to 0.5"
    inputBinding:
      position: 11
      prefix: --doublet_prior
  - id: doublet_threshold
    type:
      - 'null'
      - float
    doc: "doublet posterior threshold, defaults to 0.90"
    inputBinding:
      position: 11
      prefix: --doublet_threshold
  - id: singlet_threshold
    type:
      - 'null'
      - float
    doc: "singlet posterior threshold, defaults to 0.90"
    inputBinding:
      position: 11
      prefix: --singlet_threshold
outputs:
  - id: doublets
    type: stdout
    doc: Cluster assignments with doublet calls (stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
stdout: souporcell_doublets.tsv

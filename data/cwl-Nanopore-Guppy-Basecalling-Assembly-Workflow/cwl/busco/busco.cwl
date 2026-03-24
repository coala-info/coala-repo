#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

baseCommand: ["bash", "script.sh"]

label: "BUSCO"
doc: |
    Based on evolutionarily-informed expectations of gene content of near-universal single-copy orthologs, 
    BUSCO metric is complementary to technical metrics like N50.
        
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: "busco_output"
        writable: true
      - entryname: script.sh
        entry: |-
          #!/bin/bash
          source /root/miniconda/bin/activate
          conda init bash
          conda activate /unlock/infrastructure/conda/busco_v5.2.2
          busco $@
          # always exit 0 when failed to find genes.
          exit 0

inputs:
  threads:
    type: int
    label: Number of threads
    default: 1
    inputBinding:
      prefix: --cpu

  sequence_file:
    type: File
    label: Input fasta file
    doc: Input sequence file in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set. Also possible to use a path to a directory containing multiple input files.
    inputBinding:
        prefix: --in

  dataset:
    type: string
    label: Dataset location
    doc: Specify local filepath for storing or finding BUSCO dataset downloads
    inputBinding:
      prefix: --download_path  
  offline:
    type: boolean
    label: Offline
    doc: Run BUSCO in offline mode. Does not download datasets
    default: true
    inputBinding:
      prefix: --offline

  mode:
    type: string
    label: Input molecule type
    doc: |
      Specify which BUSCO analysis mode to run.
      There are three valid modes:
      - geno or genome, for genome assemblies (DNA)
      - tran or transcriptome, for transcriptome assemblies (DNA)
      - prot or proteins, for annotated gene sets (protein)
    inputBinding:
        prefix: --mode

  lineage:
    type: string?
    label: Lineage
    doc: Specify the name of the BUSCO lineage to be used.
    inputBinding:
        prefix: -l
  
  auto-lineage-prok:
    type: boolean?
    label: Prokaryote auto-lineage detection
    doc: Run auto-lineage just on non-eukaryote trees to find optimum lineage path.
    inputBinding:
      prefix: --auto-lineage-prok

  auto-lineage-euk:
    type: boolean?
    label: Eukaryote auto-lineage detection
    doc: Run auto-placement just on eukaryote tree to find optimum lineage path.
    inputBinding:
      prefix: --auto-lineage-euk

  identifier:
    type: string
    label: Name of the output file
    doc: Give your analysis run a recognisable short name. Output folders and files will be labelled with this name.
    inputBinding:
        prefix: --out
  
  tar_output:
    type: boolean
    label: Compress output
    doc: Compress some subdirectories with many files to save space
    default: true
    inputBinding:
        prefix: --tar

outputs:
  logs:
    label: BUSCO logs folder
    type: Directory?
    outputBinding:
      glob: $(inputs.identifier)/logs
  run_folders:
    label: run_*_odb10 folders
    type: Directory[]?
    outputBinding:
      glob: $(inputs.identifier)/run_*
  short_summaries:
    label: BUSCO short summary files
    type: File[]?
    outputBinding:
      glob: $(inputs.identifier)/short_summary.*      

s:author:
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
s:dateCreated: "2022-01-01"
s:dateModified: "2022-02-28"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/

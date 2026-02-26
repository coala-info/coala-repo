cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pycistopic
  - tss
label: pycistopic_tss
doc: "TSS: List of TSS subcommands.\n\nTool homepage: https://github.com/aertslab/pycistopic"
inputs:
  - id: subcommand
    type: string
    doc: List of TSS subcommands.
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected TSS subcommand.
    inputBinding:
      position: 2
  - id: gene_annotation_list
    type:
      - 'null'
      - boolean
    doc: Get list of all Ensembl BioMart gene annotation names.
    inputBinding:
      position: 103
  - id: get_ncbi_acc
    type:
      - 'null'
      - boolean
    doc: Get NCBI assembly accession numbers and assembly names for a certain 
      species.
    inputBinding:
      position: 103
  - id: get_ncbi_chrom_sizes_and_alias_mapping
    type:
      - 'null'
      - boolean
    doc: Get chromosome sizes and alias mapping from NCBI sequence reports.
    inputBinding:
      position: 103
  - id: get_tss
    type:
      - 'null'
      - boolean
    doc: Get TSS gene annotation from Ensembl BioMart.
    inputBinding:
      position: 103
  - id: get_ucsc_chrom_sizes_and_alias_mapping
    type:
      - 'null'
      - boolean
    doc: Get chromosome sizes and alias mapping from UCSC.
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
stdout: pycistopic_tss.out

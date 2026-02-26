cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phu
  - cluster
label: phu_cluster
doc: "Sequence clustering wrapper around external 'vclust' with three modes.\n\nTool
  homepage: https://github.com/camilogarciabotero/phu"
inputs:
  - id: input_contigs
    type: File
    doc: Input FASTA
    inputBinding:
      position: 101
      prefix: --input-contigs
  - id: mode
    type: string
    doc: dereplication | votu | species
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: clustered-contigs
    inputBinding:
      position: 101
      prefix: --output-folder
  - id: threads
    type:
      - 'null'
      - int
    doc: 0=all cores; otherwise N threads
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
  - id: vclust_params
    type:
      - 'null'
      - string
    doc: 'Custom vclust parameters: "--min-kmers 20 --outfmt lite --ani 0.97"'
    inputBinding:
      position: 101
      prefix: --vclust-params
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phu:0.4.4--pyhdfd78af_0
stdout: phu_cluster.out

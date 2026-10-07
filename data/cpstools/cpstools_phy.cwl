cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpstools
  - phy
label: cpstools_phy
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        writable: true
doc: "Phylogenetic analysis tools\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_dir
    type: Directory
    doc: Input the directory of genbank files
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: mode
    type:
      type: enum
      symbols:
        - cds
        - pro
    doc: 'Mode: cds for common cds sequences; pro for common protein sequences'
    inputBinding:
      position: 101
      prefix: --mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: gene_list
    type: File
    doc: Names of the common genes (cds_gene.txt or pro_gene.txt)
    outputBinding:
      glob: $(inputs.mode)_gene.txt
  - id: phy_dir
    type: Directory
    doc: Per-genome fasta files and the merged (and for pro, aligned) fasta, written inside the input folder
    outputBinding:
      glob: $(inputs.input_dir.basename)/$(inputs.mode)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_phy.out

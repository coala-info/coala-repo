cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpstools
  - Pi
label: cpstools_Pi
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.work_dir)
doc: "Calculate pairwise pi values for a set of sequences.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: mafft_path
    type:
      - 'null'
      - string
    doc: Path to MAFFT executable if not in environment path
    inputBinding:
      position: 101
      prefix: --mafft_path
  - id: work_dir
    type: Directory
    doc: Input directory of genbank files
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: common_gene_dir
    type: ['null', Directory]
    doc: Unaligned common gene sequences
    outputBinding:
      glob: common_gene
  - id: igs_dir
    type: ['null', Directory]
    doc: Intergenic spacer sequences and common IGS files
    outputBinding:
      glob: IGS
  - id: align_gene_dir
    type: ['null', Directory]
    doc: Aligned common genes with Pi_results.txt
    outputBinding:
      glob: align_gene
  - id: align_igs_dir
    type: ['null', Directory]
    doc: Aligned common IGS with Pi_results.txt
    outputBinding:
      glob: align_IGS
  - id: gene_cp_sort
    type: ['null', File]
    doc: Common gene names in chloroplast order
    outputBinding:
      glob: gene_cp_sort.txt
  - id: pi_sorted
    type: File[]
    doc: Pi values sorted in chloroplast order
    outputBinding:
      glob: '*/*_sort_as_cp_order.txt'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_Pi.out

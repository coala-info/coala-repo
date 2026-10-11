cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ntsmSiteGen
label: ntsm_ntsmSiteGen
doc: "Generate k-mer sites (generate-sites) from a reference FASTA and a VCF of SNP
  variants, or a PCA rotation matrix (generate-pca-rot-mat) from a multi-sample VCF.
  ntsmSiteGen is a makefile driver; parameters are given as key=value words.\n\nTool
  homepage: https://github.com/JustinChu/ntsm"
inputs:
  - id: target
    type: string
    doc: Make target, generate-sites or generate-pca-rot-mat
    inputBinding:
      position: 1
  - id: name
    type: string
    doc: Output file prefix (required)
    inputBinding:
      position: 2
      prefix: name=
      separate: false
  - id: ref
    type:
      - 'null'
      - File
    doc: FASTA reference file (required for generate-sites)
    inputBinding:
      position: 3
      prefix: ref=
      separate: false
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file containing variants (required for generate-sites)
    inputBinding:
      position: 4
      prefix: vcf=
      separate: false
  - id: multivcf
    type:
      - 'null'
      - File
    doc: Multi-sample VCF file containing genotypes (required for
      generate-pca-rot-mat)
    inputBinding:
      position: 5
      prefix: multivcf=
      separate: false
  - id: sites
    type:
      - 'null'
      - File
    doc: Sites FASTA used for generate-pca-rot-mat
    inputBinding:
      position: 6
      prefix: sites=
      separate: false
  - id: window
    type:
      - 'null'
      - int
    doc: Window size to consider sequences in the region
    inputBinding:
      position: 7
      prefix: w=
      separate: false
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size used in the window region
    inputBinding:
      position: 8
      prefix: k=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for any subprocess or tool
    inputBinding:
      position: 9
      prefix: t=
      separate: false
  - id: dims
    type:
      - 'null'
      - int
    doc: Number of PCA dimensions for generate-pca-rot-mat
    inputBinding:
      position: 10
      prefix: dims=
      separate: false
outputs:
  - id: site_files
    type: File[]
    doc: Generated sites and PCA files
    outputBinding:
      glob:
        - $(inputs.name)_n*.fa
        - $(inputs.name)_rotationalMatrix.tsv
        - $(inputs.name)_matrix.tsv
        - $(inputs.name)_center.txt
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
stdout: ntsm_ntsmSiteGen.out

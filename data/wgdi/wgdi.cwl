cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgdi
label: wgdi
doc: "WGDI(Whole-Genome Duplication Integrated): A user-friendly toolkit for evolutionary
  analyses of whole-genome duplications and ancestral karyotypes.\n\nTool homepage:
  https://github.com/SunPengChuan/wgdi"
inputs:
  - id: alignment
    type:
      - 'null'
      - string
    doc: Show event-related genomic alignment in a dotplot
    inputBinding:
      position: 101
      prefix: -a
  - id: alignment_trees
    type:
      - 'null'
      - string
    doc: Collinear genes construct phylogenetic trees
    inputBinding:
      position: 101
      prefix: -at
  - id: ancestral_karyotype
    type:
      - 'null'
      - string
    doc: Generation of ancestral karyotypes from chromosomes that retain same 
      structures in genomes
    inputBinding:
      position: 101
      prefix: -ak
  - id: ancestral_karyotype_repertoire
    type:
      - 'null'
      - string
    doc: Incorporate genes from collinearity blocks into the ancestral karyotype
      repertoire
    inputBinding:
      position: 101
      prefix: -akr
  - id: block_info
    type:
      - 'null'
      - string
    doc: Collinearity and Ks speculate whole genome duplication
    inputBinding:
      position: 101
      prefix: -bi
  - id: blockks
    type:
      - 'null'
      - string
    doc: Show Ks of blocks in a dotplot
    inputBinding:
      position: 101
      prefix: -bk
  - id: calks
    type:
      - 'null'
      - string
    doc: Calculate Ka/Ks for homologous gene pairs by YN00
    inputBinding:
      position: 101
      prefix: -ks
  - id: circos
    type:
      - 'null'
      - string
    doc: A simple way to run circos
    inputBinding:
      position: 101
      prefix: -ci
  - id: configure
    type:
      - 'null'
      - string
    doc: Display and modify the environment variable
    inputBinding:
      position: 101
      prefix: -conf
  - id: correspondence
    type:
      - 'null'
      - string
    doc: Extract event-related genomic alignment
    inputBinding:
      position: 101
      prefix: -c
  - id: dotplot
    type:
      - 'null'
      - string
    doc: Show homologous gene dotplot
    inputBinding:
      position: 101
      prefix: -d
  - id: fusion_positions_database
    type:
      - 'null'
      - string
    doc: Extract the fusion positions dataset
    inputBinding:
      position: 101
      prefix: -fpd
  - id: fusions_detection
    type:
      - 'null'
      - string
    doc: Determine whether these fusion events occur in other genomes
    inputBinding:
      position: 101
      prefix: -fd
  - id: improved_collinearity
    type:
      - 'null'
      - string
    doc: Improved version of ColinearScan
    inputBinding:
      position: 101
      prefix: -icl
  - id: karyotype
    type:
      - 'null'
      - string
    doc: Show genome evolution from reconstructed ancestors
    inputBinding:
      position: 101
      prefix: -k
  - id: karyotype_mapping
    type:
      - 'null'
      - string
    doc: Mapping from the known karyotype result to this species
    inputBinding:
      position: 101
      prefix: -km
  - id: ks_figure
    type:
      - 'null'
      - string
    doc: A simple way to draw ks distribution map
    inputBinding:
      position: 101
      prefix: -kf
  - id: kspeaks
    type:
      - 'null'
      - string
    doc: A simple way to get ks peaks
    inputBinding:
      position: 101
      prefix: -kp
  - id: peaks_fit
    type:
      - 'null'
      - string
    doc: Gaussian fitting of ks distribution
    inputBinding:
      position: 101
      prefix: -pf
  - id: pindex
    type:
      - 'null'
      - string
    doc: Polyploidy-index characterize the degree of divergence between 
      subgenomes of a polyploidy
    inputBinding:
      position: 101
      prefix: -p
  - id: ploidy_classification
    type:
      - 'null'
      - string
    doc: Polyploid distinguish among subgenomes
    inputBinding:
      position: 101
      prefix: -pc
  - id: retain
    type:
      - 'null'
      - string
    doc: Show subgenomes in gene retention or genome fractionation
    inputBinding:
      position: 101
      prefix: -r
  - id: shared_fusion
    type:
      - 'null'
      - string
    doc: Quickly find shared fusions between species
    inputBinding:
      position: 101
      prefix: -sf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgdi:0.75--pyhdfd78af_0
stdout: wgdi.out

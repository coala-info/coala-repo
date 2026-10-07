cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run-HLA
label: bwakit_run-HLA
doc: "Run HLA typing (typeHLA.sh) on every <prefix>.HLA-*.fq file and print the best
  genotype of each gene.\n\nTool homepage: https://github.com/lh3/bwa/tree/master/bwakit"
inputs:
  - id: contigs_input
    type:
      - 'null'
      - boolean
    doc: the input files hold assembled contigs, so skip de novo assembly
    inputBinding:
      position: 1
      prefix: -A
  - id: prefix
    type: string
    doc: prefix of the input files <prefix>.HLA-<gene>.fq and of the output files
    inputBinding:
      position: 2
  - id: hla_fastqs
    type: File[]
    doc: per-gene HLA reads named <prefix>.HLA-<gene>.fq (from bwa-postalt.js -p)
outputs:
  - id: top_genotypes
    type: stdout
    doc: best genotype of each HLA gene
  - id: genotypes
    type: File[]
    doc: all genotype calls per gene (<prefix>.HLA-*.gt)
    outputBinding:
      glob: $(inputs.prefix).HLA-*.gt
  - id: contigs
    type: File[]
    doc: de novo assembled contigs per gene (<prefix>.HLA-*.mag.gz)
    outputBinding:
      glob: $(inputs.prefix).HLA-*.mag.gz
  - id: exon_to_contig_sams
    type: File[]
    doc: HLA exons mapped to the selected contigs per gene (<prefix>.HLA-*.sam.gz)
    outputBinding:
      glob: $(inputs.prefix).HLA-*.sam.gz
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.hla_fastqs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwakit:0.7.18.dev1--hdfd78af_0
stdout: bwakit_run-HLA.top

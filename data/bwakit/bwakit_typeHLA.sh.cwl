cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - typeHLA.sh
label: bwakit_typeHLA.sh
doc: "Type one HLA gene: de novo assemble the reads in <prefix>.<gene>.fq, select contigs
  overlapping the gene's exons, map the exon sequences to them and call genotypes into
  <prefix>.<gene>.gt. Without -A the script ends with exit status 1 even after a
  successful run (its last line is a failed test), so exit status 1 is accepted.\n\nTool homepage: https://github.com/lh3/bwa/tree/master/bwakit"
inputs:
  - id: contigs_input
    type:
      - 'null'
      - boolean
    doc: the input file holds assembled contigs, so skip de novo assembly
    inputBinding:
      position: 1
      prefix: -A
  - id: prefix
    type: string
    doc: prefix of the input file <prefix>.<gene>.fq and of the output files
    inputBinding:
      position: 2
  - id: gene
    type: string
    doc: HLA gene name, for example HLA-A
    inputBinding:
      position: 3
  - id: hla_fastq
    type: File
    doc: reads (or contigs with -A) of the gene; staged as <prefix>.<gene>.fq
outputs:
  - id: genotypes
    type: File
    doc: HLA genotype calls (<prefix>.<gene>.gt)
    outputBinding:
      glob: $(inputs.prefix).$(inputs.gene).gt
  - id: contigs
    type:
      - 'null'
      - File
    doc: de novo assembled contigs (<prefix>.<gene>.mag.gz)
    outputBinding:
      glob: $(inputs.prefix).$(inputs.gene).mag.gz
  - id: exon_to_contig_sam
    type:
      - 'null'
      - File
    doc: HLA exons mapped to the selected contigs (<prefix>.<gene>.sam.gz)
    outputBinding:
      glob: $(inputs.prefix).$(inputs.gene).sam.gz
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.prefix).$(inputs.gene).fq
        entry: $(inputs.hla_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwakit:0.7.18.dev1--hdfd78af_0
successCodes:
  - 0
  - 1

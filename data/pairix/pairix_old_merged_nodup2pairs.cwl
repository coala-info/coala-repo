cwlVersion: v1.2
class: CommandLineTool
baseCommand: old_merged_nodup2pairs.pl
label: pairix_old_merged_nodup2pairs
doc: "old-format merged_nodups.txt to 4DN pairs converter. Writes <outprefix>.bsorted.pairs.gz and its .px2 index (requires sort and
  bgzip).\n\nTool homepage: https://github.com/4dn-dcic/pairix"
inputs:
  - id: split_sort
    type:
      - 'null'
      - int
    doc: Number of chunks to split the input into before sorting
    inputBinding:
      position: 1
      prefix: --split_sort
  - id: mapq
    type:
      - 'null'
      - int
    doc: Maximum MAPQ of the removed reads; reads with MAPQ up to this value are removed
    inputBinding:
      position: 2
      prefix: --mapq
  - id: input_file
    type: File
    doc: Input merged_nodups.txt (old Juicer format)
    inputBinding:
      position: 3
  - id: chrom_size
    type: File
    doc: Chromosome size file (chromosome name and length, whitespace separated)
    inputBinding:
      position: 4
  - id: outprefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 5
outputs:
  - id: pairs
    type: File
    doc: Bgzipped pairs file
    secondaryFiles:
      - .px2
    outputBinding:
      glob: $(inputs.outprefix).bsorted.pairs.gz
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0

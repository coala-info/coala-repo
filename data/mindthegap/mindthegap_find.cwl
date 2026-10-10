cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MindTheGap
  - find
label: mindthegap_find
doc: "MindTheGap find: insertion breakpoint detection. Writes <out>.h5 (de Bruijn
  graph), <out>.breakpoints and <out>.othervariants.vcf.\n\nTool homepage: https://github.com/GATB/mindthegap"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Input read file(s)
    inputBinding:
      position: 1
      prefix: -in
      itemSeparator: ','
  - id: graph
    type:
      - 'null'
      - File
    doc: Input graph file (likely a hdf5 file)
    inputBinding:
      position: 1
      prefix: -graph
  - id: ref
    type: File
    doc: Reference genome file
    inputBinding:
      position: 1
      prefix: -ref
  - id: bed
    type:
      - 'null'
      - File
    doc: Bed file to restrict breakpoint search in specific regions
    inputBinding:
      position: 1
      prefix: -bed
  - id: out_tmp
    type:
      - 'null'
      - string
    doc: Prefix for output temporary files (default '.')
    inputBinding:
      position: 1
      prefix: -out-tmp
  - id: out_prefix
    type:
      - 'null'
      - string
    default: mindthegap_find
    doc: Prefix for output files
    inputBinding:
      position: 1
      prefix: -out
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of a kmer (default 31)
    inputBinding:
      position: 1
      prefix: -kmer-size
  - id: abundance_min
    type:
      - 'null'
      - string
    doc: Minimal abundance threshold for solid kmers (default 'auto')
    inputBinding:
      position: 1
      prefix: -abundance-min
  - id: abundance_max
    type:
      - 'null'
      - int
    doc: Maximal abundance threshold for solid kmers (default 2147483647)
    inputBinding:
      position: 1
      prefix: -abundance-max
  - id: homo_only
    type:
      - 'null'
      - boolean
    doc: Search only homozygous breakpoints
    inputBinding:
      position: 1
      prefix: -homo-only
  - id: max_rep
    type:
      - 'null'
      - int
    doc: Maximal repeat size detected for fuzzy sites (default 5)
    inputBinding:
      position: 1
      prefix: -max-rep
  - id: het_max_occ
    type:
      - 'null'
      - int
    doc: Maximal number of occurrences of a kmer in the reference genome allowed
      for heterozyguous breakpoints (default 1)
    inputBinding:
      position: 1
      prefix: -het-max-occ
  - id: insert_only
    type:
      - 'null'
      - boolean
    doc: Search only insertion breakpoints (do not report other variants)
    inputBinding:
      position: 1
      prefix: -insert-only
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: Number of cores (default 0 = all)
    inputBinding:
      position: 1
      prefix: -nb-cores
  - id: max_disk
    type:
      - 'null'
      - int
    doc: Max disk for graph building (in MBytes)
    inputBinding:
      position: 1
      prefix: -max-disk
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Max memory for graph building (in MBytes) (default 2000)
    inputBinding:
      position: 1
      prefix: -max-memory
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbosity level (default 1)
    inputBinding:
      position: 1
      prefix: -verbose
outputs:
  - id: graph_h5
    type:
      - 'null'
      - File
    doc: De Bruijn graph
    outputBinding:
      glob: $(inputs.out_prefix).h5
  - id: breakpoints
    type:
      - 'null'
      - File
    doc: Breakpoints of insertion variants
    outputBinding:
      glob: $(inputs.out_prefix).breakpoints
  - id: other_variants
    type:
      - 'null'
      - File
    doc: SNPs and deletion variants
    outputBinding:
      glob: $(inputs.out_prefix).othervariants.vcf
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindthegap:2.3.0--h5ca1c30_6
stdout: mindthegap_find.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MindTheGap
  - fill
label: mindthegap_fill
doc: "MindTheGap fill: gap-filler or insertion assembly. Writes <out>.insertions.fasta,
  <out>.info.txt and, in contig mode, <out>.gfa.\n\nTool homepage: https://github.com/GATB/mindthegap"
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
  - id: contig
    type:
      - 'null'
      - File
    doc: Contig file
    inputBinding:
      position: 1
      prefix: -contig
  - id: bkpt
    type:
      - 'null'
      - File
    doc: Breakpoint file
    inputBinding:
      position: 1
      prefix: -bkpt
  - id: out_prefix
    type:
      - 'null'
      - string
    default: mindthegap_fill
    doc: Prefix for output files
    inputBinding:
      position: 1
      prefix: -out
  - id: overlap
    type:
      - 'null'
      - int
    doc: Overlap between input contigs (default, ie. 0 = kmer size)
    inputBinding:
      position: 1
      prefix: -overlap
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Do not output low quality insertions (bkpt mode)
    inputBinding:
      position: 1
      prefix: -filter
  - id: extend
    type:
      - 'null'
      - boolean
    doc: Output first-contig extensions of failed gap-fillings in a separate file
    inputBinding:
      position: 1
      prefix: -extend
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
  - id: max_nodes
    type:
      - 'null'
      - int
    doc: Maximum number of nodes in contig graph (nt) (default 100)
    inputBinding:
      position: 1
      prefix: -max-nodes
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length of insertions (nt) (default 10000)
    inputBinding:
      position: 1
      prefix: -max-length
  - id: fwd_only
    type:
      - 'null'
      - boolean
    doc: Do not try in reverse direction if no inserted sequence is assembled
      (bkpt mode)
    inputBinding:
      position: 1
      prefix: -fwd-only
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
  - id: insertions_fasta
    type:
      - 'null'
      - File
    doc: Assembled insertion / gap-filling sequences
    outputBinding:
      glob: $(inputs.out_prefix).insertions.fasta
  - id: insertions_vcf
    type:
      - 'null'
      - File
    doc: Insertion variants in VCF format (breakpoint mode)
    outputBinding:
      glob: $(inputs.out_prefix).insertions.vcf
  - id: info
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.out_prefix).info.txt
  - id: gfa
    type:
      - 'null'
      - File
    doc: Genome graph (contig mode)
    outputBinding:
      glob: $(inputs.out_prefix).gfa
  - id: extensions
    type:
      - 'null'
      - File
    doc: First-contig extensions of failed gap-fillings (with extend)
    outputBinding:
      glob: $(inputs.out_prefix).extensions.fasta
  - id: graph_h5
    type:
      - 'null'
      - File
    doc: De Bruijn graph
    outputBinding:
      glob: $(inputs.out_prefix).h5
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindthegap:2.3.0--h5ca1c30_6
stdout: mindthegap_fill.out

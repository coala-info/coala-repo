cwlVersion: v1.2
class: CommandLineTool
baseCommand: [Bifrost, build]
label: bifrost_build
doc: "Build a compacted de Bruijn graph, with or without colors\n\nTool homepage: https://github.com/pmelsted/bifrost"
inputs:
  - id: input_seq_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -s
    doc: Input sequence files in fasta/fastq(.gz) format (or a text file listing them); k-mers seen once
      are discarded
    inputBinding:
      position: 1
  - id: input_ref_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -r
    doc: Input reference files in fasta/fastq(.gz) or gfa(.gz) format (or a text file listing them); all
      k-mers are used
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Prefix for output file(s)
    inputBinding:
      position: 1
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default: 1)'
    inputBinding:
      position: 1
      prefix: -t
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'Length of k-mers (default: 31)'
    inputBinding:
      position: 1
      prefix: -k
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Length of minimizers (default: auto)'
    inputBinding:
      position: 1
      prefix: -m
  - id: bloom_bits
    type:
      - 'null'
      - int
    doc: 'Number of Bloom filter bits per k-mer (default: 24)'
    inputBinding:
      position: 1
      prefix: -B
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: 'Path for tmp directory (default: creates tmp directory in output directory)'
    inputBinding:
      position: 1
      prefix: -T
  - id: load_mbbf
    type:
      - 'null'
      - File
    doc: Input Blocked Bloom Filter file, skips filtering step
    inputBinding:
      position: 1
      prefix: -l
  - id: write_mbbf
    type:
      - 'null'
      - string
    doc: 'Output Blocked Bloom Filter file name (default: no output)'
    inputBinding:
      position: 1
      prefix: -w
  - id: colors
    type:
      - 'null'
      - boolean
    doc: Color the compacted de Bruijn graph
    inputBinding:
      position: 1
      prefix: -c
  - id: clip_tips
    type:
      - 'null'
      - boolean
    doc: Clip tips shorter than k k-mers in length
    inputBinding:
      position: 1
      prefix: -i
  - id: del_isolated
    type:
      - 'null'
      - boolean
    doc: Delete isolated contigs shorter than k k-mers in length
    inputBinding:
      position: 1
      prefix: -d
  - id: fasta_out
    type:
      - 'null'
      - boolean
    doc: Output file in fasta format (only sequences) instead of gfa (unless graph is colored)
    inputBinding:
      position: 1
      prefix: -f
  - id: bfg_out
    type:
      - 'null'
      - boolean
    doc: Output file in bfg/bfi format (Bifrost graph/index) instead of gfa (unless graph is colored)
    inputBinding:
      position: 1
      prefix: -b
  - id: no_compress_out
    type:
      - 'null'
      - boolean
    doc: Output files must be uncompressed
    inputBinding:
      position: 1
      prefix: -n
  - id: no_index_out
    type:
      - 'null'
      - boolean
    doc: Do not make index file
    inputBinding:
      position: 1
      prefix: -N
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information messages during execution
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: graph
    type:
      - 'null'
      - File
    doc: Output graph (gfa, fasta or bfg, optionally gzipped)
    outputBinding:
      glob:
        - $(inputs.output_file).gfa
        - $(inputs.output_file).gfa.gz
        - $(inputs.output_file).fasta
        - $(inputs.output_file).fasta.gz
        - $(inputs.output_file).bfg
  - id: index
    type:
      - 'null'
      - File
    doc: Graph index file (bfi format)
    outputBinding:
      glob: $(inputs.output_file).bfi
  - id: color_file
    type:
      - 'null'
      - File
    doc: Color file of a colored graph (bfg_colors or color.bfg format)
    outputBinding:
      glob:
        - $(inputs.output_file).bfg_colors
        - $(inputs.output_file).color.bfg
  - id: mbbf
    type:
      - 'null'
      - File
    doc: Blocked Bloom Filter file written with -w
    outputBinding:
      glob: $(inputs.write_mbbf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost:1.3.5--h5ca1c30_3

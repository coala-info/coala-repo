cwlVersion: v1.2
class: CommandLineTool
baseCommand: vg construct
label: vg_construct
doc: "Construct a variation graph from reference and variant calls or a multiple sequence
  alignment.\n\nTool homepage: https://github.com/vgteam/vg"
inputs:
  - id: alt_paths
    type:
      - 'null'
      - boolean
    doc: save paths for alts of variants by SHA1 hash
    inputBinding:
      position: 101
      prefix: --alt-paths
  - id: alt_paths_plain
    type:
      - 'null'
      - boolean
    doc: save paths for alts of variants by variant ID if possible, otherwise 
      SHA1 (IDs must be unique across all input VCFs)
    inputBinding:
      position: 101
      prefix: --alt-paths-plain
  - id: drop_msa_paths
    type:
      - 'null'
      - boolean
    doc: don't add paths for the MSA sequences into the graph
    inputBinding:
      position: 101
      prefix: --drop-msa-paths
  - id: flat_alts
    type:
      - 'null'
      - boolean
    doc: don't chop up alternate alleles from input VCF
    inputBinding:
      position: 101
      prefix: --flat-alts
  - id: handle_sv
    type:
      - 'null'
      - boolean
    doc: include structural variants in construction of graph.
    inputBinding:
      position: 101
      prefix: --handle-sv
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: construct entire graph in memory before outputting it
    inputBinding:
      position: 101
      prefix: --in-memory
  - id: insertions
    type:
      - 'null'
      - File
    doc: a FASTA file containing insertion sequences (referred to in VCF) to add
      to graph.
    inputBinding:
      position: 101
      prefix: --insertions
  - id: msa
    type:
      - 'null'
      - File
    doc: input multiple sequence alignment
    inputBinding:
      position: 101
      prefix: --msa
  - id: msa_format
    type:
      - 'null'
      - string
    doc: format of the MSA file {fasta,clustal}
    default: fasta
    inputBinding:
      position: 101
      prefix: --msa-format
  - id: no_trim_indels
    type:
      - 'null'
      - boolean
    doc: don't remove the 1bp ref base from indel alt alleles
    inputBinding:
      position: 101
      prefix: --no-trim-indels
  - id: node_max
    type:
      - 'null'
      - int
    doc: "limit maximum allowable node sequence size (nodes greater than this threshold
      will be divided, note: nodes larger than ~1024 bp can't be GCSA2-indexed)"
    default: 32
    inputBinding:
      position: 101
      prefix: --node-max
  - id: parse_max
    type:
      - 'null'
      - int
    doc: don't chop up alternate alleles from input VCF longer than N
    default: 100
    inputBinding:
      position: 101
      prefix: --parse-max
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 101
      prefix: --progress
  - id: reference
    type:
      - 'null'
      - type: array
        items: File
    doc: input FASTA reference (may repeat)
    inputBinding:
      position: 101
      prefix: --reference
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: specify a VCF contig name or 1-based inclusive region (may repeat, if 
      on different contigs)
    inputBinding:
      position: 101
      prefix: --region
  - id: region_is_chrom
    type:
      - 'null'
      - boolean
    doc: don't attempt to parse the regions (use when reference sequence name 
      could be parsed as a region)
    inputBinding:
      position: 101
      prefix: --region-is-chrom
  - id: region_size
    type:
      - 'null'
      - int
    doc: variants per region to parallelize
    default: 1024
    inputBinding:
      position: 101
      prefix: --region-size
  - id: rename
    type:
      - 'null'
      - type: array
        items: string
    doc: match contig V in the VCFs to contig F in the FASTAs (may repeat)
    inputBinding:
      position: 101
      prefix: --rename
  - id: threads
    type:
      - 'null'
      - int
    doc: use N threads to construct graph
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: input VCF (may repeat)
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
stdout: vg_construct.out

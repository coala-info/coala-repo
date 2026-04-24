cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/pggb
label: pggb
doc: "Use wfmash, seqwish, smoothxg, odgi, gfaffix, and vg to build, project and display
  a pangenome graph.\n\nTool homepage: https://github.com/pangenome/pggb"
inputs:
  - id: block_length
    type:
      - 'null'
      - string
    doc: minimum block length filter for mapping
    inputBinding:
      position: 101
      prefix: --block-length
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress alignment (.paf), graph (.gfa, .og), and MSA (.maf) outputs 
      with pigz, and variant (.vcf) outputs with bgzip
    inputBinding:
      position: 101
      prefix: --compress
  - id: consensus_prefix
    type:
      - 'null'
      - string
    doc: use this prefix for consensus path names
    inputBinding:
      position: 101
      prefix: --consensus-prefix
  - id: edge_jump_max
    type:
      - 'null'
      - int
    doc: maximum edge jump before breaking
    inputBinding:
      position: 101
      prefix: --edge-jump-max
  - id: exclude_delim
    type:
      - 'null'
      - string
    doc: skip mappings when the query and target have the same prefix before the
      last occurrence of the given character C
    inputBinding:
      position: 101
      prefix: --exclude-delim
  - id: global_poa
    type:
      - 'null'
      - boolean
    doc: run the POA in global mode
    inputBinding:
      position: 101
      prefix: --global-poa
  - id: hg_filter_ani_diff
    type:
      - 'null'
      - string
    doc: filter out mappings unlikely to be N% less than the best mapping
    inputBinding:
      position: 101
      prefix: --hg-filter-ani-diff
  - id: input_fasta
    type: File
    doc: input FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: input_paf
    type:
      - 'null'
      - File
    doc: input PAF file; the wfmash alignment step is skipped
    inputBinding:
      position: 101
      prefix: --input-paf
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: keep intermediate graphs
    inputBinding:
      position: 101
      prefix: --keep-temp-files
  - id: map_pct_id
    type:
      - 'null'
      - float
    doc: percent identity for mapping/alignment
    inputBinding:
      position: 101
      prefix: --map-pct-id
  - id: mash_kmer
    type:
      - 'null'
      - int
    doc: kmer size for mapping
    inputBinding:
      position: 101
      prefix: --mash-kmer
  - id: mash_kmer_thres
    type:
      - 'null'
      - float
    doc: ignore the top % most-frequent kmers
    inputBinding:
      position: 101
      prefix: --mash-kmer-thres
  - id: min_match_len
    type:
      - 'null'
      - int
    doc: filter exact matches below this length
    inputBinding:
      position: 101
      prefix: --min-match-len
  - id: multiqc
    type:
      - 'null'
      - boolean
    doc: generate MultiQC report of graphs' statistics and visualizations, 
      automatically runs odgi stats
    inputBinding:
      position: 101
      prefix: --multiqc
  - id: n_haplotypes
    type:
      - 'null'
      - int
    doc: number of haplotypes
    inputBinding:
      position: 101
      prefix: --n-haplotypes
  - id: n_mappings
    type:
      - 'null'
      - int
    doc: number of mappings for each segment
    inputBinding:
      position: 101
      prefix: --n-mappings
  - id: names_with_params
    type:
      - 'null'
      - boolean
    doc: put parameter values in filenames, instead of hashes
    inputBinding:
      position: 101
      prefix: --names-with-params
  - id: no_splits
    type:
      - 'null'
      - boolean
    doc: disable splitting of input sequences during mapping
    inputBinding:
      position: 101
      prefix: --no-splits
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: pad_max_depth
    type:
      - 'null'
      - int
    doc: depth/haplotype at which we don't pad the POA problem
    inputBinding:
      position: 101
      prefix: --pad-max-depth
  - id: path_jump_max
    type:
      - 'null'
      - int
    doc: maximum path jump to include in block
    inputBinding:
      position: 101
      prefix: --path-jump-max
  - id: poa_length_target
    type:
      - 'null'
      - string
    doc: target sequence length for POA, one per pass
    inputBinding:
      position: 101
      prefix: --poa-length-target
  - id: poa_padding
    type:
      - 'null'
      - float
    doc: pad each end of each sequence in POA with N*(mean_seq_len) bp
    inputBinding:
      position: 101
      prefix: --poa-padding
  - id: poa_params
    type:
      - 'null'
      - string
    doc: 'score parameters for POA in the form of match,mismatch,gap1,ext1,gap2,ext2
      may also be given as presets: asm5, asm10, asm15, asm20'
    inputBinding:
      position: 101
      prefix: --poa-params
  - id: poa_threads
    type:
      - 'null'
      - int
    doc: number of compute threads to use during POA (set lower if you OOM 
      during smoothing)
    inputBinding:
      position: 101
      prefix: --poa-threads
  - id: resume
    type:
      - 'null'
      - boolean
    doc: do not overwrite existing outputs in the given directory
    inputBinding:
      position: 101
      prefix: --resume
  - id: run_abpoa
    type:
      - 'null'
      - boolean
    doc: run abPOA
    inputBinding:
      position: 101
      prefix: --run-abpoa
  - id: segment_length
    type:
      - 'null'
      - int
    doc: segment length for mapping
    inputBinding:
      position: 101
      prefix: --segment-length
  - id: skip_normalization
    type:
      - 'null'
      - boolean
    doc: do not normalize the final graph
    inputBinding:
      position: 101
      prefix: --skip-normalization
  - id: skip_viz
    type:
      - 'null'
      - boolean
    doc: don't render visualizations of the graph in 1D and 2D
    inputBinding:
      position: 101
      prefix: --skip-viz
  - id: sparse_factor
    type:
      - 'null'
      - string
    doc: keep this randomly selected fraction of input matches
    inputBinding:
      position: 101
      prefix: --sparse-factor
  - id: sparse_map
    type:
      - 'null'
      - string
    doc: keep this fraction of mappings ('auto' for giant component heuristic)
    inputBinding:
      position: 101
      prefix: --sparse-map
  - id: stats
    type:
      - 'null'
      - boolean
    doc: generate statistics of the seqwish and smoothxg graph
    inputBinding:
      position: 101
      prefix: --stats
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: number of compute threads to use in parallel steps
    inputBinding:
      position: 101
      prefix: --threads
  - id: transclose_batch
    type:
      - 'null'
      - string
    doc: number of bp to use for transitive closure batch
    inputBinding:
      position: 101
      prefix: --transclose-batch
  - id: vcf_spec
    type:
      - 'null'
      - string
    doc: specify a set of VCFs to produce with SPEC = REF[:LEN][,REF[:LEN]]* the
      paths matching ^REF are used as a reference, while the sample haplotypes 
      are derived from path names, assuming they match the PanSN; e.g. '-V 
      chm13', a path named HG002#1#ctg would be assigned to sample HG002 phase 
      1. If LEN is specified and greater than 0, the VCFs are decomposed, 
      filtering sites whose max allele length is greater than LEN.
    inputBinding:
      position: 101
      prefix: --vcf-spec
  - id: write_maf
    type:
      - 'null'
      - boolean
    doc: write MAF output representing merged POA blocks
    inputBinding:
      position: 101
      prefix: --write-maf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb.out

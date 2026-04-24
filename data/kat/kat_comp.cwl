cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kat
  - comp
label: kat_comp
doc: "Compares jellyfish K-mer count hashes.\n\nTool homepage: https://github.com/TGAC/KAT"
inputs:
  - id: input_1
    type: File
    doc: First input dataset (reads or assembly)
    inputBinding:
      position: 1
  - id: input_2
    type: File
    doc: Second input dataset (reads or assembly)
    inputBinding:
      position: 2
  - id: input_3
    type:
      - 'null'
      - File
    doc: Optional third dataset to filter K-mers
    inputBinding:
      position: 3
  - id: d1_5ptrim
    type:
      - 'null'
      - int
    doc: Ignore the first X bases from reads in dataset 1. If more that one file
      is provided for dataset 1 you can specify different values for each file 
      by seperating with commas.
    inputBinding:
      position: 104
      prefix: --d1_5ptrim
  - id: d1_bins
    type:
      - 'null'
      - int
    doc: Number of bins for the first dataset. i.e. number of rows in the matrix
    inputBinding:
      position: 104
      prefix: --d1_bins
  - id: d1_scale
    type:
      - 'null'
      - float
    doc: Scaling factor for the first dataset - float multiplier
    inputBinding:
      position: 104
      prefix: --d1_scale
  - id: d2_5ptrim
    type:
      - 'null'
      - int
    doc: Ignore the first X bases from reads in dataset 2. If more that one file
      is provided for dataset 2 you can specify different values for each file 
      by seperating with commas.
    inputBinding:
      position: 104
      prefix: --d2_5ptrim
  - id: d2_bins
    type:
      - 'null'
      - int
    doc: Number of bins for the second dataset. i.e. number of rows in the 
      matrix
    inputBinding:
      position: 104
      prefix: --d2_bins
  - id: d2_scale
    type:
      - 'null'
      - float
    doc: Scaling factor for the second dataset - float multiplier
    inputBinding:
      position: 104
      prefix: --d2_scale
  - id: density_plot
    type:
      - 'null'
      - boolean
    doc: Makes a density plot. By default we create a spectra_cn plot.
    inputBinding:
      position: 104
      prefix: --density_plot
  - id: disable_hash_grow
    type:
      - 'null'
      - boolean
    doc: By default jellyfish will double the size of the hash if it gets 
      filled, and then attempt to recount. Setting this option to true, disables
      automatic hash growing. If the hash gets filled an error is thrown. This 
      option is useful if you are working with large genomes, or have strict 
      memory limits on your system.
    inputBinding:
      position: 104
      prefix: --disable_hash_grow
  - id: dump_hashes
    type:
      - 'null'
      - boolean
    doc: Dumps any jellyfish hashes to disk that were produced during this run. 
      Normally, this is not recommended, as hashes are slow to load and will 
      likely consume a significant amount of disk space.
    inputBinding:
      position: 104
      prefix: --dump_hashes
  - id: hash_size_1
    type:
      - 'null'
      - int
    doc: If kmer counting is required for input 1, then use this value as the 
      hash size. If this hash size is not large enough for your dataset then the
      default behaviour is to double the size of the hash and recount, which 
      will increase runtime and memory usage.
    inputBinding:
      position: 104
      prefix: --hash_size_1
  - id: hash_size_2
    type:
      - 'null'
      - int
    doc: If kmer counting is required for input 2, then use this value as the 
      hash size. If this hash size is not large enough for your dataset then the
      default behaviour is to double the size of the hash and recount, which 
      will increase runtime and memory usage.
    inputBinding:
      position: 104
      prefix: --hash_size_2
  - id: hash_size_3
    type:
      - 'null'
      - int
    doc: If kmer counting is required for input 3, then use this value as the 
      hash size. If this hash size is not large enough for your dataset then the
      default behaviour is to double the size of the hash and recount, which 
      will increase runtime and memory usage.
    inputBinding:
      position: 104
      prefix: --hash_size_3
  - id: mer_len
    type:
      - 'null'
      - int
    doc: The kmer length to use in the kmer hashes. Larger values will provide 
      more discriminating power between kmers but at the expense of additional 
      memory and lower coverage.
    inputBinding:
      position: 104
      prefix: --mer_len
  - id: non_canonical_1
    type:
      - 'null'
      - boolean
    doc: If counting fast(a/q) for input 1, store explicit kmer as found. By 
      default, we store 'canonical' k-mers, which means we count both strands.
    inputBinding:
      position: 104
      prefix: --non_canonical_1
  - id: non_canonical_2
    type:
      - 'null'
      - boolean
    doc: If counting fast(a/q) for input 2, store explicit kmer as found. By 
      default, we store 'canonical' k-mers, which means we count both strands.
    inputBinding:
      position: 104
      prefix: --non_canonical_2
  - id: non_canonical_3
    type:
      - 'null'
      - boolean
    doc: If counting fast(a/q) for input 3, store explicit kmer as found. By 
      default, we store 'canonical' k-mers, which means we count both strands.
    inputBinding:
      position: 104
      prefix: --non_canonical_3
  - id: output_hists
    type:
      - 'null'
      - boolean
    doc: Whether or not to output histogram data and plots for input 1 and input
      2
    inputBinding:
      position: 104
      prefix: --output_hists
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Path prefix for files generated by this program.
    inputBinding:
      position: 104
      prefix: --output_prefix
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'The plot file type to create: png, ps, pdf.'
    inputBinding:
      position: 104
      prefix: --output_type
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use.
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra information.
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kat:2.4.2--py39he0b6574_5
stdout: kat_comp.out

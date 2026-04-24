cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqwin
label: seqwin
doc: "Seqwin is a tool for identifying and analyzing genomic sequences based on taxonomic
  and path-based filtering, with options for controlling k-mer analysis, output generation,
  and NCBI data downloads.\n\nTool homepage: https://github.com/treangenlab/seqwin"
inputs:
  - id: annotated
    type:
      - 'null'
      - boolean
    doc: NCBI download option. Only include annotated genomes.
    inputBinding:
      position: 101
      prefix: --annotated
  - id: download_only
    type:
      - 'null'
      - boolean
    doc: Only download genome sequences without running Seqwin.
    inputBinding:
      position: 101
      prefix: --download-only
  - id: exclude_mag
    type:
      - 'null'
      - boolean
    doc: NCBI download option. Exclude metagenome-assembled genomes (MAGs).
    inputBinding:
      position: 101
      prefix: --exclude-mag
  - id: kmerlen
    type:
      - 'null'
      - int
    doc: K-mer length.
    inputBinding:
      position: 101
      prefix: --kmerlen
  - id: level
    type:
      - 'null'
      - string
    doc: NCBI download option. Limit to genomes ≥ this assembly level (contig < 
      scaffold < chromosome < complete).
    inputBinding:
      position: 101
      prefix: --level
  - id: max_len
    type:
      - 'null'
      - int
    doc: Max length of output signatures (estimated). No explicit limit if not 
      provided.
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Min length of output signatures.
    inputBinding:
      position: 101
      prefix: --min-len
  - id: neg_paths
    type:
      - 'null'
      - File
    doc: A text file of paths to non-target genomes in FASTA format (gzip 
      supported), with one path per line.
    inputBinding:
      position: 101
      prefix: --neg-paths
  - id: neg_taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: Non-target NCBI taxonomy name / ID. Must be exact match. Repeat the 
      option to pass multiple values (-n <tax1> -n <tax2> ...).
    inputBinding:
      position: 101
      prefix: --neg-taxa
  - id: no_blast
    type:
      - 'null'
      - boolean
    doc: Do NOT evaluate (BLAST) signature sequences.
    inputBinding:
      position: 101
      prefix: --no-blast
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: NCBI download option. Do NOT download genomes as gzipped FASTA.
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: no_mash
    type:
      - 'null'
      - boolean
    doc: Do NOT run Mash to estimate node penalty threshold. Instead, use 
      minimizer sketches (faster but might be biased). Used only if --penalty-th
      is not provided (auto mode).
    inputBinding:
      position: 101
      prefix: --no-mash
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output files.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: penalty_th
    type:
      - 'null'
      - float
    doc: Node penalty threshold (0-1). Automatically computed if not provided.
    inputBinding:
      position: 101
      prefix: --penalty-th
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Path prefix for the output directory. Use the current directory by 
      default.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility.
    inputBinding:
      position: 101
      prefix: --seed
  - id: source
    type:
      - 'null'
      - string
    doc: NCBI download option. Genome source ('genbank' or 'refseq').
    inputBinding:
      position: 101
      prefix: --source
  - id: stringency
    type:
      - 'null'
      - int
    doc: Stringency level (0-10) for the sensitivity and specificity of output 
      signatures. Higher levels result in lower estimated node penalty 
      thresholds. Used only if --penalty-th is not provided (auto mode).
    inputBinding:
      position: 101
      prefix: --stringency
  - id: tar_paths
    type:
      - 'null'
      - File
    doc: A text file of paths to target genomes in FASTA format (gzip 
      supported), with one path per line.
    inputBinding:
      position: 101
      prefix: --tar-paths
  - id: tar_taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: Target NCBI taxonomy name / ID. Must be exact match. Repeat the option 
      to pass multiple values (-t <tax1> -t <tax2> ...).
    inputBinding:
      position: 101
      prefix: --tar-taxa
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel processes (CPU cores) to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: title
    type:
      - 'null'
      - string
    doc: Name of the output directory.
    inputBinding:
      position: 101
      prefix: --title
  - id: windowsize
    type:
      - 'null'
      - int
    doc: Window size for minimizer sketch.
    inputBinding:
      position: 101
      prefix: --windowsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqwin:0.2.2--pyhdfd78af_1
stdout: seqwin.out

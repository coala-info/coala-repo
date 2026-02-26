cwlVersion: v1.2
class: CommandLineTool
baseCommand: lexicmap index
label: lexicmap_index
doc: "Generate an index from FASTA/Q sequences\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'Maximum number of genomes in each batch (maximum value: 131072)'
    default: 5000
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: big_genomes
    type:
      - 'null'
      - File
    doc: 'Out file of skipped files with $total_bases + ($num_contigs - 1) * $contig_interval
      >= -g/--max-genome. The second column is one of the skip types: no_valid_seqs,
      too_large_genome, too_many_seqs.'
    inputBinding:
      position: 101
      prefix: --big-genomes
  - id: chunks
    type:
      - 'null'
      - int
    doc: 'Number of chunks for storing seeds (k-mer-value data) files. Max: 128. Default:
      the value of -j/--threads.'
    default: 20
    inputBinding:
      position: 101
      prefix: --chunks
  - id: contig_interval
    type:
      - 'null'
      - int
    doc: Length of interval (N's) between contigs in a genome. It can't be too 
      small (<1000) or some alignments might be fragmented
    default: 1000
    inputBinding:
      position: 101
      prefix: --contig-interval
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug information.
    inputBinding:
      position: 101
      prefix: --debug
  - id: file_regexp
    type:
      - 'null'
      - string
    doc: "Regular expression for matching sequence files in -I/--in-dir, case ignored.
      Attention: use double quotation marks for patterns containing commas, e.g.,
      -p '\"A{2,}\"'. "
    default: \.(f[aq](st[aq])?|fna)(\.gz|\.xz|\.zst|\.bz2)?$
    inputBinding:
      position: 101
      prefix: --file-regexp
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: in_dir
    type:
      - 'null'
      - Directory
    doc: Input directory containing FASTA/Q files. Directory and file symlinks 
      are followed.
    inputBinding:
      position: 101
      prefix: --in-dir
  - id: infile_list
    type:
      - 'null'
      - File
    doc: File of input file list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: kmer
    type:
      - 'null'
      - int
    doc: Maximum k-mer size. K needs to be <= 32.
    default: 31
    inputBinding:
      position: 101
      prefix: --kmer
  - id: log
    type:
      - 'null'
      - File
    doc: Log file.
    inputBinding:
      position: 101
      prefix: --log
  - id: mask_file
    type:
      - 'null'
      - File
    doc: File of custom masks. This flag oversides -k/--kmer, -m/--masks, 
      -s/--rand-seed etc.
    inputBinding:
      position: 101
      prefix: --mask-file
  - id: masks
    type:
      - 'null'
      - int
    doc: Number of LexicHash masks.
    default: 20000
    inputBinding:
      position: 101
      prefix: --masks
  - id: max_genome
    type:
      - 'null'
      - int
    doc: 'Maximum genome size. Genomes with any single contig larger than the threshold
      will be skipped, while fragmented (with many contigs) genomes larger than the
      threshold will be split into chunks and alignments from these chunks will be
      merged in "lexicmap search". The value needs to be smaller than the maximum
      supported genome size: 268435456.'
    default: 15000000
    inputBinding:
      position: 101
      prefix: --max-genome
  - id: max_open_files
    type:
      - 'null'
      - int
    doc: Maximum opened files, used in merging indexes. If there are >100 
      batches, please increase this value and set a bigger "ulimit -n" in shell.
    default: 1024
    inputBinding:
      position: 101
      prefix: --max-open-files
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length to index. The value would be k for values <= 0.
    default: -1
    inputBinding:
      position: 101
      prefix: --min-seq-len
  - id: no_desert_filling
    type:
      - 'null'
      - boolean
    doc: Disable sketching desert filling (only for debug).
    inputBinding:
      position: 101
      prefix: --no-desert-filling
  - id: out_dir
    type: Directory
    doc: Output LexicMap index directory.
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: partitions
    type:
      - 'null'
      - int
    doc: Number of partitions for indexing seeds (k-mer-value data) files. The 
      value needs to be the power of 4.
    default: 4096
    inputBinding:
      position: 101
      prefix: --partitions
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to a file 
      with --log.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: Rand seed for generating random masks.
    default: 1
    inputBinding:
      position: 101
      prefix: --rand-seed
  - id: ref_name_regexp
    type:
      - 'null'
      - string
    doc: "Regular expression (must contains \"(\" and \")\") for extracting the reference
      name from the filename. Attention: use double quotation marks for patterns containing
      commas, e.g., -p '\"A{2,}\"'. "
    default: (?i)(.+)\.(f[aq](st[aq])?|fna)(\.gz|\.xz|\.zst|\.bz2)?$
    inputBinding:
      position: 101
      prefix: --ref-name-regexp
  - id: save_seed_pos
    type:
      - 'null'
      - boolean
    doc: Save seed positions, which can be inspected with "lexicmap utils 
      seed-pos".
    inputBinding:
      position: 101
      prefix: --save-seed-pos
  - id: seed_data_threads
    type:
      - 'null'
      - int
    doc: Number of threads for writing seed data and merging seed chunks from 
      all batches, the value should be in range of [1, -c/--chunks]. If there 
      are >100 batches, please also increase the value of --max-open-files and 
      set a bigger "ulimit -n" in shell.
    default: 8
    inputBinding:
      position: 101
      prefix: --seed-data-threads
  - id: seed_in_desert_dist
    type:
      - 'null'
      - int
    doc: Distance of k-mers to fill deserts.
    default: 50
    inputBinding:
      position: 101
      prefix: --seed-in-desert-dist
  - id: seed_max_desert
    type:
      - 'null'
      - int
    doc: Maximum length of sketching deserts, or maximum seed distance. Deserts 
      with seed distance larger than this value will be filled by choosing 
      k-mers roughly every --seed-in-desert-dist bases.
    default: 100
    inputBinding:
      position: 101
      prefix: --seed-max-desert
  - id: seq_name_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: List of regular expressions for filtering out sequences by contents in 
      FASTA/Q header/name, case ignored.
    inputBinding:
      position: 101
      prefix: --seq-name-filter
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: Skip input file checking when given files or a file list.
    inputBinding:
      position: 101
      prefix: --skip-file-check
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use. By default, it uses all available cores.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
stdout: lexicmap_index.out

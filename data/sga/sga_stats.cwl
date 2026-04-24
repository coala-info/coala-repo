cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - stats
label: sga_stats
doc: "Print statistics about the read set. Currently this only prints a histogram\n\
  of the k-mer counts\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: readsfile
    type: File
    doc: Input read set file
    inputBinding:
      position: 1
  - id: branch_cutoff
    type:
      - 'null'
      - int
    doc: "stop the overlap search at N branches. This lowers the compute time but
      will bias the statistics\naway from repetitive reads"
    inputBinding:
      position: 102
      prefix: --branch-cutoff
  - id: kmer_distribution
    type:
      - 'null'
      - boolean
    doc: Print the distribution of kmer counts
    inputBinding:
      position: 102
      prefix: --kmer-distribution
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The length of the kmer to use.
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: no_overlap
    type:
      - 'null'
      - boolean
    doc: Suppress the overlap-based error statistics (faster if you only want 
      the k-mer distribution)
    inputBinding:
      position: 102
      prefix: --no-overlap
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Only use N reads to compute the statistics
    inputBinding:
      position: 102
      prefix: --num-reads
  - id: prefix
    type:
      - 'null'
      - string
    doc: use PREFIX for the names of the index files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: run_lengths
    type:
      - 'null'
      - boolean
    doc: Print the run length distribution of the BWT
    inputBinding:
      position: 102
      prefix: --run-lengths
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: "use occurrence array sample rate of N in the FM-index. Higher values use
      significantly\nless memory at the cost of higher runtime. This value must be
      a power of 2"
    inputBinding:
      position: 102
      prefix: --sample-rate
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM threads to compute the overlaps
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_stats.out

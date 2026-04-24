cwlVersion: v1.2
class: CommandLineTool
baseCommand: coconet
label: coconet-binning_coconet
doc: "CoCoNet: a tool for binning metagenomic contigs\n\nTool homepage: https://github.com/Puumanamana/CoCoNet"
inputs:
  - id: input_contigs
    type: File
    doc: Input FASTA file with contigs
    inputBinding:
      position: 1
  - id: input_reads
    type: File
    doc: Input FASTQ file with paired-end reads
    inputBinding:
      position: 2
  - id: contig_bins
    type:
      - 'null'
      - File
    doc: TSV file with pre-assigned contig bins
    inputBinding:
      position: 103
      prefix: --contig-bins
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output files
    inputBinding:
      position: 103
      prefix: --force
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for sequence composition analysis
    inputBinding:
      position: 103
      prefix: --kmer-size
  - id: max_bins
    type:
      - 'null'
      - int
    doc: Maximum number of bins to generate
    inputBinding:
      position: 103
      prefix: --max-bins
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: Minimum contig length for binning
    inputBinding:
      position: 103
      prefix: --min-contig-len
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: read_bins
    type:
      - 'null'
      - File
    doc: TSV file with pre-assigned read bins
    inputBinding:
      position: 103
      prefix: --read-bins
  - id: seed_contigs
    type:
      - 'null'
      - File
    doc: FASTA file with seed contigs for guided binning
    inputBinding:
      position: 103
      prefix: --seed-contigs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coconet-binning:1.1.0--py_0
stdout: coconet-binning_coconet.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: Fec
label: fec_Fec
doc: "Fec is an error correction tool for long reads (PacBio, Nanopore) based on two
  rounds of overlapping and caching. It takes overlaps (PAF from minimap2 -x ava-pb or
  ava-ont), the reads in uncompressed FASTA or FASTQ and writes corrected reads in
  FASTA.\n\nTool homepage: https://github.com/zhangjuncsu/Fec"
inputs:
  - id: data_type
    type: ['null', int]
    doc: 'Data type: 0 = PacBio, 1 = Nanopore (default 0)'
    inputBinding:
      position: 1
      prefix: -x
  - id: threads
    type: ['null', int]
    doc: Number of threads (CPUs) (default 1)
    inputBinding:
      position: 2
      prefix: -t
  - id: batch_size
    type: ['null', int]
    doc: Batch size that the reads will be partitioned (default 100000)
    inputBinding:
      position: 3
      prefix: -p
  - id: min_mapping_ratio
    type: ['null', float]
    doc: Minimum mapping ratio (default 0.6)
    inputBinding:
      position: 4
      prefix: -r
  - id: min_overlap_size
    type: ['null', int]
    doc: Minimum overlap size (default 1000)
    inputBinding:
      position: 5
      prefix: -a
  - id: min_coverage
    type: ['null', int]
    doc: Minimum coverage under consideration (default 4)
    inputBinding:
      position: 6
      prefix: -c
  - id: min_corrected_length
    type: ['null', int]
    doc: Minimum length of corrected sequence (default 2000)
    inputBinding:
      position: 7
      prefix: -l
  - id: open_files
    type: ['null', int]
    doc: Number of partition files to open at one time (if below 0, it is set to the
      system limit; default 100)
    inputBinding:
      position: 8
      prefix: -k
  - id: use_cache
    type: ['null', int]
    doc: 'Use cache or not: 0 = not use, 1 = use (default 1)'
    inputBinding:
      position: 9
      prefix: -e
  - id: second_round
    type: ['null', int]
    doc: 'Perform second-round overlapping or not: 0 = not perform, 1 = perform (default
      1)'
    inputBinding:
      position: 10
      prefix: -s
  - id: second_round_repetitive_fraction
    type: ['null', string]
    doc: Filter out top fraction of repetitive minimizers of the second-round overlapping
      (default 0.0002)
    inputBinding:
      position: 11
      prefix: -m
  - id: second_round_min_overlap_ratio
    type: ['null', string]
    doc: Minimum overlap ratio used for the second-round overlapping filtering (default
      0.6)
    inputBinding:
      position: 12
      prefix: -f
  - id: second_round_kmer_size
    type: ['null', int]
    doc: K-mer size of the second-round overlapping (default 15)
    inputBinding:
      position: 13
      prefix: -K
  - id: second_round_window_size
    type: ['null', int]
    doc: Minimizer window size for the second-round overlapping (default 5)
    inputBinding:
      position: 14
      prefix: -w
  - id: homopolymer_compressed_kmer
    type: ['null', boolean]
    doc: Use homopolymer-compressed k-mer for the second-round overlapping
    inputBinding:
      position: 15
      prefix: -H
  - id: reuse_long_indel
    type: ['null', boolean]
    doc: Reuse long indel
    inputBinding:
      position: 16
      prefix: -R
  - id: full_consensus
    type: ['null', boolean]
    doc: Full consensus
    inputBinding:
      position: 17
      prefix: -F
  - id: overlaps
    type: File
    doc: Overlaps in PAF format (for example from minimap2 -x ava-pb or ava-ont). Fec writes
      its partition files beside this file, so the wrapper stages a writable copy.
    inputBinding:
      position: 100
  - id: reads
    type: File
    doc: Reads in uncompressed FASTA or FASTQ format
    inputBinding:
      position: 101
  - id: output_path
    type: string
    doc: Output file name for the corrected reads (FASTA)
    inputBinding:
      position: 102
outputs:
  - id: corrected_reads
    type: File
    doc: Corrected reads in FASTA format
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.overlaps)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fec:1.0.1--he70b90d_2
stdout: fec_Fec.out

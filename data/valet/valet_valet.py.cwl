cwlVersion: v1.2
class: CommandLineTool
baseCommand: valet.py
label: valet_valet.py
doc: "VALET: a pipeline for detecting misassemblies in metagenomic assemblies. It aligns reads to the candidate assemblies and flags regions with misassembly signatures.\n\nTool homepage: https://github.com/marbl/VALET"
inputs:
  - id: assembly_fasta
    type:
      type: array
      items: File
      inputBinding:
        itemSeparator: ','
    doc: Candidate assembly files
    inputBinding:
      position: 101
      prefix: --assembly-fasta
      itemSeparator: ','
  - id: assembly_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Names for the different assemblies.
    inputBinding:
      position: 101
      prefix: --assembly-names
      itemSeparator: ','
  - id: reads
    type:
      - 'null'
      - File
    doc: First Read File
    inputBinding:
      position: 101
      prefix: --reads
  - id: first_mates
    type:
      - 'null'
      - type: array
        items: File
    doc: Fastq filenames separated by commas that contain the first mates.
    inputBinding:
      position: 101
      prefix: --1
      itemSeparator: ','
  - id: second_mates
    type:
      - 'null'
      - type: array
        items: File
    doc: Fastq filenames separated by commas that contain the second mates.
    inputBinding:
      position: 101
      prefix: --2
      itemSeparator: ','
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: Assembly created per-contig coverage file
    inputBinding:
      position: 101
      prefix: --coverage-file
  - id: config_file
    type:
      - 'null'
      - File
    doc: Config file with preset parameters.
    inputBinding:
      position: 101
      prefix: --config-file
  - id: output_dir
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: window_size
    type:
      - 'null'
      - int
    doc: Sliding window size when determining misassemblies.
    inputBinding:
      position: 101
      prefix: --window-size
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: if set, input reads are fasta format (by default, reads are FASTQ).
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: if set, input reads are fastq format.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: min_insert_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Min insert sizes for mate pairs separated by commas.
    inputBinding:
      position: 101
      prefix: --minins
      itemSeparator: ','
  - id: max_insert_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Max insert sizes for mate pairs separated by commas.
    inputBinding:
      position: 101
      prefix: --maxins
      itemSeparator: ','
  - id: orientation
    type:
      - 'null'
      - string
    doc: Orientation of the mates.
    inputBinding:
      position: 101
      prefix: --orientation
  - id: mu
    type:
      - 'null'
      - float
    doc: average mate pair insert sizes.
    inputBinding:
      position: 101
      prefix: --mu
  - id: sigma
    type:
      - 'null'
      - float
    doc: standard deviation of mate pair insert sizes.
    inputBinding:
      position: 101
      prefix: --sigma
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: bowtie2 parameter to set the max number of alignments.
    inputBinding:
      position: 101
      prefix: --max-alignments
  - id: email
    type:
      - 'null'
      - string
    doc: Email to notify when job completes
    inputBinding:
      position: 101
      prefix: --email
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum average coverage to run misassembly detection.
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: coverage_multiplier
    type:
      - 'null'
      - float
    doc: When binning by coverage, the new high = high + high * multiplier
    inputBinding:
      position: 101
      prefix: --coverage-multiplier
  - id: min_suspicious
    type:
      - 'null'
      - int
    doc: Minimum number of overlapping flagged miassemblies to mark region as suspicious.
    inputBinding:
      position: 101
      prefix: --min-suspicious
  - id: suspicious_flank_size
    type:
      - 'null'
      - int
    doc: Mark region as suspicious if multiple signatures occur within this window size.
    inputBinding:
      position: 101
      prefix: --suspicious-flank-size
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Ignore contigs smaller than this length.
    inputBinding:
      position: 101
      prefix: --min-contig-length
  - id: ignore_ends
    type:
      - 'null'
      - int
    doc: Ignore flagged regions within b bps from the ends of the contigs.
    inputBinding:
      position: 101
      prefix: --ignore-ends
  - id: breakpoint_bin
    type:
      - 'null'
      - int
    doc: Bin sized used to find breakpoints.
    inputBinding:
      position: 101
      prefix: --breakpoint-bin
  - id: orf_file
    type:
      - 'null'
      - File
    doc: gff formatted file containing orfs
    inputBinding:
      position: 101
      prefix: --orf-file
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer length used for abundance estimation
    inputBinding:
      position: 101
      prefix: --kmer
  - id: skip_reapr
    type:
      - 'null'
      - boolean
    doc: skip the REAPR step
    inputBinding:
      position: 101
      prefix: --skip-reapr
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Output directory with one folder per assembly (summary.tsv, summary.bed, suspicious.bed, flagged regions) and the comparison plot
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/valet:1.0--3
stdout: valet_valet.py.out

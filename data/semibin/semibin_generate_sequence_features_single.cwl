cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SemiBin2
  - generate_sequence_features_single
label: semibin_generate_sequence_features_single
doc: 'Generate sequence features (kmer and abundance) as training data for (semi/self)-supervised
  deep learning model training (single or co-assembly mode). This will produce the
  data.csv and data_split.csv files.


  Tool homepage: https://github.com/BigDataBiology/SemiBin'
inputs:
  - id: kmer
    type:
      - 'null'
      - boolean
    doc: Just output data.csv with k-mer features.
    inputBinding:
      position: 1
      prefix: --kmer
  - id: write_pre_reclustering_bins
    type:
      - 'null'
      - boolean
    doc: Write pre-reclustering bins to disk.
    inputBinding:
      position: 1
      prefix: --write-pre-reclustering-bins
  - id: no_write_pre_reclustering_bins
    type:
      - 'null'
      - boolean
    doc: Write pre-reclustering bins to disk.
    inputBinding:
      position: 1
      prefix: --no-write-pre-reclustering-bins
  - id: tag_output
    type:
      - 'null'
      - string
    doc: Tag to add to output file names
    inputBinding:
      position: 1
      prefix: --tag-output
  - id: compression
    type:
      - 'null'
      - string
    doc: 'Compression type for the output files (accepted values: gz [default]/xz/bz2/none).'
    inputBinding:
      position: 1
      prefix: --compression
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: option to set temporary directory
    inputBinding:
      position: 1
      prefix: --tmpdir
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of CPUs used (pass the value 0 to use all CPUs, default: 0)'
    inputBinding:
      position: 1
      prefix: --processes
  - id: min_len
    type:
      - 'null'
      - int
    doc: 'Minimal length for contigs in binning. If you use SemiBin with multi steps
      and you use this parameter, please use this parameter consistently with all
      subcommands. (Default: SemiBin chooses 1000bp or 2500bp according the ratio
      of the number of base pairs of contigs between 1000-2500bp).'
    inputBinding:
      position: 1
      prefix: --min-len
  - id: ratio
    type:
      - 'null'
      - float
    doc: 'If the ratio of the number of base pairs of contigs between 1000-2500 bp
      smaller than this value, the minimal length will be set as 1000bp, otherwise
      2500bp. Note that setting `--min-length/-m` overrules this parameter. If you
      use SemiBin with multi steps and you use this parameter, please use this parameter
      consistently with all subcommands. (Default: 0.05)'
    inputBinding:
      position: 1
      prefix: --ratio
  - id: input_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to the input BAM(.bam)/CRAM(.cram) file(s). If using multiple samples,
      you can input multiple files.If just computing k-mer features, a BAM file is
      not needed.
    inputBinding:
      position: 1
      prefix: --input-bam
  - id: abundance
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to the abundance file from strobealign-aemb. This can only be used when
      samples used in binning above or equal 5.
    inputBinding:
      position: 1
      prefix: --abundance
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output
    inputBinding:
      position: 1
      prefix: --quiet
  - id: ml_threshold
    type:
      - 'null'
      - int
    doc: Length threshold for generating must-link constraints. (By default, the threshold
      is calculated from the contig, and the default minimum value is 4,000 bp)
    inputBinding:
      position: 1
      prefix: --ml-threshold
  - id: input_fasta
    type: File
    doc: Path to the input fasta file.
    inputBinding:
      position: 1
      prefix: --input-fasta
  - id: output
    type: string
    doc: Output directory (will be created if non-existent)
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0

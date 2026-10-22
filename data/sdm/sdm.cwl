cwlVersion: v1.2
class: CommandLineTool
baseCommand: sdm
label: sdm
doc: "sdm (simple demultiplexer) is a fast, memory efficient program to demultiplex
  fasta and fastq files or simply do quality filterings on these.\n\nTool homepage:
  https://github.com/hildebra/sdm/"
inputs:
  - id: input_fastq
    type: ['null', File]
    doc: FastQ input file
    inputBinding:
      position: 1
      prefix: -i_fastq
  - id: input_fna
    type: ['null', File]
    doc: FASTA input file (required with -i_qual unless a quality file is named xx1.qual_)
    inputBinding:
      position: 1
      prefix: -i_fna
  - id: input_qual
    type: ['null', File]
    doc: Quality file that matches the FASTA input
    inputBinding:
      position: 1
      prefix: -i_qual
  - id: input_auto
    type: ['null', File]
    doc: Input sequence file, auto-detects fna or fastq
    inputBinding:
      position: 1
      prefix: -i
  - id: input_path
    type: ['null', Directory]
    doc: Folder with several fastq / fasta files (the file names listed in the map file are looked up here)
    inputBinding:
      position: 1
      prefix: -i_path
  - id: map_file
    type: ['null', File]
    doc: Mapping file in Qiime format (the help calls this option -base_map, but sdm 3.11 only applies -map)
    inputBinding:
      position: 2
      prefix: -map
  - id: options
    type: ['null', File]
    doc: sdm option file
    inputBinding:
      position: 2
      prefix: -options
  - id: output_fna
    type: ['null', string]
    doc: File to write output fasta
    inputBinding:
      position: 3
      prefix: -o_fna
  - id: output_qual
    type: ['null', string]
    doc: File to write corresponding quality values
    inputBinding:
      position: 3
      prefix: -o_qual
  - id: output_fastq
    type: ['null', string]
    doc: FastQ output file (overrides -o_qual and -o_fna)
    inputBinding:
      position: 3
      prefix: -o_fastq
  - id: log
    type: ['null', string]
    doc: File to save the demultiplex log in. Set to "nolog" to deactivate.
    inputBinding:
      position: 3
      prefix: -log
  - id: sample_sep
    type: ['null', string]
    doc: String used to delimit samples and id_ (default "__")
    inputBinding:
      position: 4
      prefix: -sample_sep
  - id: paired
    type: ['null', int]
    doc: 1 = singleton (default), 2 = paired end (two input files delimited by comma), 3 = paired end (R1,R3) plus a MID file
    inputBinding:
      position: 4
      prefix: -paired
  - id: output_demultiplex
    type: ['null', string]
    doc: Path to write the input into single, demultiplexed files
    inputBinding:
      position: 4
      prefix: -o_demultiplex
  - id: only_pair
    type: ['null', int]
    doc: Consider only read pair 1 or 2
    inputBinding:
      position: 4
      prefix: -onlyPair
  - id: input_mid_fastq
    type: ['null', File]
    doc: FastQ file with only MID sequences
    inputBinding:
      position: 4
      prefix: -i_MID_fastq
  - id: paired_demulti
    type: ['null', int]
    doc: Only write complete pairs in demultiplexing paired input (0/1)
    inputBinding:
      position: 4
      prefix: -pairedDemulti
  - id: one_line_fasta_format
    type: ['null', int]
    doc: Write Fasta and Quality file sequence string in one line (0/1)
    inputBinding:
      position: 4
      prefix: -oneLineFastaFormat
  - id: output_dereplicate
    type: ['null', string]
    doc: Output fasta file of dereplicated DNA reads (with size in header)
    inputBinding:
      position: 4
      prefix: -o_dereplicate
  - id: dere_size_fmt
    type: ['null', int]
    doc: Dereplicate size format, 0 = usearch "size=X;", 1 = "_X"
    inputBinding:
      position: 4
      prefix: -dere_size_fmt
  - id: min_derep_copies
    type: ['null', string]
    doc: Only print a sequence if at least X copies are present, can be a complex term like "10:1,3:3"
    inputBinding:
      position: 4
      prefix: -min_derep_copies
  - id: sync_read_pairs
    type: ['null', string]
    doc: Check that read pairs occur in the same order, and correct if not (T/F)
    inputBinding:
      position: 4
      prefix: -SyncReadPairs
  - id: max_reads_per_output
    type: ['null', int]
    doc: Number of filtered reads per output file (only with -o_fna)
    inputBinding:
      position: 4
      prefix: -maxReadsPerOutput
  - id: merged_pairs
    type: ['null', int]
    doc: 1 if paired sequences were merged externally (1/0)
    inputBinding:
      position: 4
      prefix: -mergedPairs
  - id: otu_fallback
    type: ['null', File]
    doc: Fallback fasta sequences for OTUs, only used in SEED extension mode
    inputBinding:
      position: 4
      prefix: -OTU_fallback
  - id: input_qual_offset
    type: ['null', string]
    doc: Fastq offset for quality values (0-64, or 'auto')
    inputBinding:
      position: 4
      prefix: -i_qual_offset
  - id: output_qual_offset
    type: ['null', int]
    doc: Quality offset for fastq output file (default 33)
    inputBinding:
      position: 4
      prefix: -o_qual_offset
  - id: ignore_io_errors
    type: ['null', int]
    doc: 1 = errors in fastq reads are ignored (default 0)
    inputBinding:
      position: 4
      prefix: -ignore_IO_errors
  - id: five_pr1_cut
    type: ['null', int]
    doc: Remove the first I nucleotides from read 1
    inputBinding:
      position: 4
      prefix: -5PR1cut
  - id: five_pr2_cut
    type: ['null', int]
    doc: Remove the first I nucleotides from read 2
    inputBinding:
      position: 4
      prefix: -5PR2cut
  - id: golden_axe
    type: ['null', int]
    doc: Use GoldenAxe mode for PacBio concatenated reads (0/1)
    inputBinding:
      position: 4
      prefix: -GoldenAxe
  - id: golden_axe_min_ampli
    type: ['null', int]
    doc: Minimum number of amplicons on GoldenAxe reads to accept at all (default -1)
    inputBinding:
      position: 4
      prefix: -GoldenAxeMinAmpli
  - id: x_first_reads_written
    type: ['null', int]
    doc: Only print the first X reads across all input files
    inputBinding:
      position: 4
      prefix: -XfirstReadsWritten
  - id: x_first_reads_read
    type: ['null', int]
    doc: Only read the first X reads across all input files
    inputBinding:
      position: 4
      prefix: -XfirstReadsRead
outputs:
  - id: output_fastq_file
    type: ['null', File]
    doc: FastQ output
    outputBinding:
      glob: $(inputs.output_fastq)
  - id: output_fna_file
    type: ['null', File]
    doc: FASTA output
    outputBinding:
      glob: $(inputs.output_fna)
  - id: output_qual_file
    type: ['null', File]
    doc: Quality output
    outputBinding:
      glob: $(inputs.output_qual)
  - id: log_file
    type: ['null', File]
    doc: Demultiplex log
    outputBinding:
      glob: $(inputs.log)
  - id: dereplicated_file
    type: ['null', File]
    doc: Dereplicated reads
    outputBinding:
      glob: $(inputs.output_dereplicate)
  - id: demultiplex_dir
    type: ['null', Directory]
    doc: Folder written by -o_demultiplex
    outputBinding:
      glob: $(inputs.output_demultiplex)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sdm:3.11--h077b44d_0
stdout: sdm.out

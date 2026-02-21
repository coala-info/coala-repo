cwlVersion: v1.2
class: CommandLineTool
baseCommand: Multigrmpy.py
label: paragraph_multigrmpy.py
doc: "A tool for graph-based genotyping of variants using a manifest of samples and
  a reference genome.\n\nTool homepage: https://github.com/Illumina/paragraph"
inputs:
  - id: bad_align_uniq_kmer_len
    type:
      - 'null'
      - int
    doc: Kmer length for uniqueness check during read filtering.
    inputBinding:
      position: 101
      prefix: --bad-align-uniq-kmer-len
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Log debug level events.
    inputBinding:
      position: 101
      prefix: --debug
  - id: genotyping_parameters
    type:
      - 'null'
      - string
    doc: JSON string or file with genotyping model parameters.
    inputBinding:
      position: 101
      prefix: --genotyping-parameters
  - id: graph_sequence_matching
    type:
      - 'null'
      - string
    doc: Use graph aligner.
    inputBinding:
      position: 101
      prefix: --graph-sequence-matching
  - id: graph_type
    type:
      - 'null'
      - string
    doc: Type of complex graph to generate (alleles or haplotypes).
    inputBinding:
      position: 101
      prefix: --graph-type
  - id: grmpy
    type:
      - 'null'
      - File
    doc: Path to the grmpy executable
    inputBinding:
      position: 101
      prefix: --grmpy
  - id: infer_read_haplotypes
    type:
      - 'null'
      - boolean
    doc: Infer read haplotype paths
    inputBinding:
      position: 101
      prefix: --infer-read-haplotypes
  - id: input
    type: File
    doc: Input file of variants. Must be either JSON or VCF.
    inputBinding:
      position: 101
      prefix: --input
  - id: ins_info_key
    type:
      - 'null'
      - string
    doc: Key in INFO field to indicate sequence of symbolic <INS>
    inputBinding:
      position: 101
      prefix: --ins-info-key
  - id: keep_scratch
    type:
      - 'null'
      - boolean
    doc: Do not delete temp files.
    inputBinding:
      position: 101
      prefix: --keep-scratch
  - id: klib_sequence_matching
    type:
      - 'null'
      - string
    doc: Use klib smith waterman aligner.
    inputBinding:
      position: 101
      prefix: --klib-sequence-matching
  - id: kmer_sequence_matching
    type:
      - 'null'
      - string
    doc: Use kmer aligner.
    inputBinding:
      position: 101
      prefix: --kmer-sequence-matching
  - id: manifest
    type: File
    doc: Manifest of samples with path and bam stats.
    inputBinding:
      position: 101
      prefix: --manifest
  - id: max_reads_per_event
    type:
      - 'null'
      - int
    doc: Maximum number of reads to process for a single event.
    inputBinding:
      position: 101
      prefix: --max-reads-per-event
  - id: max_ref_node_length
    type:
      - 'null'
      - int
    doc: Maximum length of reference nodes before they get padded and truncated.
    inputBinding:
      position: 101
      prefix: --max-ref-node-length
  - id: no_alt_splitting
    type:
      - 'null'
      - boolean
    doc: Keep long insertion sequences in the graph rather than trimming them at the
      read / padding length.
    inputBinding:
      position: 101
      prefix: --no-alt-splitting
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set logging level to output errors only.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length -- this is used to add reference padding when converting VCF
      to graphs.
    inputBinding:
      position: 101
      prefix: --read-length
  - id: reference_sequence
    type: File
    doc: Reference genome fasta file.
    inputBinding:
      position: 101
      prefix: --reference-sequence
  - id: retrieve_reference_sequence
    type:
      - 'null'
      - boolean
    doc: Retrieve reference sequence for REF nodes
    inputBinding:
      position: 101
      prefix: --retrieve-reference-sequence
  - id: scratch_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temp files
    inputBinding:
      position: 101
      prefix: --scratch-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of events to process in parallel.
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf_split
    type:
      - 'null'
      - string
    doc: 'Mode for splitting the input VCF: lines (default), full, by_id, or superloci.'
    inputBinding:
      position: 101
      prefix: --vcf-split
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Raise logging level from warning to info.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_alignments
    type:
      - 'null'
      - boolean
    doc: Write alignment JSON files into the output folder (large!).
    inputBinding:
      position: 101
      prefix: --write-alignments
outputs:
  - id: output
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write logging information into file rather than to stderr
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: transrate
label: transrate
doc: "Transrate is a tool for assessing the quality of RNA-Seq assemblies.\n\nTool
  homepage: https://github.com/blahah/transrate/"
inputs:
  - id: input_reads
    type: File
    doc: Input FASTQ file(s) of RNA-Seq reads.
    inputBinding:
      position: 1
  - id: input_assembly
    type: File
    doc: Input assembly file (e.g., FASTA format).
    inputBinding:
      position: 2
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mers to use for analysis.
    inputBinding:
      position: 103
      prefix: --kmer-size
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Minimum contig length to consider for analysis.
    inputBinding:
      position: 103
      prefix: --min-contig-length
  - id: min_kmer_coverage
    type:
      - 'null'
      - int
    doc: Minimum k-mer coverage to consider a k-mer as valid.
    inputBinding:
      position: 103
      prefix: --min-kmer-coverage
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length to consider for analysis.
    inputBinding:
      position: 103
      prefix: --min-read-length
  - id: no_quality_filter
    type:
      - 'null'
      - boolean
    doc: Do not filter reads based on quality scores.
    inputBinding:
      position: 103
      prefix: --no-quality-filter
  - id: no_reverse_complement
    type:
      - 'null'
      - boolean
    doc: Do not consider the reverse complement of contigs.
    inputBinding:
      position: 103
      prefix: --no-reverse-complement
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation.
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write the output reports and files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transrate:1.0.3--h516909a_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastANI
label: fastani
doc: "Fast Whole-Genome Similarity (ANI) estimation. FastANI is a fast alignment-free
  implementation for computing whole-genome Average Nucleotide Identity (ANI).\n\n\
  \ Tool homepage: https://github.com/ParBLiSS/FastANI"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.listed_genomes ? inputs.listed_genomes : [])'
inputs:
  - id: reference_file
    type:
      - 'null'
      - File
    doc: reference genome (fasta/fastq)[.gz]
    inputBinding:
      position: 101
      prefix: --ref
  - id: reference_list
    type:
      - 'null'
      - File
    doc: a file containing list of reference genome files, one genome per line.
      The listed genomes must be given in listed_genomes with the same names.
    inputBinding:
      position: 101
      prefix: --refList
  - id: query_file
    type:
      - 'null'
      - File
    doc: query genome (fasta/fastq)[.gz]
    inputBinding:
      position: 101
      prefix: --query
  - id: query_list
    type:
      - 'null'
      - File
    doc: a file containing list of query genome files, one genome per line. The
      listed genomes must be given in listed_genomes with the same names.
    inputBinding:
      position: 101
      prefix: --queryList
  - id: listed_genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome files named in reference_list or query_list. They are staged in
      the working directory so that the names in the lists resolve.
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size <= 16 [default 16]
    inputBinding:
      position: 101
      prefix: --kmer
  - id: threads
    type:
      - 'null'
      - int
    doc: thread count for parallel execution [default 1]
    inputBinding:
      position: 101
      prefix: --threads
  - id: frag_len
    type:
      - 'null'
      - int
    doc: fragment length [default 3,000]
    inputBinding:
      position: 101
      prefix: --fragLen
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: minimum fraction of genome that must be shared for trusting ANI. If
      reference and query genome size differ, smaller one among the two is
      considered. [default 0.2]
    inputBinding:
      position: 101
      prefix: --minFraction
  - id: max_ratio_diff
    type:
      - 'null'
      - float
    doc: maximum difference between (Total Ref. Length/Total Occ. Hashes) and
      (Total Ref. Length/Total No. Hashes). [default 10.0]
    inputBinding:
      position: 101
      prefix: --maxRatioDiff
  - id: visualize
    type:
      - 'null'
      - boolean
    doc: output mappings for visualization, can be enabled for single genome to
      single genome comparison only [disabled by default]. Written to
      <output>.visual.
    inputBinding:
      position: 101
      prefix: --visualize
  - id: matrix
    type:
      - 'null'
      - boolean
    doc: also output ANI values as lower triangular matrix (format inspired from
      phylip). Written to <output>.matrix.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: sanity_check
    type:
      - 'null'
      - boolean
    doc: run sanity check
    inputBinding:
      position: 101
      prefix: --sanityCheck
  - id: output_file_path
    type: string
    doc: output file name
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: matrix_file
    type:
      - 'null'
      - File
    doc: Lower triangular ANI matrix (with --matrix).
    outputBinding:
      glob: $(inputs.output_file_path).matrix
  - id: visual_file
    type:
      - 'null'
      - File
    doc: Mappings for visualization (with --visualize).
    outputBinding:
      glob: $(inputs.output_file_path).visual
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastani:1.34--h4dfc31f_4

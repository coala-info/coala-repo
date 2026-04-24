cwlVersion: v1.2
class: CommandLineTool
baseCommand: genmap_map
label: genmap_map
doc: "Tool for computing the mappability/frequency on nucleotide sequences. It supports
  multi-fasta files with DNA or RNA alphabets (A, C, G, T/U, N). Frequency is the
  absolute number of occurrences, mappability is the inverse, i.e., 1 / frequency-value.\n\
  \nTool homepage: https://github.com/cpockrandt/genmap"
inputs:
  - id: bedgraph
    type:
      - 'null'
      - boolean
    doc: Output bedgraph files. For each fasta file that was indexed a separate 
      bedgraph-file is created.
    inputBinding:
      position: 101
      prefix: --bedgraph
  - id: csv
    type:
      - 'null'
      - boolean
    doc: 'Output a detailed csv file reporting the locations of each k-mer (WARNING:
      This will produce large files and makes computing the mappability significantly
      slower).'
    inputBinding:
      position: 101
      prefix: --csv
  - id: errors
    type:
      - 'null'
      - int
    doc: Number of errors
    inputBinding:
      position: 101
      prefix: --errors
  - id: exclude_pseudo
    type:
      - 'null'
      - boolean
    doc: Mappability only counts the number of fasta files that contain the 
      k-mer, not the total number of occurrences (i.e., neglects so called- 
      pseudo genes / sequences). This has no effect on the csv output.
    inputBinding:
      position: 101
      prefix: --exclude-pseudo
  - id: frequency_large
    type:
      - 'null'
      - boolean
    doc: Stores frequencies using 16 bit per value (max. value 65535) instead of
      the mappbility using a float per value (32 bit). Applies to all formats 
      (raw, txt, wig, bedgraph).
    inputBinding:
      position: 101
      prefix: --frequency-large
  - id: frequency_small
    type:
      - 'null'
      - boolean
    doc: Stores frequencies using 8 bit per value (max. value 255) instead of 
      the mappbility using a float per value (32 bit). Applies to all formats 
      (raw, txt, wig, bedgraph).
    inputBinding:
      position: 101
      prefix: --frequency-small
  - id: index_file
    type: File
    doc: Path to the index
    inputBinding:
      position: 101
      prefix: --index
  - id: length
    type:
      - 'null'
      - int
    doc: Length of k-mers
    inputBinding:
      position: 101
      prefix: --length
  - id: memory_mapping
    type:
      - 'null'
      - boolean
    doc: Turns memory-mapping on, i.e. the index is not loaded into RAM but 
      accessed directly from secondary-memory. This may increase the overall 
      running time, but do NOT use it if the index lies on network storage.
    inputBinding:
      position: 101
      prefix: --memory-mapping
  - id: no_reverse_complement
    type:
      - 'null'
      - boolean
    doc: Searches the k-mers *NOT* on the reverse strand.
    inputBinding:
      position: 101
      prefix: --no-reverse-complement
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Output raw files, i.e., the binary format of std::vector<T> with T = 
      float, uint8_t or uint16_t (depending on whether -fs or -fl is set). For 
      each fasta file that was indexed a separate file is created. File type is 
      .map, .freq8 or .freq16.
    inputBinding:
      position: 101
      prefix: --raw
  - id: selection_file
    type:
      - 'null'
      - File
    doc: 'Path to a bed file (3 columns: chromosome, start, end) with selected coordinates
      to compute the mappability (e.g., exon coordinates)'
    inputBinding:
      position: 101
      prefix: --selection
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: txt
    type:
      - 'null'
      - boolean
    doc: 'Output human readable text files, i.e., the mappability respectively frequency
      values separated by spaces (depending on whether -fs or -fl is set). For each
      fasta file that was indexed a separate txt file is created. WARNING: This output
      is significantly larger than raw files.'
    inputBinding:
      position: 101
      prefix: --txt
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Outputs some additional information.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    inputBinding:
      position: 101
      prefix: --version-check
  - id: wig
    type:
      - 'null'
      - boolean
    doc: Output wig files, e.g., for adding a custom feature track to genome 
      browsers. For each fasta file that was indexed a separate wig file and 
      chrom.size file is created.
    inputBinding:
      position: 101
      prefix: --wig
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to output directory (or path to filename if only a single fasta 
      files has been indexed)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmap:1.3.0--h9948957_4

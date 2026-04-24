cwlVersion: v1.2
class: CommandLineTool
baseCommand: orfipy
label: orfipy
doc: "By default orfipy reports ORFs as sequences between start and stop codons. See
  ORF searching options to change this behaviour. If no output type, i.e. dna, rna,
  pep, bed or bed12, is specified, default output is bed format to stdout.\n\nTool
  homepage: https://github.com/urmi-21/orfipy"
inputs:
  - id: infile
    type: File
    doc: The input file, in plain Fasta/Fastq or gzipped format, containing 
      Nucletide sequences
    inputBinding:
      position: 1
  - id: between_stops
    type:
      - 'null'
      - boolean
    doc: Output ORFs defined as regions between stop codons (regions free of 
      stop codon). This will set --partial-3 and --partial-5 true.
    inputBinding:
      position: 102
      prefix: --between-stops
  - id: by_frame
    type:
      - 'null'
      - boolean
    doc: Output separate BED files for ORFs by frame. Can be combined with 
      "--longest" to output longest ORFs in each frame. Requires bed option.
    inputBinding:
      position: 102
      prefix: --by-frame
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Max chunk size in MB. This is useful for limiting memory usage when 
      processing large fasta files using multiple processes The files are 
      processed in chunks if file size is greater than chunk-size. By default 
      orfipy computes the chunk size based on available memory and cpu cores. 
      Providing a smaller chunk-size will lower the memory usage but, actual 
      memory used by orfipy can be more than the chunk-size. Providing a very 
      high chunk-size can lead to memory issues for larger sequences such as 
      large chromosomes. It is best to let orfipy decide on the chunk-size.
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case and find ORFs in lower case sequences too. Useful for 
      soft-masked sequences.
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: include_stop
    type:
      - 'null'
      - boolean
    doc: Include stop codon in the results, if a stop codon exists. This output 
      format is compatible with TransDecoder's which includes stop codon 
      coordinates
    inputBinding:
      position: 102
      prefix: --include-stop
  - id: longest
    type:
      - 'null'
      - boolean
    doc: Output a separate BED file for longest ORFs per sequence. Requires bed 
      option.
    inputBinding:
      position: 102
      prefix: --longest
  - id: max_orf_length
    type:
      - 'null'
      - int
    doc: Maximum length of ORF, excluding stop codon (nucleotide)
    inputBinding:
      position: 102
      prefix: --max
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: Minimum length of ORF, excluding stop codon (nucleotide)
    inputBinding:
      position: 102
      prefix: --min
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to outdir
    inputBinding:
      position: 102
      prefix: --outdir
  - id: partial_3
    type:
      - 'null'
      - boolean
    doc: Output ORFs with a start codon but lacking an inframe stop codon. E.g. 
      "ATG TTT AAA"
    inputBinding:
      position: 102
      prefix: --partial-3
  - id: partial_5
    type:
      - 'null'
      - boolean
    doc: Output ORFs with an inframe stop codon lacking an inframe start codon. 
      E.g. "TTT AAA TAG"
    inputBinding:
      position: 102
      prefix: --partial-5
  - id: procs
    type:
      - 'null'
      - int
    doc: Num processor cores to use
    inputBinding:
      position: 102
      prefix: --procs
  - id: show_tables
    type:
      - 'null'
      - boolean
    doc: Print translation tables and exit.
    inputBinding:
      position: 102
      prefix: --show-tables
  - id: single_mode
    type:
      - 'null'
      - boolean
    doc: Run in single mode i.e. no parallel processing (SLOWER). If supplied 
      with procs, this is ignored.
    inputBinding:
      position: 102
      prefix: --single-mode
  - id: start
    type:
      - 'null'
      - string
    doc: Comma-separated list of start-codons. This will override start codons 
      described in translation table. E.g. "--start ATG,ATT"
    inputBinding:
      position: 102
      prefix: --start
  - id: stop
    type:
      - 'null'
      - string
    doc: Comma-separated list of stop codons. This will override stop codons 
      described in translation table. E.g. "--start TAG,TTT"
    inputBinding:
      position: 102
      prefix: --stop
  - id: strand
    type:
      - 'null'
      - string
    doc: Strands to find ORFs [(f)orward,(r)everse,(b)oth]
    inputBinding:
      position: 102
      prefix: --strand
  - id: table
    type:
      - 'null'
      - string
    doc: 'The codon table number to use or path to .json file with codon table. Use
      --show-tables to see available tables compiled from: https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi?chapter=cgencodes'
    inputBinding:
      position: 102
      prefix: --table
outputs:
  - id: bed12
    type:
      - 'null'
      - File
    doc: bed12 out file
    outputBinding:
      glob: $(inputs.bed12)
  - id: bed
    type:
      - 'null'
      - File
    doc: bed out file
    outputBinding:
      glob: $(inputs.bed)
  - id: dna
    type:
      - 'null'
      - File
    doc: fasta (DNA) out file
    outputBinding:
      glob: $(inputs.dna)
  - id: rna
    type:
      - 'null'
      - File
    doc: fasta (RNA) out file
    outputBinding:
      glob: $(inputs.rna)
  - id: pep
    type:
      - 'null'
      - File
    doc: fasta (peptide) out file
    outputBinding:
      glob: $(inputs.pep)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orfipy:0.0.4--py37h96cfd12_1

cwlVersion: v1.2
class: CommandLineTool
baseCommand: AlienTrimmer
label: alientrimmer
doc: "Fast trimming to filter out non-confident nucleotides and alien oligo-nucleotide
  sequences (adapters, primers) in both 5' and 3' read ends\n\nTool homepage: https://gitlab.pasteur.fr/GIPhy/AlienTrimmer"
inputs:
  - id: alien_sequences
    type:
      - 'null'
      - File
    doc: "[SE/PE] input file name containing alien sequence(s); one line per sequence;
      lines starting with '>', '%' or '#' are not considered"
    inputBinding:
      position: 101
      prefix: -a
  - id: alien_sequences_r1
    type:
      - 'null'
      - File
    doc: '[PE] same as -a for only R1 reads'
    inputBinding:
      position: 101
      prefix: --a1
  - id: alien_sequences_r2
    type:
      - 'null'
      - File
    doc: '[PE] same as -a for only R2 reads'
    inputBinding:
      position: 101
      prefix: --a2
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: gzipped output files
    inputBinding:
      position: 101
      prefix: -z
  - id: input_file_r1
    type:
      - 'null'
      - File
    doc: '[PE] FASTQ-formatted R1 input file; filename should end with .gz when gzipped'
    inputBinding:
      position: 101
      prefix: '-1'
  - id: input_file_r2
    type:
      - 'null'
      - File
    doc: '[PE] FASTQ-formatted R2 input file; filename should end with .gz when gzipped'
    inputBinding:
      position: 101
      prefix: '-2'
  - id: input_file_se
    type:
      - 'null'
      - File
    doc: '[SE] FASTQ-formatted input file; filename should end with .gz when gzipped'
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length k for alien sequence occurence searching; must lie between
      5 and 15
    default: 10
    inputBinding:
      position: 101
      prefix: -k
  - id: max_low_quality_percentage
    type:
      - 'null'
      - int
    doc: maximum allowed percentage of low-quality bases per read
    default: 50
    inputBinding:
      position: 101
      prefix: -p
  - id: max_non_troublesome
    type:
      - 'null'
      - int
    doc: "maximum no. allowed successive non-troublesome bases in the 5'/3' regions
      to be trimmed (default: k-1)"
    inputBinding:
      position: 101
      prefix: -m
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: minimum allowed read length
    default: 50
    inputBinding:
      position: 101
      prefix: -l
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: 'Phred+64 FASTQ input file(s) (default: Phred+33)'
    inputBinding:
      position: 101
      prefix: --p64
  - id: phred_cutoff
    type:
      - 'null'
      - int
    doc: Phred quality score cutoff to define low-quality bases; must lie 
      between 0 and 40
    default: 13
    inputBinding:
      position: 101
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_basename
    type:
      - 'null'
      - File
    doc: 'outfile basename: [SE] <name>.fastq[.gz] or [PE] <name>.{1,2,S}.fastq[.gz];
      .gz is added when using option -z'
    outputBinding:
      glob: $(inputs.output_basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alientrimmer:2.1--hdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: bs_seeker2-align.py
label: bs-seeker2_bs_seeker2-align.py
doc: "Aligns reads to a reference genome for bisulfite sequencing analysis.\n\nTool
  homepage: http://pellegrini.mcdb.ucla.edu/BS_Seeker2/"
inputs:
  - id: adapter
    type:
      - 'null'
      - File
    doc: Input text file of your adaptor sequences (to be trimmed from the 3'end
      of the reads, ). Input one seq for dir. lib., twon seqs for undir. lib. 
      One line per sequence. Only the first 10bp will be used
    inputBinding:
      position: 101
      prefix: --adapter
  - id: adapter_mismatch
    type:
      - 'null'
      - int
    doc: Number of mismatches allowed in adapter
    default: 0
    inputBinding:
      position: 101
      prefix: --am
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'Aligner program for short reads mapping: bowtie, bowtie2, soap, rmap'
    default: bowtie
    inputBinding:
      position: 101
      prefix: --aligner
  - id: bt2_p
    type:
      - 'null'
      - int
    doc: Number of threads for bowtie2
    inputBinding:
      position: 101
      prefix: --bt2-p
  - id: bt_p
    type:
      - 'null'
      - int
    doc: Number of threads for bowtie
    inputBinding:
      position: 101
      prefix: --bt-p
  - id: bt_tryhard
    type:
      - 'null'
      - boolean
    doc: Instruct bowtie to try as hard as possible to find valid alignments 
      when they exist
    inputBinding:
      position: 101
      prefix: --bt--tryhard
  - id: cut_site
    type:
      - 'null'
      - string
    doc: 'Cutting sites of restriction enzyme. Ex: MspI(C-CGG), Mael:(C-TAG), double-enzyme
      MspI&Mael:(C-CGG,C-TAG).'
    default: C-CGG
    inputBinding:
      position: 101
      prefix: --cut-site
  - id: db
    type:
      - 'null'
      - Directory
    doc: Path to the reference genome library (generated in preprocessing 
      genome)
    default: /usr/local/bin/bs_utils/reference_genomes
    inputBinding:
      position: 101
      prefix: --db
  - id: end_base
    type:
      - 'null'
      - int
    doc: The last cycle of the read to be mapped
    default: 200
    inputBinding:
      position: 101
      prefix: --end_base
  - id: genome
    type: File
    doc: Name of the reference genome (should be the same as "-f" in 
      bs_seeker2-build.py ) [ex. chr21_hg18.fa]
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_mate1
    type:
      - 'null'
      - File
    doc: 'Input read file, mate 1 (FORMAT: sequences, qseq, fasta, fastq)'
    inputBinding:
      position: 101
      prefix: --input_1
  - id: input_mate2
    type:
      - 'null'
      - File
    doc: 'Input read file, mate 2 (FORMAT: sequences, qseq, fasta, fastq)'
    inputBinding:
      position: 101
      prefix: --input_2
  - id: input_single
    type:
      - 'null'
      - File
    doc: 'Input read file (FORMAT: sequences, qseq, fasta, fastq). Ex: read.fa or
      read.fa.gz'
    inputBinding:
      position: 101
      prefix: --input
  - id: low
    type:
      - 'null'
      - int
    doc: Lower bound of fragment length (excluding C-CGG ends)
    default: 20
    inputBinding:
      position: 101
      prefix: --low
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: The maximum insert size for valid paired-end alignments
    default: 500
    inputBinding:
      position: 101
      prefix: --maxins
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: The minimum insert size for valid paired-end alignments
    default: 0
    inputBinding:
      position: 101
      prefix: --minins
  - id: mismatches
    type:
      - 'null'
      - string
    doc: 'Number (>=1)/Percentage ([0, 1)) of mismatches in one read. Ex: 4 (allow
      4 mismatches) or 0.04 (allow 4% mismatches)'
    default: '4'
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: multiple_hit
    type:
      - 'null'
      - File
    doc: File to store reads with multiple-hits
    inputBinding:
      position: 101
      prefix: --multiple-hit
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress SAM header lines
    default: false
    inputBinding:
      position: 101
      prefix: --no-header
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: bam, sam, bs_seeker1'
    default: bam
    inputBinding:
      position: 101
      prefix: --output-format
  - id: path
    type:
      - 'null'
      - Directory
    doc: 'Path to the aligner program. Detected: bowtie: None, bowtie2: /usr/local/bin,
      rmap: None, soap: None'
    inputBinding:
      position: 101
      prefix: --path
  - id: rmap_p
    type:
      - 'null'
      - int
    doc: Number of threads for rmap
    inputBinding:
      position: 101
      prefix: --rmap-p
  - id: rrbs
    type:
      - 'null'
      - boolean
    doc: Map reads to the Reduced Representation genome
    inputBinding:
      position: 101
      prefix: --rrbs
  - id: soap_p
    type:
      - 'null'
      - int
    doc: Number of threads for soap
    inputBinding:
      position: 101
      prefix: --soap-p
  - id: split_line
    type:
      - 'null'
      - int
    doc: Number of lines per split (the read file will be split into small files
      for mapping. The result will be merged.
    default: 4000000
    inputBinding:
      position: 101
      prefix: --split_line
  - id: start_base
    type:
      - 'null'
      - int
    doc: The first cycle of the read to be mapped
    default: 1
    inputBinding:
      position: 101
      prefix: --start_base
  - id: tag
    type:
      - 'null'
      - string
    doc: '[Y]es for undirectional lib, [N]o for directional'
    default: N
    inputBinding:
      position: 101
      prefix: --tag
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: The path to your temporary directory
    default: /tmp
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: unmapped
    type:
      - 'null'
      - File
    doc: File to store unmapped reads
    inputBinding:
      position: 101
      prefix: --unmapped
  - id: up
    type:
      - 'null'
      - int
    doc: Upper bound of fragment length (excluding C-CGG ends)
    default: 500
    inputBinding:
      position: 101
      prefix: --up
  - id: xs
    type:
      - 'null'
      - string
    doc: 'Filter definition for tag XS, format X,Y. X=0.8 and y=5 indicate that for
      one read, if #(mCH sites)/#(all CH sites)>0.8 and #(mCH sites)>5, then tag XS:i:1;
      or else tag XS:i:0.'
    default: 0.5,5
    inputBinding:
      position: 101
      prefix: --XS
  - id: xsteve
    type:
      - 'null'
      - boolean
    doc: Filter definition for tag XS, proposed by Prof. Steve Jacobsen, reads 
      with at least 3 successive mCHH will be labeled as XS:i:1,useful for plant
      genome, which have high mCHG level. Will override --XS option.
    inputBinding:
      position: 101
      prefix: --XSteve
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The name of output file [INFILE.bs(se|pe|rrbs)]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bs-seeker2:2.1.7--0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: TETyper.py
label: tetyper_TETyper.py
doc: "Given a set of input reads and a reference, TETyper performs typing to identify:
  1. deletions and SNP variation relative to the reference, and 2. the immediate (up
  to ~20bp) sequence(s) flanking the reference.\n\nTool homepage: https://github.com/aesheppard/TETyper"
inputs:
  - id: assembly
    type:
      - 'null'
      - File
    doc: Use this assembly (fasta format) for detecting structural variants 
      instead of generating a new one. This option saves time if an assembly is 
      already available.
    inputBinding:
      position: 101
      prefix: --assembly
  - id: bam
    type:
      - 'null'
      - File
    doc: Bam file containing reads mapped to the given reference. If the reads 
      have already been mapped, this option saves time compared to specifying 
      the reads in fastq format. If this option is specified then --fq* are 
      ignored.
    inputBinding:
      position: 101
      prefix: --bam
  - id: flank_len
    type: int
    doc: Length of flanking region to extract.
    inputBinding:
      position: 101
      prefix: --flank_len
  - id: fq1
    type:
      - 'null'
      - File
    doc: Forward reads. Can be gzipped.
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq12
    type:
      - 'null'
      - File
    doc: Interleaved forward and reverse reads.
    inputBinding:
      position: 101
      prefix: --fq12
  - id: fq2
    type:
      - 'null'
      - File
    doc: Reverse reads. Can be gzipped.
    inputBinding:
      position: 101
      prefix: --fq2
  - id: min_each_strand
    type:
      - 'null'
      - int
    doc: Minimum read number for each strand for including a specific flanking 
      sequence.
    inputBinding:
      position: 101
      prefix: --min_each_strand
  - id: min_mapped_len
    type:
      - 'null'
      - int
    doc: Minimum length of mapping for a read to be used in determining flanking
      sequences. Higher values are more robust to spurious mapping. Lower values
      will recover more reads.
    inputBinding:
      position: 101
      prefix: --min_mapped_len
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum quality value across extracted flanking sequence.
    inputBinding:
      position: 101
      prefix: --min_qual
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum read number for including a specific flanking sequence.
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Flag to prevent accidental overwriting of previous output files. In 
      this mode, the pipeline checks for a log file named according to the given
      output prefix. If it exists then the pipeline exits without modifying any 
      files.
    inputBinding:
      position: 101
      prefix: --no_overwrite
  - id: outprefix
    type: string
    doc: Prefix to use for output files.
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: ref
    type: File
    doc: Reference sequence in fasta format. If not already indexed with bwa, 
      this will be created automatically. A blast database is also required, 
      again this will be created automatically if it does not already exist.
    inputBinding:
      position: 101
      prefix: --ref
  - id: refdb
    type:
      - 'null'
      - File
    doc: Blast database corresponding to reference file (this argument is only 
      needed if the blast database was created with a different name).
    inputBinding:
      position: 101
      prefix: --refdb
  - id: show_region
    type:
      - 'null'
      - string
    doc: Display presence/absence for a specific region of interest within the 
      reference (e.g. to display blaKPC presence/absence with the Tn4401b-1 
      reference, use "7202-8083")
    inputBinding:
      position: 101
      prefix: --show_region
  - id: snp_profiles
    type:
      - 'null'
      - File
    doc: 'File containing known SNP profiles. Tab separated format with three columns.
      First column: variant name, second column: homozygous SNPs, third column: heterozygous
      SNPs. SNPs should be written as "refPOSalt", where "POS" is the position of
      that SNP within the reference, "ref" is the reference base at that position
      (A, C, G or T), and "alt" is the variant base at that position (A, C, G or T
      for a homozygous SNP; M, R, W, S, Y or K for a heterozygous SNP). Multiple SNPs
      of the same type (homozygous or heterozygous) should be ordered by position
      and separated by a "|". "none" indicates no SNPs of the given type.'
    inputBinding:
      position: 101
      prefix: --snp_profiles
  - id: spades_params
    type:
      - 'null'
      - string
    doc: 'Additional parameters for running spades assembly. Enclose in quotes and
      precede with a space. Default: " --cov-cutoff auto --disable-rr". Ignored if
      --assembly is specified.'
    inputBinding:
      position: 101
      prefix: --spades_params
  - id: struct_profiles
    type:
      - 'null'
      - File
    doc: File containing known structural variants. Tab separated format with 
      two columns. First column is variant name. Second column contains a list 
      of sequence ranges representing deletions relative to the reference, or 
      "none" for no deletions. Each range should be written as 
      "startpos-endpos", with multiple ranges ordered by start position and 
      separated by a "|" with no extra whitespace.
    inputBinding:
      position: 101
      prefix: --struct_profiles
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for mapping and assembly steps.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level for logging to stderr. 1 = ERROR, 2 = WARNING, 3 = 
      INFO, 4 = DUBUG.
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetyper:1.1--0
stdout: tetyper_TETyper.py.out

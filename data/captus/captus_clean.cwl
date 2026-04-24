cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - captus
  - clean
label: captus_clean
doc: "Clean; remove adaptors and quality-filter reads with BBTools\n\nTool homepage:
  https://github.com/edgardomortiz/Captus"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: "FASTQ files. Valid filename extensions are: .fq, .fastq, .fq.gz, and .fastq.gz.
      The names must include the string '_R1' (and '_R2' when pairs are provided).
      Everything before the string '_R1' will be used as sample name. There are a
      few ways to provide the FASTQ files: A directory = path to directory containing
      FASTQ files (e.g.: -r ./raw_reads) A list = filenames separated by space (e.g.:
      -r A_R1.fq A_R2.fq B_R1.fq C_R1.fq) A pattern = UNIX matching expression (e.g.:
      -r ./raw_reads/*.fastq.gz)"
    inputBinding:
      position: 1
  - id: adaptor_set
    type:
      - 'null'
      - string
    doc: Set of adaptors to remove Illumina = Illumina adaptors included in 
      BBTools BGI = BGISEQ, DNBSEG, or MGISEQ adaptors ALL = Illumina + BGI 
      Alternatively, you can provide a path to a FASTA file containing your own 
      adaptors
    inputBinding:
      position: 102
      prefix: --adaptor_set
  - id: bbduk_path
    type:
      - 'null'
      - string
    doc: Path to bbduk.sh
    inputBinding:
      position: 102
      prefix: --bbduk_path
  - id: concurrent
    type:
      - 'null'
      - string
    doc: Captus will attempt to run FastQC concurrently on this many samples. If
      set to 'auto', Captus will run at most 4 instances of FastQC or as many 
      CPU cores are available, whatever number is lower
    inputBinding:
      position: 102
      prefix: --concurrent
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging mode, parallelization is disabled so errors are logged
      to screen
    inputBinding:
      position: 102
      prefix: --debug
  - id: falco_path
    type:
      - 'null'
      - string
    doc: Path to Falco
    inputBinding:
      position: 102
      prefix: --falco_path
  - id: fastqc_path
    type:
      - 'null'
      - string
    doc: Path to FastQC
    inputBinding:
      position: 102
      prefix: --fastqc_path
  - id: ftl
    type:
      - 'null'
      - int
    doc: Trim any base to the left of this position. For example, if you want to
      remove 4 bases from the left of the reads set this number to 5
    inputBinding:
      position: 102
      prefix: --ftl
  - id: ftr
    type:
      - 'null'
      - int
    doc: Trim any base to the right of this position. For example, if you want 
      to truncate your reads length to 100 bp set this number to 100
    inputBinding:
      position: 102
      prefix: --ftr
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Do not delete any intermediate files
    inputBinding:
      position: 102
      prefix: --keep_all
  - id: maq
    type:
      - 'null'
      - int
    doc: After quality trimming, reads with average PHRED quality score below 
      this value will be removed
    inputBinding:
      position: 102
      prefix: --maq
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory name
    inputBinding:
      position: 102
      prefix: --out
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous results
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: qc_program
    type:
      - 'null'
      - string
    doc: Which program to use to obtain the statistics from the raw and cleaned 
      FASTQ files. Falco produces identical results to FastQC while being much 
      faster
    inputBinding:
      position: 102
      prefix: --qc_program
  - id: ram
    type:
      - 'null'
      - string
    doc: "Maximum RAM in GB (e.g.: 4.5) dedicated to Captus, 'auto' uses 99% of available
      RAM"
    inputBinding:
      position: 102
      prefix: --ram
  - id: rna
    type:
      - 'null'
      - boolean
    doc: Trim ploy-A tails from RNA-Seq reads
    inputBinding:
      position: 102
      prefix: --rna
  - id: show_less
    type:
      - 'null'
      - boolean
    doc: Do not show individual sample information during the run, the 
      information is still written to the log
    inputBinding:
      position: 102
      prefix: --show_less
  - id: skip_qc_stats
    type:
      - 'null'
      - boolean
    doc: Skip FastQC/Falco analysis on raw and cleaned reads
    inputBinding:
      position: 102
      prefix: --skip_qc_stats
  - id: threads
    type:
      - 'null'
      - string
    doc: Maximum number of CPUs dedicated to Captus, 'auto' uses all available 
      CPUs
    inputBinding:
      position: 102
      prefix: --threads
  - id: trimq
    type:
      - 'null'
      - int
    doc: Leading and trailing read regions with average PHRED quality score 
      below this value will be trimmed
    inputBinding:
      position: 102
      prefix: --trimq
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/captus:1.6.3--pyh05cac1d_0
stdout: captus_clean.out

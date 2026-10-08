cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_differential_primers.py
label: find_differential_primers
doc: "Design diagnostic PCR primers that amplify one group of genomes but not others.
  The tool runs Prodigal, ePrimer3, BLAST and PrimerSearch on the genomes listed in
  a tab-separated configuration file and classifies the primers by group.\n\nTool
  homepage: https://github.com/widdowquinn/find_differential_primers"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
inputs:
  - id: infile
    type: File
    doc: Configuration file. Tab-separated columns are organism abbreviation, 
      group list, FASTA file, GenBank file, ePrimer3 primer file and PrimerSearch
      primer file; use - for no data. Files are looked up by name in the working
      directory, so list every file named in it in data_files.
    inputBinding:
      prefix: --infile
  - id: data_files
    type: File[]
    doc: FASTA, GenBank and primer files named in the configuration file 
      (staged in the working directory by file name)
  - id: outdir
    type: string
    doc: Directory for output files
    inputBinding:
      prefix: --outdir
  - id: logfile
    type: string
    doc: Script logfile location
    inputBinding:
      prefix: --logfile
  - id: numreturn
    type:
      - 'null'
      - int
    doc: number of primers to find
    inputBinding:
      prefix: --numreturn
  - id: hybridprobe
    type:
      - 'null'
      - boolean
    doc: generate internal oligo as a hybridisation probe
    inputBinding:
      prefix: --hybridprobe
  - id: filtergc3prime
    type:
      - 'null'
      - boolean
    doc: allow no more than two GC at the 3` end of primers
    inputBinding:
      prefix: --filtergc3prime
  - id: single_product
    type:
      - 'null'
      - File
    doc: FASTA sequence file containing sequences from which a sequence-specific primer must amplify exactly one product
    inputBinding:
      prefix: --single_product
  - id: prodigal_exe
    type:
      - 'null'
      - string
    doc: location of Prodigal executable
    inputBinding:
      prefix: --prodigal
  - id: eprimer3_exe
    type:
      - 'null'
      - string
    doc: location of EMBOSS eprimer3 executable
    inputBinding:
      prefix: --eprimer3
  - id: blast_exe
    type:
      - 'null'
      - string
    doc: location of BLASTN/BLASTALL executable
    inputBinding:
      prefix: --blast_exe
  - id: blastdb
    type:
      - 'null'
      - File
    doc: location of BLAST database (FASTA file with its formatted BLAST database files beside it)
    inputBinding:
      prefix: --blastdb
    secondaryFiles:
      - pattern: .nhr
        required: false
      - pattern: .nin
        required: false
      - pattern: .nsq
        required: false
  - id: useblast
    type:
      - 'null'
      - boolean
    doc: use existing BLAST results
    inputBinding:
      prefix: --useblast
  - id: nocds
    type:
      - 'null'
      - boolean
    doc: do not restrict primer prediction to CDS
    inputBinding:
      prefix: --nocds
  - id: noprodigal
    type:
      - 'null'
      - boolean
    doc: do not carry out Prodigal prediction step
    inputBinding:
      prefix: --noprodigal
  - id: noprimer3
    type:
      - 'null'
      - boolean
    doc: do not carry out ePrimer3 prediction step
    inputBinding:
      prefix: --noprimer3
  - id: noprimersearch
    type:
      - 'null'
      - boolean
    doc: do not carry out PrimerSearch step
    inputBinding:
      prefix: --noprimersearch
  - id: noclassify
    type:
      - 'null'
      - boolean
    doc: do not carry out primer classification step
    inputBinding:
      prefix: --noclassify
  - id: osize
    type:
      - 'null'
      - int
    doc: optimal size for primer oligo
    inputBinding:
      prefix: --osize
  - id: minsize
    type:
      - 'null'
      - int
    doc: minimum size for primer oligo
    inputBinding:
      prefix: --minsize
  - id: maxsize
    type:
      - 'null'
      - int
    doc: maximum size for primer oligo
    inputBinding:
      prefix: --maxsize
  - id: otm
    type:
      - 'null'
      - float
    doc: optimal melting temperature for primer oligo
    inputBinding:
      prefix: --otm
  - id: mintm
    type:
      - 'null'
      - float
    doc: minimum melting temperature for primer oligo
    inputBinding:
      prefix: --mintm
  - id: maxtm
    type:
      - 'null'
      - float
    doc: maximum melting temperature for primer oligo
    inputBinding:
      prefix: --maxtm
  - id: ogcpercent
    type:
      - 'null'
      - float
    doc: optimal %GC for primer oligo
    inputBinding:
      prefix: --ogcpercent
  - id: mingc
    type:
      - 'null'
      - float
    doc: minimum %GC for primer oligo
    inputBinding:
      prefix: --mingc
  - id: maxgc
    type:
      - 'null'
      - float
    doc: maximum %GC for primer oligo
    inputBinding:
      prefix: --maxgc
  - id: psizeopt
    type:
      - 'null'
      - int
    doc: optimal size for amplified region
    inputBinding:
      prefix: --psizeopt
  - id: psizemin
    type:
      - 'null'
      - int
    doc: minimum size for amplified region
    inputBinding:
      prefix: --psizemin
  - id: psizemax
    type:
      - 'null'
      - int
    doc: maximum size for amplified region
    inputBinding:
      prefix: --psizemax
  - id: maxpolyx
    type:
      - 'null'
      - int
    doc: maximum run of repeated nucleotides in primer
    inputBinding:
      prefix: --maxpolyx
  - id: mismatchpercent
    type:
      - 'null'
      - int
    doc: allowed percentage mismatch in primersearch
    inputBinding:
      prefix: --mismatchpercent
  - id: oligoosize
    type:
      - 'null'
      - int
    doc: optimal size for internal oligo
    inputBinding:
      prefix: --oligoosize
  - id: oligominsize
    type:
      - 'null'
      - int
    doc: minimum size for internal oligo
    inputBinding:
      prefix: --oligominsize
  - id: oligomaxsize
    type:
      - 'null'
      - int
    doc: maximum size for internal oligo
    inputBinding:
      prefix: --oligomaxsize
  - id: oligootm
    type:
      - 'null'
      - float
    doc: optimal melting temperature for internal oligo
    inputBinding:
      prefix: --oligootm
  - id: oligomintm
    type:
      - 'null'
      - float
    doc: minimum melting temperature for internal oligo
    inputBinding:
      prefix: --oligomintm
  - id: oligomaxtm
    type:
      - 'null'
      - float
    doc: maximum melting temperature for internal oligo
    inputBinding:
      prefix: --oligomaxtm
  - id: oligoogcpercent
    type:
      - 'null'
      - float
    doc: optimal %GC for internal oligo
    inputBinding:
      prefix: --oligoogcpercent
  - id: oligomingc
    type:
      - 'null'
      - float
    doc: minimum %GC for internal oligo
    inputBinding:
      prefix: --oligomingc
  - id: oligomaxgc
    type:
      - 'null'
      - float
    doc: maximum %GC for internal oligo
    inputBinding:
      prefix: --oligomaxgc
  - id: oligomaxpolyx
    type:
      - 'null'
      - int
    doc: maximum run of repeated nt in internal oligo
    inputBinding:
      prefix: --oligomaxpolyx
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use in multiprocessing
    inputBinding:
      prefix: --cpus
  - id: sge
    type:
      - 'null'
      - boolean
    doc: use SGE job scheduler
    inputBinding:
      prefix: --sge
  - id: clean
    type:
      - 'null'
      - boolean
    doc: clean up old output files before running
    inputBinding:
      prefix: --clean
  - id: cleanonly
    type:
      - 'null'
      - boolean
    doc: clean up old output files and exit
    inputBinding:
      prefix: --cleanonly
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: report progress to log
    inputBinding:
      prefix: --verbose
  - id: debug
    type:
      - 'null'
      - boolean
    doc: report extra progress to log for debugging
    inputBinding:
      prefix: --debug
  - id: keep_logs
    type:
      - 'null'
      - boolean
    doc: store log files from each process
    inputBinding:
      prefix: --keep_logs
  - id: log_dir
    type:
      - 'null'
      - string
    doc: store called process log files in this directory
    inputBinding:
      prefix: --log_dir
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the primer, amplicon and classification files
    outputBinding:
      glob: $(inputs.outdir)
  - id: log_file
    type: File
    doc: Script log file
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/find_differential_primers:0.1.4--py_0

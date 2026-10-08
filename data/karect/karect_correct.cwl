cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - karect
  - -correct
label: karect_correct
doc: "Correct substitution, insertion and deletion errors in assembly reads from fasta/fastq files.\n\nTool homepage: https://github.com/aminallam/karect"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: inputfile
    type:
      type: array
      items: File
      inputBinding:
        prefix: -inputfile=
        separate: false
    doc: Input fasta/fastq file(s); each is passed with its own -inputfile.
    inputBinding:
      position: 1
  - id: celltype
    type: string
    doc: 'Cell type: haploid or diploid. Use haploid for bacteria and viruses.'
    inputBinding:
      position: 1
      prefix: -celltype=
      separate: false
  - id: matchtype
    type: string
    doc: 'Matching type: edit, hamming or insdel. hamming allows substitution errors only; edit allows insertions, deletions and substitutions with equal costs; insdel doubles the substitution cost.'
    inputBinding:
      position: 1
      prefix: -matchtype=
      separate: false
  - id: inputdir
    type:
      - 'null'
      - string
    doc: Input directory. Ignored if input file paths are complete [Default=.].
    inputBinding:
      position: 1
      prefix: -inputdir=
      separate: false
  - id: resultdir
    type:
      - 'null'
      - string
    doc: Directory to save result file(s) [Default=.].
    inputBinding:
      position: 1
      prefix: -resultdir=
      separate: false
  - id: resultprefix
    type:
      - 'null'
      - string
    doc: Prefix string of the result file(s) [Default=karect_].
    inputBinding:
      position: 1
      prefix: -resultprefix=
      separate: false
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory to save temporary output files [Default=.].
    inputBinding:
      position: 1
      prefix: -tempdir=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [Default=16].
    inputBinding:
      position: 1
      prefix: -threads=
      separate: false
  - id: memory
    type:
      - 'null'
      - double
    doc: Upper bound on the memory that can be used in gigabytes [Default=10240.0].
    inputBinding:
      position: 1
      prefix: -memory=
      separate: false
  - id: aggressive
    type:
      - 'null'
      - double
    doc: Aggressiveness towards error correction [Default=0.42].
    inputBinding:
      position: 1
      prefix: -aggressive=
      separate: false
  - id: numstages
    type:
      - 'null'
      - int
    doc: Number of stages (1 or 2) [Default=1].
    inputBinding:
      position: 1
      prefix: -numstages=
      separate: false
  - id: minoverlap
    type:
      - 'null'
      - int
    doc: Minimum overlap size [Default=35].
    inputBinding:
      position: 1
      prefix: -minoverlap=
      separate: false
  - id: minoverlapper
    type:
      - 'null'
      - double
    doc: Minimum overlap percentage [Default=0.20].
    inputBinding:
      position: 1
      prefix: -minoverlapper=
      separate: false
  - id: minreadweigth
    type:
      - 'null'
      - double
    doc: Minimum read weight [Default=0].
    inputBinding:
      position: 1
      prefix: -minreadweigth=
      separate: false
  - id: errorrate
    type:
      - 'null'
      - double
    doc: First stage maximum allowed error rate [Default=0.25].
    inputBinding:
      position: 1
      prefix: -errorrate=
      separate: false
  - id: errorratesec
    type:
      - 'null'
      - double
    doc: Second stage maximum allowed error rate [Default=0.25].
    inputBinding:
      position: 1
      prefix: -errorratesec=
      separate: false
  - id: reserveval
    type:
      - 'null'
      - double
    doc: Minimum reservation value [Default=100.0].
    inputBinding:
      position: 1
      prefix: -reserveval=
      separate: false
  - id: estcov
    type:
      - 'null'
      - string
    doc: 'Estimate coverage and use it to adjust the minimum reservation value: yes or no [Default=yes].'
    inputBinding:
      position: 1
      prefix: -estcov=
      separate: false
  - id: usequal
    type:
      - 'null'
      - string
    doc: 'Use quality values of candidate reads: yes or no [Default=yes].'
    inputBinding:
      position: 1
      prefix: -usequal=
      separate: false
  - id: higherror
    type:
      - 'null'
      - boolean
    doc: Work in high error rate mode (error rate = 0.50).
    inputBinding:
      position: 1
      prefix: -higherror
  - id: trimfact
    type:
      - 'null'
      - double
    doc: Trimming factor [Default=2.5].
    inputBinding:
      position: 1
      prefix: -trimfact=
      separate: false
  - id: reserveper
    type:
      - 'null'
      - double
    doc: Minimum reservation percentage [Default=1.0].
    inputBinding:
      position: 1
      prefix: -reserveper=
      separate: false
  - id: kmer
    type:
      - 'null'
      - int
    doc: Minimum kmer size (increases according to -kmerfactor) [Default=9].
    inputBinding:
      position: 1
      prefix: -kmer=
      separate: false
  - id: trim
    type:
      - 'null'
      - string
    doc: 'Allow/Disallow trimming: yes or no [Default=no].'
    inputBinding:
      position: 1
      prefix: -trim=
      separate: false
  - id: maxlenmatches
    type:
      - 'null'
      - int
    doc: Maximum number of expected alignment computations (millions) [Default=2000].
    inputBinding:
      position: 1
      prefix: -maxlenmatches=
      separate: false
  - id: maxkmerslots
    type:
      - 'null'
      - int
    doc: Maximum number of kmer slots to be used [Default=100,000].
    inputBinding:
      position: 1
      prefix: -maxkmerslots=
      separate: false
  - id: kmerfactor
    type:
      - 'null'
      - int
    doc: Factor f such that 4^kmersize > total_num_kmers/f [Default=1000].
    inputBinding:
      position: 1
      prefix: -kmerfactor=
      separate: false
  - id: maxkmerres
    type:
      - 'null'
      - int
    doc: Maximum number of kmer results to be used [Default=30].
    inputBinding:
      position: 1
      prefix: -maxkmerres=
      separate: false
  - id: kmererrors
    type:
      - 'null'
      - int
    doc: Maximum allowed kmer errors (0,1,2) [Default=2].
    inputBinding:
      position: 1
      prefix: -kmererrors=
      separate: false
  - id: readsperstep
    type:
      - 'null'
      - int
    doc: Maximum number of processed reads per step [Default=1000].
    inputBinding:
      position: 1
      prefix: -readsperstep=
      separate: false
  - id: fbs
    type:
      - 'null'
      - int
    doc: File block size in megabytes [Default=10].
    inputBinding:
      position: 1
      prefix: -fbs=
      separate: false
  - id: cbs
    type:
      - 'null'
      - int
    doc: Cache block size in megabytes [Default=128].
    inputBinding:
      position: 1
      prefix: -cbs=
      separate: false
outputs:
  - id: corrected_reads
    type:
      type: array
      items: File
    doc: Corrected read files (<resultprefix><input file name>).
    outputBinding:
      glob: |-
        ${
          var p = inputs.resultprefix ? inputs.resultprefix : "karect_";
          var d = inputs.resultdir ? inputs.resultdir + "/" : "";
          return inputs.inputfile.map(function(f) { return d + p + f.basename; });
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/karect:1.0--h9948957_9

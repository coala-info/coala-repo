cwlVersion: v1.2
class: CommandLineTool
baseCommand: runmitos.py
label: mtgrasp_runmitos.py
doc: "\nTool homepage: https://github.com/bcgsc/mtGrasp"
inputs:
  - id: alarab
    type:
      - 'null'
      - boolean
    doc: Use the hmmer based method of Al Arab et al. 2016. This will consider 
      the evalue, ncbicode, fragovl, fragfac
    inputBinding:
      position: 101
      prefix: --alarab
  - id: best
    type:
      - 'null'
      - boolean
    doc: annotate only the best copy of each feature
    inputBinding:
      position: 101
      prefix: --best
  - id: circrot
    type:
      - 'null'
      - string
    doc: 'cir circular: rotate mitogenome by DEG and DEG+180'
    inputBinding:
      position: 101
      prefix: --circrot
  - id: clipfac
    type:
      - 'null'
      - float
    doc: overlapping features of the same name differing by at most a factor of 
      FACTOR are clipped
    inputBinding:
      position: 101
      prefix: --clipfac
  - id: cutoff
    type:
      - 'null'
      - float
    doc: discard positions with quality <.5 of max
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: evalue
    type:
      - 'null'
      - float
    doc: discard BLAST hits with -1*log(e-value)<EVL (EVL < 1 has no effect)
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fasta
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 101
      prefix: --fasta
  - id: finovl
    type:
      - 'null'
      - string
    doc: final overlap <= NRNT nucleotides
    inputBinding:
      position: 101
      prefix: --finovl
  - id: fragfac
    type:
      - 'null'
      - float
    doc: allow fragments to differ in quality/evalue by at most a factor FACTOR.
      Ignored if <= 0.
    inputBinding:
      position: 101
      prefix: --fragfac
  - id: fragovl
    type:
      - 'null'
      - float
    doc: allow query range overlaps up for FRACTION for fragments
    inputBinding:
      position: 101
      prefix: --fragovl
  - id: genetic_code
    type: string
    doc: the genetic code
    inputBinding:
      position: 101
      prefix: --code
  - id: input_file
    type:
      - 'null'
      - File
    doc: the input file
    inputBinding:
      position: 101
      prefix: --input
  - id: intron
    type:
      - 'null'
      - int
    doc: 'position of intron prediction in 1st round (0: skip)'
    default: 0
    inputBinding:
      position: 101
      prefix: --intron
  - id: json_params
    type:
      - 'null'
      - File
    doc: a JSON file with parameters. then outdir is the only other argument 
      needed.
    inputBinding:
      position: 101
      prefix: --json
  - id: linear
    type:
      - 'null'
      - boolean
    doc: treat sequence as linear
    inputBinding:
      position: 101
      prefix: --linear
  - id: locandgloc
    type:
      - 'null'
      - boolean
    doc: 'run mitfi in glocal and local mode (default: local only)'
    inputBinding:
      position: 101
      prefix: --locandgloc
  - id: maxrrnaovl
    type:
      - 'null'
      - int
    doc: allow rRNA overlap of up to X nt for mitfi
    inputBinding:
      position: 101
      prefix: --maxrrnaovl
  - id: maxtrnaovl
    type:
      - 'null'
      - int
    doc: allow tRNA overlap of up to X nt for mitfi
    inputBinding:
      position: 101
      prefix: --maxtrnaovl
  - id: ncbicode
    type:
      - 'null'
      - boolean
    doc: 'use start/stop codons as in NCBI (default: learned start/stop codons)'
    inputBinding:
      position: 101
      prefix: --ncbicode
  - id: ncev
    type:
      - 'null'
      - int
    doc: evalue to use for inferal fast mode
    inputBinding:
      position: 101
      prefix: --ncev
  - id: noplots
    type:
      - 'null'
      - boolean
    doc: do not create the plots.
    inputBinding:
      position: 101
      prefix: --noplots
  - id: oldstst
    type:
      - 'null'
      - boolean
    doc: Use the old start/stop prediction method of MITOS1
    inputBinding:
      position: 101
      prefix: --oldstst
  - id: orih
    type:
      - 'null'
      - int
    doc: 'position of OH prediction in 1st round (0: skip)'
    default: 0
    inputBinding:
      position: 101
      prefix: --orih
  - id: oril
    type:
      - 'null'
      - int
    doc: 'position of OL prediction in 1st round (0: skip)'
    default: 0
    inputBinding:
      position: 101
      prefix: --oril
  - id: output_directory
    type: Directory
    doc: the directory where the output is written.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prot
    type:
      - 'null'
      - int
    doc: 'position of protein prediction in 1st round (0: skip)'
    default: 0
    inputBinding:
      position: 101
      prefix: --prot
  - id: refdir
    type:
      - 'null'
      - Directory
    doc: base directory containing the reference data
    inputBinding:
      position: 101
      prefix: --refdir
  - id: refseqver
    type:
      - 'null'
      - string
    doc: directory containing the reference data (relative to --refdir)
    inputBinding:
      position: 101
      prefix: --refseqver
  - id: rrna
    type:
      - 'null'
      - int
    doc: 'position of rRNA prediction in 1st round (0: skip)'
    default: 0
    inputBinding:
      position: 101
      prefix: --rrna
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: use infernals sensitive mode only
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: trna
    type:
      - 'null'
      - int
    doc: 'position of tRNA prediction in 1st round (0: skip)'
    default: 0
    inputBinding:
      position: 101
      prefix: --trna
  - id: zip
    type:
      - 'null'
      - boolean
    doc: create zip
    inputBinding:
      position: 101
      prefix: --zip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtgrasp:1.1.8--py312h7e72e81_0
stdout: mtgrasp_runmitos.py.out

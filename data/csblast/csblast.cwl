cwlVersion: v1.2
class: CommandLineTool
baseCommand: csblast
label: csblast
doc: "Search with an amino acid sequence against protein databases for locally similar
  sequences.\n\nTool homepage: http://wwwuser.gwdg.de/~compbiol/data/csblast/"
inputs:
  - id: alifile
    type:
      - 'null'
      - File
    doc: Input alignment file for CSI-BLAST restart
    inputBinding:
      position: 101
      prefix: --alifile
  - id: alis
    type:
      - 'null'
      - int
    doc: Number of sequences to show alignments for (def=250)
    default: 250
    inputBinding:
      position: 101
      prefix: --alis
  - id: best
    type:
      - 'null'
      - boolean
    doc: Include only the best HSP per hit in alignment (def=off)
    inputBinding:
      position: 101
      prefix: --best
  - id: blast_path
    type: Directory
    doc: Path to directory with blastpgp executable (or set BLAST_PATH)
    inputBinding:
      position: 101
      prefix: --blast-path
  - id: context_data
    type: File
    doc: Path to profile library with context profiles
    inputBinding:
      position: 101
      prefix: --context-data
  - id: database
    type:
      - 'null'
      - string
    doc: Protein database to search against (def=nr)
    default: nr
    inputBinding:
      position: 101
      prefix: --database
  - id: descr
    type:
      - 'null'
      - int
    doc: Number of sequences to show one-line descriptions for (def=500)
    default: 500
    inputBinding:
      position: 101
      prefix: --descr
  - id: global_weights
    type:
      - 'null'
      - boolean
    doc: Use global instead of position-specific sequence weights (def=off)
    inputBinding:
      position: 101
      prefix: --global-weights
  - id: incl_evalue
    type:
      - 'null'
      - float
    doc: E-value threshold for inclusion in CSI-BLAST (def=0.0020)
    default: 0.002
    inputBinding:
      position: 101
      prefix: --incl-evalue
  - id: infile
    type: File
    doc: Input file with query sequence
    inputBinding:
      position: 101
      prefix: --infile
  - id: iters
    type:
      - 'null'
      - int
    doc: Maximum number of iterations to use in CSI-BLAST (def=1)
    default: 1
    inputBinding:
      position: 101
      prefix: --iters
  - id: pc_admix
    type:
      - 'null'
      - float
    doc: Pseudocount admix for context-specific pseudocounts (def=0.90)
    default: 0.9
    inputBinding:
      position: 101
      prefix: --pc-admix
  - id: pc_ali
    type:
      - 'null'
      - float
    doc: Constant for alignment pseudocounts in CSI-BLAST (def=12.0)
    default: 12.0
    inputBinding:
      position: 101
      prefix: --pc-ali
  - id: pc_engine
    type:
      - 'null'
      - string
    doc: Specify engine for pseudocount generation (def=auto)
    default: auto
    inputBinding:
      position: 101
      prefix: --pc-engine
  - id: pc_neff
    type:
      - 'null'
      - float
    doc: Target Neff for pseudocounts admixture (def=0.00)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --pc-neff
  - id: shift
    type:
      - 'null'
      - float
    doc: Substitution score offset (def=-0.005)
    default: -0.005
    inputBinding:
      position: 101
      prefix: --shift
  - id: weight_center
    type:
      - 'null'
      - float
    doc: Weight of central profile column (def=1.60)
    default: 1.6
    inputBinding:
      position: 101
      prefix: --weight-center
  - id: weight_decay
    type:
      - 'null'
      - float
    doc: Parameter for exponential decay of window weights (def=0.85)
    default: 0.85
    inputBinding:
      position: 101
      prefix: --weight-decay
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file with search results (def=stdout)
    outputBinding:
      glob: $(inputs.outfile)
  - id: alignhits
    type:
      - 'null'
      - File
    doc: Write multiple alignment of hits in PSI format to file
    outputBinding:
      glob: $(inputs.alignhits)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/csblast:2.2.3--h9948957_4

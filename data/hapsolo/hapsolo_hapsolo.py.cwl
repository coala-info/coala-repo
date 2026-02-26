cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapsolo.py
label: hapsolo_hapsolo.py
doc: "Process alignments and BUSCO\"s for selecting reduced assembly candidates\n\n\
  Tool homepage: https://github.com/esolares/HapSolo"
inputs:
  - id: best_n_assemblies
    type:
      - 'null'
      - int
    doc: '# of best candidate assemblies to return using gradient descent.'
    default: 1
    inputBinding:
      position: 101
      prefix: --Bestn
  - id: buscos_dirs
    type: Directory
    doc: Location BUSCO output directories. i.e. buscoN/
    inputBinding:
      position: 101
      prefix: --buscos
  - id: input_fasta
    type: File
    doc: Input Fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: max_consecutive_zeros
    type:
      - 'null'
      - int
    doc: 'Max # of times cost function delta can consecutively be 0.'
    default: 10
    inputBinding:
      position: 101
      prefix: --maxzeros
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum size of contigs for Primary assembly.
    default: 1000
    inputBinding:
      position: 101
      prefix: --min
  - id: min_pid
    type:
      - 'null'
      - float
    doc: Restrict values of PID to be >= the value set here.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --minPID
  - id: min_q
    type:
      - 'null'
      - float
    doc: Restrict values of Q to be >= the value set here.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --minQ
  - id: min_qr
    type:
      - 'null'
      - float
    doc: Restrict values of QR to be >= the value set here. Cannot be 0.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --minQR
  - id: mode
    type:
      - 'null'
      - int
    doc: HapSolo run mode. 0 = Random walking, 1 = No optimization with 
      defaults, 2 = Optimized walking
    default: 0
    inputBinding:
      position: 101
      prefix: --mode
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: '# of total iterations to run per gradient descent.'
    default: 1000
    inputBinding:
      position: 101
      prefix: --niterations
  - id: paf_alignment
    type: File
    doc: Minimap2 PAF alignnment file. Note. paf file functionality is currently
      experimental
    inputBinding:
      position: 101
      prefix: --paf
  - id: psl_alignment
    type: File
    doc: BLAT PSL alignnment file
    inputBinding:
      position: 101
      prefix: --psl
  - id: theta_d
    type:
      - 'null'
      - float
    doc: Weight for duplicate BUSCOs in linear fxn.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --thetaD
  - id: theta_f
    type:
      - 'null'
      - float
    doc: Weight for fragmented BUSCOs in linear fxn.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --thetaF
  - id: theta_m
    type:
      - 'null'
      - float
    doc: Weight for missing BUSCOs in linear fxn.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --thetaM
  - id: theta_s
    type:
      - 'null'
      - float
    doc: Weight for single BUSCOs in linear fxn.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --thetaS
  - id: threads
    type:
      - 'null'
      - int
    doc: '# of threads. Multiplies iterations by threads.'
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapsolo:2021.10.09--py27hdfd78af_0
stdout: hapsolo_hapsolo.py.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Kinfold
label: viennarna_Kinfold
doc: |-
  Stochastic folding simulations of single-stranded nucleic acids. Reads the sequence (and optionally start and stop structures) from standard input.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: input
    type: File
    doc: 'Input file: first line sequence, second line start structure (with --start), following lines
      stop structures (with --stop).'
  - id: dangle
    type:
      - 'null'
      - int
    doc: <0|1|2> set dangling end model to (none|normal|double) (possible values="0", "1", "2" default=`2')
    inputBinding:
      position: 10
      prefix: --dangle=
      separate: false
  - id: temp
    type:
      - 'null'
      - float
    doc: simulation temperature
    inputBinding:
      position: 10
      prefix: --Temp=
      separate: false
  - id: par
    type:
      - 'null'
      - File
    doc: read energy-parameter-file
    inputBinding:
      position: 10
      prefix: --Par=
      separate: false
  - id: log_ml
    type:
      - 'null'
      - boolean
    doc: use logarithmic multiloop energies instead of linear
    inputBinding:
      position: 10
      prefix: --logML
  - id: no_shift
    type:
      - 'null'
      - boolean
    doc: turn off shift-moves
    inputBinding:
      position: 10
      prefix: --noShift
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: forbid structures with isolated base-pairs
    inputBinding:
      position: 10
      prefix: --noLP
  - id: seed
    type:
      - 'null'
      - string
    doc: set random number seed specify 3 integers as int=int=int
    inputBinding:
      position: 10
      prefix: --seed=
      separate: false
  - id: time
    type:
      - 'null'
      - float
    doc: set maxtime of simulation
    inputBinding:
      position: 10
      prefix: --time=
      separate: false
  - id: num
    type:
      - 'null'
      - int
    doc: set number of trajectories
    inputBinding:
      position: 10
      prefix: --num=
      separate: false
  - id: start
    type:
      - 'null'
      - boolean
    doc: read start structure from stdin (otherwise use open chain)
    inputBinding:
      position: 10
      prefix: --start
  - id: stop
    type:
      - 'null'
      - boolean
    doc: read stop structure(s) from stdin (otherwise use MFE)
    inputBinding:
      position: 10
      prefix: --stop
  - id: met
    type:
      - 'null'
      - boolean
    doc: use Metropolis rule for rates (not Kawasaki rule)
    inputBinding:
      position: 10
      prefix: --met
  - id: fpt
    type:
      - 'null'
      - boolean
    doc: compute first passage time (stop when a stop-structure is reached)
    inputBinding:
      position: 10
      prefix: --fpt
  - id: rect
    type:
      - 'null'
      - boolean
    doc: compute recurrence time (of a start structure which is contained in stop structures)
    inputBinding:
      position: 10
      prefix: --rect
  - id: grow
    type:
      - 'null'
      - float
    doc: grow chain every <float> time units
    inputBinding:
      position: 10
      prefix: --grow=
      separate: false
  - id: glen
    type:
      - 'null'
      - int
    doc: initial size of growing chain
    inputBinding:
      position: 10
      prefix: --glen=
      separate: false
  - id: log
    type:
      - 'null'
      - string
    doc: set basename of log-file
    inputBinding:
      position: 10
      prefix: --log=
      separate: false
  - id: silent
    type:
      - 'null'
      - boolean
    doc: no output to stdout
    inputBinding:
      position: 10
      prefix: --silent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: more information to stdout
    inputBinding:
      position: 10
      prefix: --verbose
  - id: lmin
    type:
      - 'null'
      - boolean
    doc: output only local minima to stdout
    inputBinding:
      position: 10
      prefix: --lmin
  - id: cut
    type:
      - 'null'
      - float
    doc: only print structures with E <= MFE + <float> to stdout
    inputBinding:
      position: 10
      prefix: --cut=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: log_files
    type:
      type: array
      items: File
    doc: Trajectory log file(s) (basename set with --log)
    outputBinding:
      glob:
        - '*.log'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
stdout: Kinfold.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/

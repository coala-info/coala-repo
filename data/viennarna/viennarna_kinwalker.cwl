cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kinwalker
label: viennarna_kinwalker
doc: |-
  Predict RNA folding trajectories during transcription. Reads one RNA sequence from standard input and prints the intermediate structures of the predicted folding trajectory with first passage times and energy barriers.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: sequence
    type: File
    doc: File with the RNA sequence on a single line.
  - id: init_structure
    type:
      - 'null'
      - boolean
    doc: Start with a structure other than the open chain.
    inputBinding:
      position: 1
      prefix: --init_structure
  - id: interrupt
    type:
      - 'null'
      - boolean
    doc: Allow interrupted folding trajectories when the barrier is exceeded.
    inputBinding:
      position: 1
      prefix: --interrupt
  - id: printfront
    type:
      - 'null'
      - boolean
    doc: Create PostScript plots of the front progression, named front_trajectory($i).ps.
    inputBinding:
      position: 1
      prefix: --printfront
  - id: test
    type:
      - 'null'
      - boolean
    doc: Use the built-in test sequence.
    inputBinding:
      position: 1
      prefix: --test
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode. Print debugging messages about program progress.
    inputBinding:
      position: 1
      prefix: --verbose
  - id: barrier_heuristic
    type:
      - 'null'
      - string
    doc: 'Barrier heuristic: ''M'' Morgan-Higgs, ''S'' limits small stacks, ''B'' Barriers, ''A'' all,
      then take the minimum. Default M.'
    inputBinding:
      position: 1
      prefix: --barrier_heuristic=
      separate: false
  - id: dangle
    type:
      - 'null'
      - int
    doc: Dangle value 0, 1 or 2 as in the ViennaRNA package. Default 0.
    inputBinding:
      position: 1
      prefix: --dangle=
      separate: false
  - id: grouping
    type:
      - 'null'
      - string
    doc: 'How barrier heuristic M treats conflict groups: standard or regroup. Default standard.'
    inputBinding:
      position: 1
      prefix: --grouping=
      separate: false
  - id: lookahead
    type:
      - 'null'
      - int
    doc: Number of base pairs that Morgan-Higgs forms its subpaths from. Default 1.
    inputBinding:
      position: 1
      prefix: --lookahead=
      separate: false
  - id: maxkeep
    type:
      - 'null'
      - int
    doc: Breadth of the breadth first search in barrier heuristic 'B'. Default 1.
    inputBinding:
      position: 1
      prefix: --maxkeep=
      separate: false
  - id: nolonely
    type:
      - 'null'
      - int
    doc: Value of noLonelyPairs as in ViennaRNA. Default 2.
    inputBinding:
      position: 1
      prefix: --nolonely=
      separate: false
  - id: transcribed
    type:
      - 'null'
      - int
    doc: Number of bases initially transcribed; a negative value means all are transcribed. Default 1.
    inputBinding:
      position: 1
      prefix: --transcribed=
      separate: false
  - id: transcription_rate
    type:
      - 'null'
      - float
    doc: Number of bases transcribed per second. Default 200.
    inputBinding:
      position: 1
      prefix: --transcription_rate=
      separate: false
  - id: windowsize
    type:
      - 'null'
      - int
    doc: Maximum size of substructures considered for folding events during transcription; 0 considers
      all. Default 0.
    inputBinding:
      position: 1
      prefix: --windowsize=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: front_plots
    type:
      type: array
      items: File
    doc: Front progression plots written with --printfront
    outputBinding:
      glob:
        - front_trajectory*.ps
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.sequence.path)
stdout: kinwalker.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/

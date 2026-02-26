cwlVersion: v1.2
class: CommandLineTool
baseCommand: peglit
label: peglit
doc: "Searches for linker sequences, avoiding complementarity to pegRNA sequence.\n\
  \nTool homepage: https://github.com/sshen8/peglit/"
inputs:
  - id: sequence
    type:
      - 'null'
      - string
    doc: "A single pegRNA sequence, to which linker should avoid complementarity,
      in 5' -> 3' orientation. Comma-separated subsequences denote: spacer, scaffold,
      template, PBS, motif."
    inputBinding:
      position: 1
  - id: ac_thresh
    type:
      - 'null'
      - float
    doc: Minimum allowed AC content in linker sequence.
    default: 0.5
    inputBinding:
      position: 102
      prefix: --ac-thresh
  - id: ac_thresh_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --ac-thresh-col
  - id: batch_file
    type:
      - 'null'
      - File
    doc: A headered CSV file containing pegRNA sequences. Must contain columns 
      for spacer, scaffold, template, PBS, motif. Output will be written in a 
      CSV with the same name but appended with _linker_designs.
    inputBinding:
      position: 102
      prefix: --batch
  - id: bottleneck
    type:
      - 'null'
      - int
    doc: Number of sequences to output.
    default: 1
    inputBinding:
      position: 102
      prefix: --bottleneck
  - id: bottleneck_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --bottleneck-col
  - id: clusters
    type:
      - 'null'
      - File
    doc: Filename to save clusters plot.
    inputBinding:
      position: 102
      prefix: --clusters
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Basepairing probabilities are considered equal if their difference is 
      less than this tolerance value.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --epsilon
  - id: epsilon_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --epsilon-col
  - id: linker_pattern
    type:
      - 'null'
      - string
    doc: Nucleotides allowed in linker.
    default: NNNNNNNN
    inputBinding:
      position: 102
      prefix: --linker-pattern
  - id: linker_pattern_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --linker-pattern-col
  - id: motif_thresh
    type:
      - 'null'
      - float
    doc: In verbose output, + indicates predicted structure contains motif that 
      interacts with the rest of the pegRNA with probability greater than 
      threshold.
    default: 0.15
    inputBinding:
      position: 102
      prefix: --motif-thresh
  - id: motif_thresh_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --motif-thresh-col
  - id: n_thresh
    type:
      - 'null'
      - int
    doc: Maximum number of consecutive any nucleotide allowed.
    default: 3
    inputBinding:
      position: 102
      prefix: --n-thresh
  - id: n_thresh_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --n-thresh-col
  - id: num_repeats
    type:
      - 'null'
      - int
    doc: Number of repeats.
    default: 10
    inputBinding:
      position: 102
      prefix: --num-repeats
  - id: num_repeats_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --num-repeats-col
  - id: num_steps
    type:
      - 'null'
      - int
    doc: Number of steps.
    default: 250
    inputBinding:
      position: 102
      prefix: --num-steps
  - id: num_steps_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --num-steps-col
  - id: scaffold_thresh
    type:
      - 'null'
      - float
    doc: In verbose output, * indicates predicted structure contains scaffold 
      that interacts with the rest of the pegRNA with probability greater than 
      threshold.
    default: 0.15
    inputBinding:
      position: 102
      prefix: --scaffold-thresh
  - id: scaffold_thresh_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --scaffold-thresh-col
  - id: seed
    type:
      - 'null'
      - int
    doc: Reproducibly initializes pseudorandom number generator.
    default: 2020
    inputBinding:
      position: 102
      prefix: --seed
  - id: temp_decay
    type:
      - 'null'
      - float
    doc: Multiplicative temperature decay per step.
    default: 0.95
    inputBinding:
      position: 102
      prefix: --temp-decay
  - id: temp_decay_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --temp-decay-col
  - id: temp_init
    type:
      - 'null'
      - float
    doc: Initial temperature.
    default: 0.15
    inputBinding:
      position: 102
      prefix: --temp-init
  - id: temp_init_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --temp-init-col
  - id: topn
    type:
      - 'null'
      - int
    doc: Keep this many of the best linkers. Small value -> better linker 
      sequences. Large value -> potentially more diverse.
    default: 100
    inputBinding:
      position: 102
      prefix: --topn
  - id: topn_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --topn-col
  - id: u_thresh
    type:
      - 'null'
      - int
    doc: Maximum number of consecutive Us allowed in linker sequence.
    default: 3
    inputBinding:
      position: 102
      prefix: --u-thresh
  - id: u_thresh_col
    type:
      - 'null'
      - string
    doc: set algorithm parameters per pegRNA in CSV
    inputBinding:
      position: 102
      prefix: --u-thresh-col
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: In addition to linker sequences, print MFE structure and top Zucker 
      suboptimal structure with linker complementarity.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peglit:1.1.0--pyh7cba7a3_0
stdout: peglit.out

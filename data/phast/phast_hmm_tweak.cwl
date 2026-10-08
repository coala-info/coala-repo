cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmm_tweak
label: phast_hmm_tweak
doc: "Alter transition probabilities in an HMM definition file. After specified operations
  are performed, transition probabilities are renormalized and the adjusted file is
  written to standard out.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: from_cats
    type:
      - 'null'
      - string
    doc: Operate on transitions from states of the specified category names (default all).
    inputBinding:
      position: 1
      prefix: -f
  - id: to_cats
    type:
      - 'null'
      - string
    doc: Operate on transitions to states of the specified category names (default all).
    inputBinding:
      position: 1
      prefix: -t
  - id: multiply
    type:
      - 'null'
      - float
    doc: Multiply transition probabilities by the specified factor.
    inputBinding:
      position: 1
      prefix: -m
  - id: add
    type:
      - 'null'
      - float
    doc: Add the specified constant to transition probabilities.
    inputBinding:
      position: 1
      prefix: -a
  - id: equal
    type:
      - 'null'
      - float
    doc: Set transition probabilities equal to the specified value.
    inputBinding:
      position: 1
      prefix: -e
  - id: indel_cats
    type:
      - 'null'
      - string
    doc: Assume a phylo-HMM indel model for states of the specified category names.
    inputBinding:
      position: 1
      prefix: -i
  - id: tree
    type:
      - 'null'
      - File
    doc: (Required with -i) Assume given tree topology (.nh file).
    inputBinding:
      position: 1
      prefix: -u
  - id: from_gap_patterns
    type:
      - 'null'
      - string
    doc: (For use with -i) Operate on transitions from states of the specified gap-pattern numbers.
    inputBinding:
      position: 1
      prefix: -F
  - id: to_gap_patterns
    type:
      - 'null'
      - string
    doc: (For use with -i) Operate on transitions to states of the specified gap-pattern numbers.
    inputBinding:
      position: 1
      prefix: -T
  - id: equalize
    type:
      - 'null'
      - boolean
    doc: Equalize transition probabilities to their overall average value.
    inputBinding:
      position: 1
      prefix: -z
  - id: restrict
    type:
      - 'null'
      - boolean
    doc: Restrict to successive transitions within a category range.
    inputBinding:
      position: 1
      prefix: -R
  - id: equalize_by_class
    type:
      - 'null'
      - boolean
    doc: Like -z, but compute separate averages for five classes of transitions based on gap patterns.
    inputBinding:
      position: 1
      prefix: -y
  - id: hmm
    type: File
    doc: HMM definition file (file.hmm).
    inputBinding:
      position: 2
  - id: category_map
    type: File
    doc: Category map file (cmap.cm).
    inputBinding:
      position: 3
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the adjusted HMM file (standard output).
    default: tweaked.hmm
outputs:
  - id: tweaked_hmm
    type: File
    doc: Adjusted HMM.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)

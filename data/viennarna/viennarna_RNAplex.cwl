cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAplex
label: viennarna_RNAplex
doc: |-
  Find targets of a query RNA: fast RNA-RNA hybridization search.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: query
    type: File
    doc: File containing the query sequence.
    inputBinding:
      position: 10
      prefix: --query=
      separate: false
  - id: target
    type: File
    doc: File containing the target sequence.
    inputBinding:
      position: 10
      prefix: --target=
      separate: false
  - id: accessibility_dir
    type:
      - 'null'
      - Directory
    doc: Location of the accessibility profiles.
    inputBinding:
      position: 10
      prefix: --accessibility-dir=
      separate: false
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Allow the reading and parsing of memory dumped opening energy file
    inputBinding:
      position: 10
      prefix: --binary
  - id: interaction_length
    type:
      - 'null'
      - int
    doc: Maximal length of an interaction
    inputBinding:
      position: 10
      prefix: --interaction-length=
      separate: false
  - id: extension_cost
    type:
      - 'null'
      - int
    doc: Cost to add to each nucleotide in a duplex
    inputBinding:
      position: 10
      prefix: --extension-cost=
      separate: false
  - id: probe_mode
    type:
      - 'null'
      - boolean
    doc: Compute Tm for probes
    inputBinding:
      position: 10
      prefix: --probe-mode
  - id: probe_concentration
    type:
      - 'null'
      - float
    doc: Set the probe concentration for the Tm computation
    inputBinding:
      position: 10
      prefix: --probe-concentration=
      separate: false
  - id: fast_folding
    type:
      - 'null'
      - int
    doc: Speedup of the target search
    inputBinding:
      position: 10
      prefix: --fast-folding=
      separate: false
  - id: scale_accessibility
    type:
      - 'null'
      - float
    doc: Rescale all opening energy by a factor V
    inputBinding:
      position: 10
      prefix: --scale-accessibility=
      separate: false
  - id: alignment_mode
    type:
      - 'null'
      - boolean
    doc: Tells RNAplex to compute interactions based on alignments
    inputBinding:
      position: 10
      prefix: --alignment-mode
  - id: convert_to_bin
    type:
      - 'null'
      - boolean
    doc: If set, RNAplex will convert all opening energy file in a directory set by the -a option into
      binary opening energy files
    inputBinding:
      position: 10
      prefix: --convert-to-bin
  - id: duplex_distance
    type:
      - 'null'
      - int
    doc: Distance between target 3' ends of two consecutive duplexes
    inputBinding:
      position: 10
      prefix: --duplex-distance=
      separate: false
  - id: energy_threshold
    type:
      - 'null'
      - float
    doc: Minimal energy for a duplex to be returned
    inputBinding:
      position: 10
      prefix: --energy-threshold=
      separate: false
  - id: window_length
    type:
      - 'null'
      - int
    doc: Tells how large the region around the target site should be for redrawing the alignment interaction
    inputBinding:
      position: 10
      prefix: --WindowLength=
      separate: false
  - id: constraint
    type:
      - 'null'
      - boolean
    doc: Calculate structures subject to constraints.
    inputBinding:
      position: 10
      prefix: --constraint
  - id: temp
    type:
      - 'null'
      - float
    doc: Rescale energy parameters to a temperature of temp C. Default is 37C.
    inputBinding:
      position: 10
      prefix: --temp=
      separate: false
  - id: param_file
    type:
      - 'null'
      - File
    doc: Read energy parameters from paramfile, instead of using the default parameter set.
    inputBinding:
      position: 10
      prefix: --paramFile=
      separate: false
  - id: salt
    type:
      - 'null'
      - float
    doc: Set salt concentration in molar (M). Default is 1.021M.
    inputBinding:
      position: 10
      prefix: --salt=
      separate: false
  - id: produce_ps
    type:
      - 'null'
      - string
    doc: Draw an alignment annotated interaction from RNAplex.
    inputBinding:
      position: 10
      prefix: --produce-ps=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: ps_files
    type:
      type: array
      items: File
    doc: PostScript plots written by the program (structure plots, dot plots)
    outputBinding:
      glob:
        - '*.ps'
  - id: interaction_plots
    type:
      type: array
      items: File
    doc: Interaction plots
    outputBinding:
      glob:
        - '*.eps'
        - '*.svg'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAplex.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/

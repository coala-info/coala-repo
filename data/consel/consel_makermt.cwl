cwlVersion: v1.2
class: CommandLineTool
baseCommand: makermt
label: consel_makermt
doc: "Generate multiscale bootstrap replicates of the row sums (<output_base>.rmt) and the observed log-likelihoods (<output_base>.vt) from an mt file or directly from the output of a phylogeny package; the rmt file is the input of consel.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: input_file
    type: File
    doc: "input mt file (or phylogeny package output with a format option; with -g an svt file listing input files)"
    inputBinding:
      position: 2
  - id: output_base
    type:
      - 'null'
      - string
    doc: "base name of the output files (<output_base>.rmt and .vt), without extension"
    default: "makermt_out"
    inputBinding:
      position: 3
  - id: seed
    type:
      - 'null'
      - long
    doc: "random seed (default 0: taken from the system clock)"
    inputBinding:
      position: 1
      prefix: -s
  - id: pa_file
    type:
      - 'null'
      - File
    doc: "pa file giving the scales and the numbers of replicates"
    inputBinding:
      position: 1
      prefix: -p
  - id: bootstrap_factor
    type:
      - 'null'
      - double
    doc: "multiply the numbers of replicates by this value"
    inputBinding:
      position: 1
      prefix: -b
  - id: fast_rescaling
    type:
      - 'null'
      - boolean
    doc: "use one scale only (r=1, B=10000), for the rescaling approximation or SH tests only"
    inputBinding:
      position: 1
      prefix: -f
  - id: multi
    type:
      - 'null'
      - boolean
    doc: "multiple input mode: input (and output) are svt files listing file names"
    inputBinding:
      position: 1
      prefix: -g
  - id: molphy
    type:
      - 'null'
      - boolean
    doc: "input is a Molphy lls file"
    inputBinding:
      position: 1
      prefix: --molphy
  - id: paml
    type:
      - 'null'
      - boolean
    doc: "input is a PAML lnf file"
    inputBinding:
      position: 1
      prefix: --paml
  - id: paup
    type:
      - 'null'
      - boolean
    doc: "input is a PAUP* site-likelihood text file"
    inputBinding:
      position: 1
      prefix: --paup
  - id: puzzle
    type:
      - 'null'
      - boolean
    doc: "input is a TREE-PUZZLE sitelh file"
    inputBinding:
      position: 1
      prefix: --puzzle
  - id: phyml
    type:
      - 'null'
      - boolean
    doc: "input is a PhyML site-likelihood file"
    inputBinding:
      position: 1
      prefix: --phyml
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: "debug mode level"
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: rmt
    type:
      - 'null'
      - File
    doc: "bootstrap replicates (rmt file)"
    outputBinding:
      glob: $(inputs.output_base).rmt
  - id: vt
    type:
      - 'null'
      - File
    doc: "observed log-likelihoods of the items (vt file)"
    outputBinding:
      glob: $(inputs.output_base).vt
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_makermt.log

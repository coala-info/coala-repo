cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - history2ms.pl
label: psmc_history2ms.pl
doc: "Convert a PSMC parameter file into an ms (coalescent simulator) command line\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_psmc_par
    type: File
    doc: "PSMC parameter file"
    inputBinding:
      position: 100
  - id: n
    type:
      - 'null'
      - int
    doc: "Number of chromosomes to simulate (default: 2)"
    inputBinding:
      position: 1
      prefix: "-n"
  - id: L
    type:
      - 'null'
      - int
    doc: "Length of each chromosome (default: 30000000)"
    inputBinding:
      position: 2
      prefix: "-L"
  - id: s
    type:
      - 'null'
      - int
    doc: "Skip used in the psmc run (default: 100)"
    inputBinding:
      position: 3
      prefix: "-s"
  - id: u
    type:
      - 'null'
      - float
    doc: "Neutral mutation rate (default: 2.5e-8)"
    inputBinding:
      position: 4
      prefix: "-u"
  - id: R
    type:
      - 'null'
      - float
    doc: "Recombination rate in hotspots is this many times larger (default: 10)"
    inputBinding:
      position: 5
      prefix: "-R"
  - id: g
    type:
      - 'null'
      - int
    doc: "Years per generation (default: 25)"
    inputBinding:
      position: 6
      prefix: "-g"
  - id: d
    type:
      - 'null'
      - int
    doc: "Divergence time (default: 0)"
    inputBinding:
      position: 7
      prefix: "-d"
  - id: r
    type:
      - 'null'
      - int
    doc: "Number of replicates (default: 1)"
    inputBinding:
      position: 8
      prefix: "-r"
  - id: macs
    type:
      - 'null'
      - boolean
    doc: "Output macs command line"
    inputBinding:
      position: 9
      prefix: "-M"
outputs:
  - id: command
    type: stdout
    doc: "ms or macs command line"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: history2ms.txt

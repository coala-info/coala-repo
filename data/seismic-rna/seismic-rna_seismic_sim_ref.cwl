cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - sim
  - ref
label: seismic-rna_seismic_sim_ref
doc: 'Simulate a FASTA file of a reference sequence.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: sim_dir
    type: string
    default: sim
    doc: 'Write all simulated files to this directory [default: ./sim]'
    inputBinding:
      position: 100
      prefix: --sim-dir
  - id: refs
    type:
      - 'null'
      - string
    doc: 'Give this name to the file of simulated references [default: sim-refs]'
    inputBinding:
      position: 100
      prefix: --refs
  - id: ref
    type:
      - 'null'
      - string
    doc: 'Give this name to the simulated reference [default: sim-ref]'
    inputBinding:
      position: 100
      prefix: --ref
  - id: reflen
    type:
      - 'null'
      - int
    doc: 'Simulate a reference sequence with this many bases [default: 280]'
    inputBinding:
      position: 100
      prefix: --reflen
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --no-force
outputs:
  - id: sim_dir_result
    type: Directory
    doc: Simulation directory with all simulated files
    outputBinding:
      glob: $(inputs.sim_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0

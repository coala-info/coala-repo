cwlVersion: v1.2
class: CommandLineTool
baseCommand: probeit
label: probeit_posnegset
doc: "It generates a probe set with sequences included in the positive genome but
  not in the negative genome\n\nTool homepage: https://github.com/steineggerlab/probeit"
inputs:
  - id: negative_genome
    type:
      - 'null'
      - File
    doc: The genome which MUST NOT be covered by the probes.
    inputBinding:
      position: 101
      prefix: --negative
  - id: not_cluster
    type:
      - 'null'
      - boolean
    doc: Use it when you DO NOT need to cluster positive genome
    inputBinding:
      position: 101
  - id: not_make_probe2
    type:
      - 'null'
      - boolean
    doc: Use it when you DO NOT need to make 2nd probes
    inputBinding:
      position: 101
  - id: not_thermo_filter
    type:
      - 'null'
      - boolean
    doc: Use it when you DO NOT need the thermodynamic filter
    inputBinding:
      position: 101
  - id: positive_genome
    type: File
    doc: The genome which MUST be covered by the probes.
    inputBinding:
      position: 101
      prefix: --positive
  - id: probe1_cover
    type:
      - 'null'
      - int
    doc: The number of times each Seqs from positive genome should be covered by
      1st Probes
    default: 1
    inputBinding:
      position: 101
  - id: probe1_earlystop
    type:
      - 'null'
      - int
    doc: Early stop picking new probes if X% of sequences are covered at least 
      N(--probe1-cover) times
    default: 90
    inputBinding:
      position: 101
  - id: probe1_error
    type:
      - 'null'
      - int
    doc: The number of error allowed in 1st Probes
    default: 0
    inputBinding:
      position: 101
  - id: probe1_len
    type:
      - 'null'
      - int
    doc: Length of 1st Probes
    default: 40
    inputBinding:
      position: 101
  - id: probe1_repeat
    type:
      - 'null'
      - int
    doc: The number of random iterations when minimizing 1st Probes
    default: 1
    inputBinding:
      position: 101
  - id: probe2_cover
    type:
      - 'null'
      - int
    doc: The number of times each 1st Probe should be covered by 2nd Probes
    default: 1
    inputBinding:
      position: 101
  - id: probe2_earlystop
    type:
      - 'null'
      - int
    doc: Early stop picking new probes if X% of sequences are covered at least 
      N(--probe2-cover) times
    default: 99
    inputBinding:
      position: 101
  - id: probe2_error
    type:
      - 'null'
      - int
    doc: The number of error allowed in 2nd Probes
    default: 1
    inputBinding:
      position: 101
  - id: probe2_len
    type:
      - 'null'
      - int
    doc: Length of 2nd Probes
    default: 20
    inputBinding:
      position: 101
  - id: probe2_repeat
    type:
      - 'null'
      - int
    doc: The number of random iterations when minimizing 2nd Probes
    default: 10
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU-cores used
    default: 8
    inputBinding:
      position: 101
  - id: window_size
    type:
      - 'null'
      - int
    doc: size of windows for 2nd probes
    default: 200
    inputBinding:
      position: 101
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory The Directory is automatically created by Probeit.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probeit:2.2--py36hff8b118_0

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
      prefix: --not-cluster
  - id: not_make_probe2
    type:
      - 'null'
      - boolean
    doc: Use it when you DO NOT need to make 2nd probes
    inputBinding:
      position: 101
      prefix: --not-make-probe2
  - id: not_thermo_filter
    type:
      - 'null'
      - boolean
    doc: Use it when you DO NOT need the thermodynamic filter
    inputBinding:
      position: 101
      prefix: --not-thermo-filter
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
    inputBinding:
      position: 101
      prefix: --probe1-cover
  - id: probe1_earlystop
    type:
      - 'null'
      - int
    doc: Early stop picking new probes if X% of sequences are covered at least 
      N(--probe1-cover) times
    inputBinding:
      position: 101
      prefix: --probe1-earlystop
  - id: probe1_error
    type:
      - 'null'
      - int
    doc: The number of error allowed in 1st Probes
    inputBinding:
      position: 101
      prefix: --probe1-error
  - id: probe1_len
    type:
      - 'null'
      - int
    doc: Length of 1st Probes
    inputBinding:
      position: 101
      prefix: --probe1-len
  - id: probe1_repeat
    type:
      - 'null'
      - int
    doc: The number of random iterations when minimizing 1st Probes
    inputBinding:
      position: 101
      prefix: --probe1-repeat
  - id: probe2_cover
    type:
      - 'null'
      - int
    doc: The number of times each 1st Probe should be covered by 2nd Probes
    inputBinding:
      position: 101
      prefix: --probe2-cover
  - id: probe2_earlystop
    type:
      - 'null'
      - int
    doc: Early stop picking new probes if X% of sequences are covered at least 
      N(--probe2-cover) times
    inputBinding:
      position: 101
      prefix: --probe2-earlystop
  - id: probe2_error
    type:
      - 'null'
      - int
    doc: The number of error allowed in 2nd Probes
    inputBinding:
      position: 101
      prefix: --probe2-error
  - id: probe2_len
    type:
      - 'null'
      - int
    doc: Length of 2nd Probes
    inputBinding:
      position: 101
      prefix: --probe2-len
  - id: probe2_repeat
    type:
      - 'null'
      - int
    doc: The number of random iterations when minimizing 2nd Probes
    inputBinding:
      position: 101
      prefix: --probe2-repeat
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU-cores used
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: size of windows for 2nd probes
    inputBinding:
      position: 101
      prefix: --window-size
  - id: output_dir_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory The Directory is automatically created by Probeit.
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probeit:2.2--py36hff8b118_0

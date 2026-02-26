cwlVersion: v1.2
class: CommandLineTool
baseCommand: probeit_snp
label: probeit_snp
doc: "It generates a probe set which detect input amino acid SNPs from strain genome.\n\
  \nTool homepage: https://github.com/steineggerlab/probeit"
inputs:
  - id: max_window
    type:
      - 'null'
      - boolean
    doc: When you need maximum window mode, then use this option. Default window
      mode is minimum window.
    inputBinding:
      position: 101
      prefix: --max-window
  - id: mutations
    type: string
    doc: SNP List. Both amino acid differences and nucleotide differences are 
      allowed.
    inputBinding:
      position: 101
      prefix: --mutations
  - id: not_make_probe2
    type:
      - 'null'
      - boolean
    doc: Use it when you DO NOT need to make 2nd probes
    inputBinding:
      position: 101
      prefix: --not-make-probe2
  - id: positions
    type: string
    doc: 'Position List: The position of this indicates the position of the SNP on
      the 1st Probes'
    inputBinding:
      position: 101
      prefix: --positions
  - id: probe1_len
    type:
      - 'null'
      - int
    doc: Length of 1st Probes
    default: 40
    inputBinding:
      position: 101
      prefix: --probe1-len
  - id: probe2_cover
    type:
      - 'null'
      - int
    doc: The number of times each 1st Probe should be covered by 2nd Probes
    default: 1
    inputBinding:
      position: 101
      prefix: --probe2-cover
  - id: probe2_earlystop
    type:
      - 'null'
      - int
    doc: Early stop picking new probes if X% of sequences are covered at least 
      N(--probe2-cover) times.
    default: 99
    inputBinding:
      position: 101
      prefix: --probe2-earlystop
  - id: probe2_error
    type:
      - 'null'
      - int
    doc: The number of error allowed in 2nd Probes
    default: 1
    inputBinding:
      position: 101
      prefix: --probe2-error
  - id: probe2_len
    type:
      - 'null'
      - int
    doc: Length of 2nd Probes
    default: 20
    inputBinding:
      position: 101
      prefix: --probe2-len
  - id: probe2_repeat
    type:
      - 'null'
      - int
    doc: The number of random iterations when minimizing 2nd Probes
    default: 10
    inputBinding:
      position: 101
      prefix: --probe2-repeat
  - id: reference_annotation
    type: File
    doc: The wildtype genome annotation. Only required when using amino acid 
      differences in the -m option.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: reference_genome
    type: File
    doc: The wildtype genome.
    inputBinding:
      position: 101
      prefix: --reference
  - id: strain_genome
    type: File
    doc: The strain Genome.
    inputBinding:
      position: 101
      prefix: --strain
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU-cores used
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: size of windows for 2nd probes
    default: 200
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory. The Directory is automatically created by Probeit.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probeit:2.2--py36hff8b118_0

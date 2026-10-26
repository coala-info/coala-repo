cwlVersion: v1.2
class: CommandLineTool
baseCommand: umi_simulator
label: umitools_simulator
doc: "A simple in silico PCR simulator. It creates an initial set of molecules for
  one locus, simulates PCR and sequencing and outputs the stats. It is necessary
  to specify the seed, since by default, this simulator uses 0 as the seed\n\nTool
  homepage: https://github.com/weng-lab/umitools"
inputs:
  - id: pcr_cycle
    type: ['null', int]
    doc: number of PCR cycles (default 10)
    inputBinding:
      position: 1
      prefix: --pcr-cycle
  - id: umi_length
    type: ['null', int]
    doc: length of UMI (default 18)
    inputBinding:
      position: 1
      prefix: --umi-length
  - id: pool_size
    type: ['null', int]
    doc: initial pool size (number of molecules before PCR) (default 100)
    inputBinding:
      position: 1
      prefix: --pool-size
  - id: output_size
    type: ['null', int]
    doc: final pool size (sequencing depth, i.e. number of reads sampled from the
      PCR amplified pool) (default 100)
    inputBinding:
      position: 1
      prefix: --output-size
  - id: amplification_rate
    type: ['null', double]
    doc: successful rate of PCR amplification. The actual amplification rate is
      uniformally distributed between this number and 1 (default 0.8)
    inputBinding:
      position: 1
      prefix: --amplification-rate
  - id: pcr_error
    type: ['null', double]
    doc: error rate of PCR amplification (default 3e-05)
    inputBinding:
      position: 1
      prefix: --pcr-error
  - id: sequencing_error
    type: ['null', double]
    doc: error rate of sequencing (default 0.001)
    inputBinding:
      position: 1
      prefix: --sequencing-error
  - id: task
    type: ['null', string]
    doc: tasks to simulate multiple conditions. Other PCR-related arguments are
      ignored when this option is used
    inputBinding:
      position: 1
      prefix: --task
  - id: task_rep
    type: ['null', int]
    doc: number of replicates when doing tasks (default 100)
    inputBinding:
      position: 1
      prefix: --task-rep
  - id: cpu
    type: ['null', int]
    doc: Tasks supporting multiprocessing (default 16)
    inputBinding:
      position: 1
      prefix: --cpu
  - id: seed
    type: ['null', int]
    doc: starting seed (default 0)
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Simulation statistics table
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umitools:0.3.4--py36_0
stdout: umitools_simulator.out

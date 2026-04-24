cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit_binomial
label: transit_binomial
doc: "Performs binomial transit analysis.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig files
    inputBinding:
      position: 1
  - id: annotation_file
    type: File
    doc: Annotation .prot_table or GFF3 file
    inputBinding:
      position: 2
  - id: burn_in_samples
    type:
      - 'null'
      - int
    doc: Number of burn-in samples to take.
    inputBinding:
      position: 103
      prefix: -b
  - id: hyper_M0
    type:
      - 'null'
      - float
    doc: Hyper-parameters for rho, non-essential genes.
    inputBinding:
      position: 103
      prefix: -M0
  - id: hyper_M1
    type:
      - 'null'
      - float
    doc: Hyper-parameters for rho, essential genes.
    inputBinding:
      position: 103
      prefix: -M1
  - id: hyper_a0
    type:
      - 'null'
      - float
    doc: Hyper-parameters for kappa, non-essential genes.
    inputBinding:
      position: 103
      prefix: -a0
  - id: hyper_a1
    type:
      - 'null'
      - float
    doc: Hyper-parameters for kappa, essential genes.
    inputBinding:
      position: 103
      prefix: -a1
  - id: hyper_aw
    type:
      - 'null'
      - float
    doc: Hyper-parameters for prior prob of gene being essential.
    inputBinding:
      position: 103
      prefix: -aw
  - id: hyper_b0
    type:
      - 'null'
      - float
    doc: Hyper-parameters for kappa, non-essential genes.
    inputBinding:
      position: 103
      prefix: -b0
  - id: hyper_b1
    type:
      - 'null'
      - float
    doc: Hyper-parameters for kappa, essential genes.
    inputBinding:
      position: 103
      prefix: -b1
  - id: hyper_bw
    type:
      - 'null'
      - float
    doc: Hyper-parameters for prior prob of gene being essential.
    inputBinding:
      position: 103
      prefix: -bw
  - id: hyper_pi0
    type:
      - 'null'
      - float
    doc: Hyper-parameters for rho, non-essential genes.
    inputBinding:
      position: 103
      prefix: -pi0
  - id: hyper_pi1
    type:
      - 'null'
      - float
    doc: Hyper-parameters for rho, essential genes.
    inputBinding:
      position: 103
      prefix: -pi1
  - id: ignore_c_terminus_percentage
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring at given percentage (as integer) of the C terminus.
    inputBinding:
      position: 103
      prefix: -iC
  - id: ignore_n_terminus_percentage
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring at given percentage (as integer) of the N terminus.
    inputBinding:
      position: 103
      prefix: -iN
  - id: num_samples
    type:
      - 'null'
      - int
    doc: Number of samples to take.
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0

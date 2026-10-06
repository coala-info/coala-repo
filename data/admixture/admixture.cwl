cwlVersion: v1.2
class: CommandLineTool
baseCommand: admixture
label: admixture
doc: "ADMIXTURE is a software tool for maximum likelihood estimation of individual
  ancestries from multilocus SNP genotype datasets.\n\nTool homepage: http://www.genetics.ucla.edu/software/admixture/index.html"
inputs:
  - id: input_file
    type: File
    doc: Input file (PLINK .bed file or PLINK '12' coded .ped file)
    secondaryFiles:
      - pattern: ^.bim
        required: false
      - pattern: ^.fam
        required: false
      - pattern: ^.map
        required: false
    inputBinding:
      position: 1
  - id: k
    type: int
    doc: Number of populations
    inputBinding:
      position: 2
  - id: acceleration
    type:
      - 'null'
      - string
    doc: set acceleration (none, sqs<X>, or qn<X>)
    inputBinding:
      position: 103
      prefix: --acceleration=
      separate: false
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: do bootstrapping [with X replicates]
    inputBinding:
      position: 103
      prefix: -B
      separate: false
  - id: major_convergence_criterion
    type:
      - 'null'
      - float
    doc: set major convergence criterion (for point estimation)
    inputBinding:
      position: 103
      prefix: -C=
      separate: false
  - id: method
    type:
      - 'null'
      - string
    doc: set method (em or block). block is default
    inputBinding:
      position: 103
      prefix: --method=
      separate: false
  - id: minor_convergence_criterion
    type:
      - 'null'
      - float
    doc: set minor convergence criterion (for bootstrap and CV reestimates)
    inputBinding:
      position: 103
      prefix: -c=
      separate: false
  - id: seed
    type:
      - 'null'
      - int
    doc: use random seed X for initialization
    inputBinding:
      position: 103
      prefix: --seed=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: do computation on X threads
    inputBinding:
      position: 103
      prefix: -j
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: q_file
    type: File
    doc: Ancestry fractions (inputBasename.K.Q)
    outputBinding:
      glob: $(inputs.input_file.nameroot).$(inputs.k).Q
  - id: p_file
    type: File
    doc: Allele frequencies of the inferred populations (inputBasename.K.P)
    outputBinding:
      glob: $(inputs.input_file.nameroot).$(inputs.k).P
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixture:1.3.0--0
stdout: admixture.out

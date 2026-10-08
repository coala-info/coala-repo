cwlVersion: v1.2
class: CommandLineTool
baseCommand: structure.py
label: faststructure_structure.py
doc: "Infer population structure from genotype data with the variational Bayes
  algorithm of fastStructure, for a given number of populations K.\n\nTool homepage:
  https://github.com/rajanil/fastStructure"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: k
    type: int
    doc: Number of populations
    inputBinding:
      position: 1
      prefix: -K
  - id: input_genotypes
    type: File
    doc: Genotype file (PLINK .bed with .bim and .fam beside it, or .str file). The
      tool reads it by the path without the extension.
    secondaryFiles:
      - pattern: ^.bim
        required: false
      - pattern: ^.fam
        required: false
    inputBinding:
      position: 2
      prefix: --input=
      separate: false
      valueFrom: $(self.path.replace(/\.(bed|str)$/, ''))
  - id: output_prefix
    type: string
    doc: Output file prefix; results are written as <prefix>.<K>.meanQ, .meanP, .varQ,
      .varP and .log
    inputBinding:
      position: 3
      prefix: --output=
      separate: false
  - id: tol
    type: ['null', float]
    doc: Convergence criterion (default 10e-6)
    inputBinding:
      position: 4
      prefix: --tol=
      separate: false
  - id: prior
    type: ['null', string]
    doc: 'Choice of prior: simple or logistic (default simple)'
    inputBinding:
      position: 5
      prefix: --prior=
      separate: false
  - id: cv
    type: ['null', int]
    doc: Number of test sets for cross-validation, 0 implies no CV step (default 0)
    inputBinding:
      position: 6
      prefix: --cv=
      separate: false
  - id: format
    type: ['null', string]
    doc: 'Format of input file: bed or str (default bed)'
    inputBinding:
      position: 7
      prefix: --format=
      separate: false
  - id: full
    type: ['null', boolean]
    doc: Output all variational parameters
    inputBinding:
      position: 8
      prefix: --full
  - id: seed
    type: ['null', int]
    doc: Seed for the random number generator
    inputBinding:
      position: 9
      prefix: --seed=
      separate: false
outputs:
  - id: results
    type: 'File[]'
    doc: Result files (.meanQ, .meanP, .varQ, .varP, .log) of the run
    outputBinding:
      glob: $(inputs.output_prefix).$(inputs.k).*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/faststructure:1.0--py311h1f01909_6
stdout: faststructure_structure.py.out

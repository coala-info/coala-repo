cwlVersion: v1.2
class: CommandLineTool
baseCommand: reseq replaceN
label: reseq_replaceN
doc: "Replace Ns in reference sequences\n\nTool homepage: https://github.com/schmeing/ReSeq/tree/devel"
inputs:
  - id: ref_in
    type: File
    doc: Reference sequences in fasta format (gz and bz2 supported)
    inputBinding:
      position: 101
      prefix: --refIn
  - id: seed
    type:
      - 'null'
      - string
    doc: Seed used for replacing N, if none is given random seed will be used
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used (0=auto)
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Sets the level of verbosity (4=everything, 0=nothing)
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: ref_sim_path
    type: string
    doc: Output or path parameter `ref_sim_path`
    inputBinding:
      position: 102
      prefix: --ref-sim
outputs:
  - id: ref_sim
    type: File
    doc: File to where reference sequences in fasta format with N's randomly 
      replace should be written to
    outputBinding:
      glob: $(inputs.ref_sim_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5

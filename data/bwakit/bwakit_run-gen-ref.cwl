cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run-gen-ref
label: bwakit_run-gen-ref
doc: "Download a human reference genome analysis set (hs38, hs38a, hs38DH, hs37 or
  hs37d5) and, for hs38a and hs38DH, write the ALT-to-REF mapping (.alt).\n\nTool homepage: https://github.com/lh3/bwa/tree/master/bwakit"
inputs:
  - id: genome_build
    type: string
    doc: 'analysis set: hs38, hs38a, hs38DH, hs37 or hs37d5'
    inputBinding:
      position: 1
outputs:
  - id: reference_fasta
    type: File
    doc: reference genome (<build>.fa)
    outputBinding:
      glob: $(inputs.genome_build).fa
  - id: alt_file
    type:
      - 'null'
      - File
    doc: ALT-to-REF mapping for hs38a and hs38DH (<build>.fa.alt)
    outputBinding:
      glob: $(inputs.genome_build).fa.alt
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwakit:0.7.18.dev1--hdfd78af_0

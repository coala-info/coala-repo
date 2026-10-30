cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ref_seqs_from_bam
label: pomoxis_ref_seqs_from_bam
doc: "Extract the reference sequence that queries are aligned to.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: Input bam file; the MD tag must be set (mini_align -m).
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: false
outputs:
  - id: ref_seqs
    type: stdout
    doc: Reference sequences in fasta format.
stdout: ref_seqs_from_bam.fasta
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0

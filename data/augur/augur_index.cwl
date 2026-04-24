cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur index
label: augur_index
doc: "Count occurrence of bases in a set of sequences.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: sequences
    type: File
    doc: sequences in FASTA or VCF formats. Augur will summarize the content of 
      FASTA sequences and only report the names of strains found in a given VCF.
    inputBinding:
      position: 101
      prefix: --sequences
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print index statistics to stdout
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: tab-delimited file containing the number of bases per sequence in the 
      given file. Output columns include strain, length, and counts for A, C, G,
      T, N, other valid IUPAC characters, ambiguous characters ('?' and '-'), 
      and other invalid characters.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0

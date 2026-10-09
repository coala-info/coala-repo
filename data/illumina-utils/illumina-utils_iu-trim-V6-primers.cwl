cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-trim-V6-primers
label: illumina-utils_iu-trim-V6-primers
doc: "Trim V6 primers from the V6 complete overlap workflow (merged FASTA)

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: input_fasta
    type: File
    doc: "FASTA file that contains archaeal or bacterial V6 sequences with primers (result of iu-merge-pairs with --marker-gene-stringent --retain-only-overlap --max-num-mismatches 0)"
    inputBinding:
      position: 1
  - id: archaea
    type:
      - 'null'
      - boolean
    doc: "When set, primers for archaea are used instead of bacteria."
    inputBinding:
      position: 2
      prefix: '--archaea'
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Turn on debug prints."
    inputBinding:
      position: 3
      prefix: '--debug'
outputs:
  - id: trimmed_files
    type:
      type: array
      items: File
    doc: Files written by the tool next to the input
    outputBinding:
      glob: "*_*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
stdout: illumina-utils_iu-trim-V6-primers.out

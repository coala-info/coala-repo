cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SemiBin2
  - split_contigs
label: semibin_split_contigs
doc: 'Split contigs to generate data (only for strobealign-aemb pipeline).


  Tool homepage: https://github.com/BigDataBiology/SemiBin'
inputs:
  - id: input_fasta
    type: File
    doc: Path to the input fasta file.
    inputBinding:
      position: 1
      prefix: --input-fasta
  - id: output
    type: string
    doc: Output directory (will be created if non-existent)
    inputBinding:
      position: 1
      prefix: --output
  - id: min_len
    type:
      - 'null'
      - int
    doc: Discard sequences below this length (default:0)
    inputBinding:
      position: 1
      prefix: --min-len
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0

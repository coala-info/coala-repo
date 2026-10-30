cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pseudoreverseDB.py
label: msproteomicstools_pseudoreverseDB.py
doc: "Create pseudo-reversed decoys (peptide level reversion) from a FASTA file. If no cleavage site is found the protein is simply reversed.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_fasta
    type: File
    doc: "Input fasta file"
    inputBinding:
      prefix: -i
  - id: output_path
    type: string
    doc: "Output file with decoys"
    inputBinding:
      prefix: -o
  - id: tag
    type: ['null', string]
    doc: "Tag for decoys (default DECOY_)"
    inputBinding:
      prefix: -t
  - id: cleavage_rule
    type: ['null', string]
    doc: "Cleavage rule (default [KR](?!P) = trypsin)"
    inputBinding:
      prefix: -c
outputs:
  - id: output
    type: File
    doc: "FASTA file with decoys"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_pseudoreverseDB.py.out

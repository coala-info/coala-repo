cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbsEncode
label: phast_pbsencode
doc: "Produce an approximate binary encoding of a probabilistic biological sequence
  (PBS), as defined by a text file with a row for each position in the sequence and
  a column for each base. The encoding is defined by a code file in the format used
  by pbsTrain. This program performs the inverse function of pbsDecode.\n\nTool homepage:
  http://compgen.cshl.edu/phast/"
inputs:
  - id: discard_gaps
    type:
      - 'null'
      - boolean
    doc: Discard gaps in the PBS. Gaps in the input data are assumed to be represented
      by rows consisting of a single "-" character.
    inputBinding:
      position: 1
      prefix: --discard-gaps
  - id: input_probs
    type: File
    doc: Text file of base probabilities, one row per position and one column per
      base (for example from prequel).
    inputBinding:
      position: 2
  - id: codefile
    type: File
    doc: Code file produced by pbsTrain.
    inputBinding:
      position: 3
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the binary output file (standard output).
    default: output.bin
outputs:
  - id: encoded
    type: File
    doc: Binary encoding of the PBS.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)

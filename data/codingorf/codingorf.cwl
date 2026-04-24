cwlVersion: v1.2
class: CommandLineTool
baseCommand: codingorf
label: codingorf
doc: "Finds coding regions in a DNA sequence and translates them into amino acid sequences.\n\
  \nTool homepage: https://github.com/Woosub-Kim/codingorf"
inputs:
  - id: input_sequence
    type: string
    doc: The input DNA sequence.
    inputBinding:
      position: 1
  - id: frame
    type:
      - 'null'
      - int
    doc: Reading frame to use (0, 1, or 2). 0 means all frames.
    inputBinding:
      position: 102
      prefix: --frame
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: The genetic code to use for translation (e.g., 'Standard', 'Vertebrate 
      Mitochondrial').
    inputBinding:
      position: 102
      prefix: --genetic-code
  - id: include_stop_codons
    type:
      - 'null'
      - boolean
    doc: Include stop codons in the translated amino acid sequences.
    inputBinding:
      position: 102
      prefix: --include-stop
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: Minimum length of an Open Reading Frame (ORF) to consider.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: strand
    type:
      - 'null'
      - string
    doc: Strand to search for ORFs ('forward', 'reverse', or 'both').
    inputBinding:
      position: 102
      prefix: --strand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file for translated amino acid sequences.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codingorf:v1.0.0--pyh5e36f6f_0

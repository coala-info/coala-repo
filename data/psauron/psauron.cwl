cwlVersion: v1.2
class: CommandLineTool
baseCommand: psauron
label: psauron
doc: "PSAURON: A tool for scoring spliced CDS or protein sequences using deep learning
  to determine protein-coding potential.\n\nTool homepage: https://github.com/salzberg-lab/PSAURON"
inputs:
  - id: all_prob
    type:
      - 'null'
      - boolean
    doc: OPTIONAL set -a to output per-amino-acid predicted probabilities
    inputBinding:
      position: 101
      prefix: --all-prob
  - id: exclude
    type:
      - 'null'
      - string
    doc: OPTIONAL exclude any CDS where FASTA description contains given text 
      (case invariant), e.g. "hypothetical"
    inputBinding:
      position: 101
      prefix: --exclude
  - id: inframe
    type:
      - 'null'
      - float
    doc: OPTIONAL probability threshold used to determine final psauron score, 
      in-frame, higher number decreases sensitivity and increases specificity, 
      range=[0,1]
    inputBinding:
      position: 101
      prefix: --inframe
  - id: input_fasta
    type: File
    doc: REQUIRED path to FASTA with spliced CDS sequence or protein sequence. A
      spliced CDS fasta can be created from a GTF/GFF and a reference FASTA by 
      using gffread.
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: OPTIONAL exclude all proteins shorter than m amino acids
    inputBinding:
      position: 101
      prefix: --minimum-length
  - id: outframe
    type:
      - 'null'
      - float
    doc: OPTIONAL probability threshold used to determine final psauron score, 
      out-of-frame, higher number increases sensitivity and decreases 
      specificity, range=[0,1]
    inputBinding:
      position: 101
      prefix: --outframe
  - id: protein
    type:
      - 'null'
      - boolean
    doc: OPTIONAL set -p if your FASTA contains amino acid protein sequence, 
      which may lower accuracy of the model
    inputBinding:
      position: 101
      prefix: --protein
  - id: single_frame
    type:
      - 'null'
      - boolean
    doc: OPTIONAL set -s to score only the in-frame CDS, which may lower 
      accuracy of the model
    inputBinding:
      position: 101
      prefix: --single-frame
  - id: use_cpu
    type:
      - 'null'
      - boolean
    doc: OPTIONAL set -c to force usage of CPU instead of GPU
    inputBinding:
      position: 101
      prefix: --use-cpu
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: OPTIONAL set -v for verbose output with progress bars etc.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: OPTIONAL path to output results file
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psauron:1.1.0--pyhdfd78af_0

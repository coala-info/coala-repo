cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralverify
label: viralverify
doc: "HMM-based virus and plasmid verification script\n\nTool homepage: https://github.com/ablab/viralVerify"
inputs:
  - id: blast_database
    type:
      - 'null'
      - string
    doc: Run BLAST on input contigs with provided database
    inputBinding:
      position: 101
      prefix: --db
  - id: hmm_database
    type: File
    doc: Path to HMM database
    inputBinding:
      position: 101
      prefix: --hmm
  - id: input_fasta
    type: File
    doc: Input fasta file
    inputBinding:
      position: 101
      prefix: -f
  - id: output_predicted_plasmids
    type:
      - 'null'
      - boolean
    doc: Output predicted plasmids separately
    inputBinding:
      position: 101
      prefix: -p
  - id: sensitivity_threshold
    type:
      - 'null'
      - float
    doc: Sensitivity threshold (minimal absolute score to classify sequence, 
      default = 7)
    default: 7
    inputBinding:
      position: 101
      prefix: --thr
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralverify:1.1--hdfd78af_0

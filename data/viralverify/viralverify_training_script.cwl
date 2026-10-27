cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - training_script
label: viralverify_training_script
doc: "Training script for viralVerify\n\nTool homepage: https://github.com/ablab/viralVerify"
inputs:
  - id: viral_fasta
    type: File
    doc: File with viral nucleotide sequences in fasta format
    inputBinding:
      position: 101
      prefix: -v
  - id: chromosomal_fasta
    type: File
    doc: File with chromosomal nucleotide sequences in fasta format
    inputBinding:
      position: 101
      prefix: -nv
  - id: hmm_database
    type:
      - 'null'
      - File
    doc: Path to HMM database
    inputBinding:
      position: 101
      prefix: --hmm
  - id: plasmid_fasta
    type:
      - 'null'
      - File
    doc: File with plasmid nucleotide sequences in fasta format
    inputBinding:
      position: 101
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: output_directory
    type: string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_directory
    type: Directory
    doc: Output directory with the trained classifier table
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralverify:1.1--hdfd78af_0
stdout: viralverify_training_script.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbinner prep
label: deepbinner_prep
doc: "Prepare training data\n\nTool homepage: https://github.com/rrwick/Deepbinner"
inputs:
  - id: fast5_dir
    type: Directory
    doc: The directory containing the fast5 files (will be searched recursively,
      so can contain subdirectories)
    inputBinding:
      position: 101
      prefix: --fast5_dir
  - id: fastq
    type: File
    doc: a FASTQ file of basecalled reads
    inputBinding:
      position: 101
      prefix: --fastq
  - id: kit
    type: string
    doc: Which kit was used to sequence the data
    inputBinding:
      position: 101
      prefix: --kit
  - id: read_limit
    type:
      - 'null'
      - int
    doc: If provided, will limit the training to this many reads
    inputBinding:
      position: 101
      prefix: --read_limit
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference FASTA file (required for EXP-NBD103 kit)
    inputBinding:
      position: 101
      prefix: --ref
  - id: sequencing_summary
    type:
      - 'null'
      - File
    doc: Basecalling sequencing_summary.txt file (if provided, will be used for 
      barcode classification verification)
    inputBinding:
      position: 101
      prefix: --sequencing_summary
  - id: signal_size
    type:
      - 'null'
      - int
    doc: Amount of signal (number of samples) that will be used in the neural 
      network
    inputBinding:
      position: 101
      prefix: --signal_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
stdout: deepbinner_prep.out

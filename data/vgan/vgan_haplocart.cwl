cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vgan
  - haplocart
label: vgan_haplocart
doc: "Haplocart predicts the mitochondrial haplogroup for reads originating from an
  uncontaminated modern human sample.\n\nTool homepage: https://github.com/grenaud/vgan"
inputs:
  - id: background_error_probability
    type:
      - 'null'
      - float
    doc: Background error probability for FASTA input
    default: 0.0001
    inputBinding:
      position: 101
      prefix: -e
  - id: fasta_input_file
    type:
      - 'null'
      - File
    doc: FASTA consensus input file
    inputBinding:
      position: 101
      prefix: -f
  - id: fastq1_input_file
    type:
      - 'null'
      - File
    doc: FASTQ input file
    inputBinding:
      position: 101
      prefix: -fq1
  - id: fastq2_input_file
    type:
      - 'null'
      - File
    doc: FASTQ second input file (for paired-end reads)
    inputBinding:
      position: 101
      prefix: -fq2
  - id: gam_input_file
    type:
      - 'null'
      - File
    doc: GAM input file
    inputBinding:
      position: 101
      prefix: -g
  - id: hc_files
    type:
      - 'null'
      - Directory
    doc: HaploCart graph directory location
    default: ../share/vgan/hcfiles/
    inputBinding:
      position: 101
      prefix: --hc-files
  - id: interleaved_fastq
    type:
      - 'null'
      - boolean
    doc: Input FASTQ (-fq1) is interleaved
    inputBinding:
      position: 101
      prefix: -i
  - id: json_output_file
    type:
      - 'null'
      - boolean
    doc: JSON output file (must be used with -j)
    inputBinding:
      position: 101
      prefix: -jf
  - id: no_clade_posterior_probabilities
    type:
      - 'null'
      - boolean
    doc: Do not compute clade-level posterior probabilities
    inputBinding:
      position: 101
      prefix: -np
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file
    default: stdout
    inputBinding:
      position: 101
      prefix: -o
  - id: output_json_alignments
    type:
      - 'null'
      - boolean
    doc: Output JSON file of alignments
    inputBinding:
      position: 101
      prefix: -j
  - id: posterior_output_file
    type:
      - 'null'
      - string
    doc: Posterior output file
    default: stdout
    inputBinding:
      position: 101
      prefix: -pf
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: Quiet mode
    inputBinding:
      position: 101
      prefix: -q
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: -s
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    default: /tmp/
    inputBinding:
      position: 101
      prefix: -z
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (-t -1 for all available)
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
stdout: vgan_haplocart.out

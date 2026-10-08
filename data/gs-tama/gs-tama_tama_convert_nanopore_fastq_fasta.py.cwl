cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_convert_nanopore_fastq_fasta.py
label: gs-tama_tama_convert_nanopore_fastq_fasta.py
doc: "This script converts nanopore fastq to fasta\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: fastq_file
    type: File
    doc: Nanopore fastq file
    inputBinding:
      position: 1
  - id: output_file_name
    type: string
    doc: Output file name
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Fasta file
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_convert_nanopore_fastq_fasta.py.out

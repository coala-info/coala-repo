cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapdenovo2-prepare
label: soapdenovo2-prepare
doc: Pre-process data and prepare configuration for SOAPdenovo2 assembly.
inputs:
  - id: config_file
    type: File
    doc: Configuration file containing information about libraries and data 
      paths.
    inputBinding:
      position: 101
      prefix: -c
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size.
    default: 23
    inputBinding:
      position: 101
      prefix: -K
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use.
    default: 8
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for the output files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2-prepare:2.0--h577a1d6_9

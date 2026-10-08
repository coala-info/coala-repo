cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gbsx
  - --GBSsimulator
label: gbsx_GBSsimulator
doc: "GBSX GBS Data Simulator v2.0: simulates GBS data (one or two fastq files, plus a file with the errors per barcode) from a fasta file and a barcode file. Meant for testing.\n\nTool homepage: https://github.com/GenomicsCoreLeuven/GBSX"
inputs:
  - id: out_dir
    type: string
    doc: "Output directory"
    inputBinding:
      position: 101
      prefix: -o
  - id: fasta
    type: File
    doc: "Fasta file; sequences must be oriented from enzyme 1 to enzyme 2"
    inputBinding:
      position: 101
      prefix: -f
  - id: barcode_file
    type: File
    doc: "Barcode file (output of the Barcode Generator)"
    inputBinding:
      position: 101
      prefix: -b
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: "Simulate paired-end reads (standard true); dual barcodes need paired-end mode"
    inputBinding:
      position: 101
      prefix: -p
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: common_adapter
    type:
      - 'null'
      - string
    doc: "Common adapter (standard AGATCGGAAGAGCG)"
    inputBinding:
      position: 101
      prefix: -a
  - id: read_length
    type:
      - 'null'
      - int
    doc: "Read length (standard 100)"
    inputBinding:
      position: 101
      prefix: -l
  - id: reads_per_locus
    type:
      - 'null'
      - int
    doc: "Reads per locus (standard 6)"
    inputBinding:
      position: 101
      prefix: -rpl
  - id: errors
    type:
      - 'null'
      - boolean
    doc: "Simulate sequencing errors (standard true)"
    inputBinding:
      position: 101
      prefix: -e
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory with the simulated fastq files and the error file
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbsx:1.3--0
stdout: gbsx_GBSsimulator.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downpore
  - subseq
label: downpore_subseq
doc: "Reads requests of the form ''<start base> <end base> <true/false> [sequence name]'' from stdin (true/false selects the reverse complement) and writes each requested subsequence of the input fasta to stdout as a two-line fasta record.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: input
    type: File
    doc: 'Fasta/fastq input file'
    inputBinding:
      position: 101
      prefix: -input
  - id: num_workers
    type:
      - 'null'
      - int
    doc: 'Number of worker threads to use (default 4)'
    inputBinding:
      position: 101
      prefix: -num_workers
  - id: himem
    type:
      - 'null'
      - boolean
    doc: 'Whether to cache reads in memory (default false)'
    inputBinding:
      position: 101
      prefix: -himem
      valueFrom: '$(self ? "true" : "false")'
  - id: requests
    type: File
    doc: 'Requests read from stdin, one per line: <start base> <end base> <true/false> [sequence name]'
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Name of the file that receives the output written to stdout
    default: subsequences.fasta
outputs:
  - id: output_file
    type: File
    doc: Requested subsequences (fasta)
    outputBinding:
      glob: $(inputs.output_file_path)
stdout: $(inputs.output_file_path)
stdin: $(inputs.requests.path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_ncbi_chunk_fasta_for_ncbi
label: phyluce_phyluce_ncbi_chunk_fasta_for_ncbi
doc: "Split an input fasta into chunks for processing in 10k sequence units\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: File
    doc: "The input FASTA"
    inputBinding:
      position: 1
      prefix: --input
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "The number of sequences in each chunk (default 10000)"
    inputBinding:
      position: 1
      prefix: --chunk-size
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "The prefix of the chunk files (default split)"
    default: "split"
    inputBinding:
      position: 1
      prefix: --output-prefix
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: "The suffix of the chunk files (default fsa)"
    default: "fsa"
    inputBinding:
      position: 1
      prefix: --output-suffix
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: chunks
    type: {"type": "array", "items": "File"}
    doc: "The chunk files"
    outputBinding:
      glob: $(inputs.output_prefix)_*.$(inputs.output_suffix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_ncbi_chunk_fasta_for_ncbi.out

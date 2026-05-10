cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxnj
label: phyx_pxnj
doc: "Basic neighbour-joining tree maker. This will take fasta, fastq, phylip, and
  nexus inputs from a file or STDIN.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: input_file
    type:
      - 'null'
      - File
    doc: input sequence file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --seqf
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output newick file, STOUT otherwise
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5

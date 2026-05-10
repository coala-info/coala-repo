cwlVersion: v1.2
class: CommandLineTool
baseCommand: stxtyper
label: ncbi-stxtyper_stxtyper
doc: "Determine stx type(s) of a genome, print .tsv-file\n\nTool homepage: https://github.com/ncbi/stxtyper"
inputs:
  - id: amrfinder
    type:
      - 'null'
      - boolean
    doc: Print output in the nucleotide AMRFinderPlus format
    inputBinding:
      position: 101
      prefix: --amrfinder
  - id: blast_dir
    type:
      - 'null'
      - Directory
    doc: Directory for BLAST.
    inputBinding:
      position: 101
      prefix: --blast_bin
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Integrity checks
    inputBinding:
      position: 101
      prefix: --debug
  - id: log
    type:
      - 'null'
      - File
    doc: Error log file, appended, opened on application start
    inputBinding:
      position: 101
      prefix: --log
  - id: name
    type:
      - 'null'
      - string
    doc: Text to be added as the first column "name" to all rows of the report, 
      for example it can be an assembly name
    inputBinding:
      position: 101
      prefix: --name
  - id: nucleotide_fasta
    type:
      - 'null'
      - File
    doc: Input nucleotide FASTA file (can be gzipped)
    inputBinding:
      position: 101
      prefix: --nucleotide
  - id: print_node
    type:
      - 'null'
      - boolean
    doc: Print AMRFinderPlus hierarchy node
    inputBinding:
      position: 101
      prefix: --print_node
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress messages to STDERR
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Max. number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: nucleotide_fasta_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `nucleotide_fasta_out_path`
    inputBinding:
      position: 102
      prefix: --nucleotide-fasta-out
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to OUTPUT_FILE instead of STDOUT
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: nucleotide_fasta_out
    type:
      - 'null'
      - File
    doc: Output nucleotide FASTA file of reported nucleotide sequences
    outputBinding:
      glob: $(inputs.nucleotide_fasta_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-stxtyper:1.0.45--h9948957_0

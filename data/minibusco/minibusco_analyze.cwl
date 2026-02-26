cwlVersion: v1.2
class: CommandLineTool
baseCommand: minibusco_analyze
label: minibusco_analyze
doc: "Miniprot output gff file\n\nTool homepage: https://github.com/huangnengCSU/minibusco"
inputs:
  - id: gff_file
    type: File
    doc: Miniprot output gff file
    inputBinding:
      position: 101
      prefix: --gff
  - id: hmmsearch_execute_path
    type:
      - 'null'
      - string
    doc: Path to hmmsearch executable
    inputBinding:
      position: 101
      prefix: --hmmsearch_execute_path
  - id: library_path
    type:
      - 'null'
      - Directory
    doc: Folder path to stored lineages.
    inputBinding:
      position: 101
      prefix: --library_path
  - id: lineage
    type: string
    doc: BUSCO lineage name
    inputBinding:
      position: 101
      prefix: --lineage
  - id: min_complete
    type:
      - 'null'
      - float
    doc: The length threshold for complete gene.
    inputBinding:
      position: 101
      prefix: --min_complete
  - id: min_diff
    type:
      - 'null'
      - float
    doc: The thresholds for the best matching and second best matching.
    inputBinding:
      position: 101
      prefix: --min_diff
  - id: min_identity
    type:
      - 'null'
      - float
    doc: The identity threshold for valid mapping results. [0, 1]
    default: '[0, 1]'
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: min_length_percent
    type:
      - 'null'
      - float
    doc: The fraction of protein for valid mapping results.
    inputBinding:
      position: 101
      prefix: --min_length_percent
  - id: min_rise
    type:
      - 'null'
      - float
    doc: Minimum length threshold to make dupicate take precedence over single 
      or fragmented over single/duplicate.
    inputBinding:
      position: 101
      prefix: --min_rise
  - id: mode
    type:
      - 'null'
      - string
    doc: 'The mode of evaluation. dafault mode: busco. lite: Without using hmmsearch
      to filtering protein alignment. busco: Using hmmsearch on all candidate protein
      alignment to purify the miniprot alignment to imporve accuracy.'
    default: busco
    inputBinding:
      position: 101
      prefix: --mode
  - id: specified_contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the contigs to be evaluated, e.g. chr1 chr2 chr3. If not 
      specified, all contigs will be evaluated.
    inputBinding:
      position: 101
      prefix: --specified_contigs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output analysis folder
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0

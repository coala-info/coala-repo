cwlVersion: v1.2
class: CommandLineTool
baseCommand: minibusco run
label: minibusco_run
doc: "Run BUSCO analysis with Minibosco\n\nTool homepage: https://github.com/huangnengCSU/minibusco"
inputs:
  - id: assembly_path
    type: File
    doc: Input genome file in FASTA format.
    inputBinding:
      position: 101
      prefix: --assembly_path
  - id: autolineage
    type:
      - 'null'
      - boolean
    doc: "Automatically search for the best matching lineage\n                   \
      \     without specifying lineage file."
    inputBinding:
      position: 101
      prefix: --autolineage
  - id: hmmsearch_execute_path
    type:
      - 'null'
      - File
    doc: Path to hmmsearch executable
    inputBinding:
      position: 101
      prefix: --hmmsearch_execute_path
  - id: library_path
    type:
      - 'null'
      - Directory
    doc: "Folder path to download lineages or already downloaded\n               \
      \         lineages. If not specified, a folder named\n                     \
      \   \"mb_downloads\" will be created on the current running\n              \
      \          path by default to store the downloaded lineage files."
    inputBinding:
      position: 101
      prefix: --library_path
  - id: lineage
    type:
      - 'null'
      - string
    doc: "Specify the name of the BUSCO lineage to be used.\n                    \
      \    (e.g. eukaryota, primates, saccharomycetes etc.)"
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
    doc: "The thresholds for the best matching and second best\n                 \
      \       matching."
    inputBinding:
      position: 101
      prefix: --min_diff
  - id: min_identity
    type:
      - 'null'
      - float
    doc: The identity threshold for valid mapping results.
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
    doc: "Minimum length threshold to make dupicate take\n                       \
      \ precedence over single or fragmented over\n                        single/duplicate."
    inputBinding:
      position: 101
      prefix: --min_rise
  - id: miniprot_execute_path
    type:
      - 'null'
      - File
    doc: Path to miniprot executable
    inputBinding:
      position: 101
      prefix: --miniprot_execute_path
  - id: mode
    type:
      - 'null'
      - string
    doc: "The mode of evaluation. dafault mode: busco. lite: \n                  \
      \      Without using hmmsearch to filtering protein\n                      \
      \  alignment. busco: Using hmmsearch on all candidate\n                    \
      \    protein alignment to purify the miniprot alignment to\n               \
      \         imporve accuracy."
    default: busco
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_dir
    type: Directory
    doc: The output folder.
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: outs
    type:
      - 'null'
      - float
    doc: output if score at least FLOAT*bestScore [0.99]
    default: 0.99
    inputBinding:
      position: 101
      prefix: --outs
  - id: sepp_execute_path
    type:
      - 'null'
      - File
    doc: Path to run_sepp.py executable
    inputBinding:
      position: 101
      prefix: --sepp_execute_path
  - id: specified_contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify the contigs to be evaluated, e.g. chr1 chr2\n                  \
      \      chr3. If not specified, all contigs will be evaluated."
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
stdout: minibusco_run.out

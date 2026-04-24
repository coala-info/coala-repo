cwlVersion: v1.2
class: CommandLineTool
baseCommand: compleasm run
label: compleasm_run
doc: "Run the compleasm analysis.\n\nTool homepage: https://github.com/huangnengCSU/compleasm"
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
    doc: Automatically search for the best matching lineage without specifying 
      lineage file.
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
    doc: Folder path to download lineages or already downloaded lineages. If not
      specified, a folder named "mb_downloads" will be created on the current 
      running path by default to store the downloaded lineage files.
    inputBinding:
      position: 101
      prefix: --library_path
  - id: lineage
    type:
      - 'null'
      - string
    doc: Specify the name of the BUSCO lineage to be used. (e.g. eukaryota, 
      primates, saccharomycetes etc.)
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
    doc: Minimum length threshold to make dupicate take precedence over single 
      or fragmented over single/duplicate.
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
  - id: odb
    type:
      - 'null'
      - string
    doc: 'OrthoDB version, default: odb12'
    inputBinding:
      position: 101
      prefix: --odb
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
    inputBinding:
      position: 101
      prefix: --outs
  - id: retrocopy
    type:
      - 'null'
      - boolean
    doc: Separate retrocopy genes from duplicated genes.
    inputBinding:
      position: 101
      prefix: --retrocopy
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
stdout: compleasm_run.out

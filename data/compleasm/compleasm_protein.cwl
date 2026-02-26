cwlVersion: v1.2
class: CommandLineTool
baseCommand: compleasm_protein
label: compleasm_protein
doc: "Compleasm protein analysis\n\nTool homepage: https://github.com/huangnengCSU/compleasm"
inputs:
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
  - id: odb
    type:
      - 'null'
      - string
    doc: OrthoDB version
    default: odb12
    inputBinding:
      position: 101
      prefix: --odb
  - id: proteins
    type: File
    doc: Input protein file
    inputBinding:
      position: 101
      prefix: --proteins
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type: Directory
    doc: Output analysis folder
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1

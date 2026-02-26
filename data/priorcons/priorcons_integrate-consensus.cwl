cwlVersion: v1.2
class: CommandLineTool
baseCommand: Ellipsis
label: priorcons_integrate-consensus
doc: "Integrates prior information into consensus sequence generation.\n\nTool homepage:
  https://github.com/GERMAN00VP/priorcons"
inputs:
  - id: input
    type: File
    doc: Path to input alignment file (.aln)
    inputBinding:
      position: 101
      prefix: --input
  - id: prior
    type: File
    doc: Path to prior parquet file
    inputBinding:
      position: 101
      prefix: --prior
  - id: ref
    type: string
    doc: Reference sequence ID present in the alignment file
    inputBinding:
      position: 101
      prefix: --ref
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory to write results
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/priorcons:0.1.0--pyhdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: agrvate
label: agrvate
doc: "Rapid identification of Staphylococcus aureus agr type and agr locus variants
  from assemblies.\n\nTool homepage: https://github.com/VishnuRaghuram94/AgrVATE"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_directory
    type: Directory
    doc: Input directory containing assembly files (fasta, fa, fna)
    inputBinding:
      position: 101
      prefix: --input
  - id: mummer_path
    type:
      - 'null'
      - Directory
    doc: Path to MUMmer binaries
    inputBinding:
      position: 101
      prefix: --mummer
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agrvate:1.0.2--hdfd78af_0

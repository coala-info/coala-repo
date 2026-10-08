cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - gwpa
  - fragment
label: deepacstrain_gwpa_fragment
doc: "Fragment genomes for analysis.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: genomes_dir
    type: Directory
    doc: "Directory containing genomes in .fasta"
    inputBinding:
      position: 101
      prefix: --genomes-dir
  - id: read_len
    type:
      - 'null'
      - int
    doc: "Length of extracted reads/fragments (default: 250)"
    inputBinding:
      position: 101
      prefix: --read_len
  - id: shift
    type:
      - 'null'
      - int
    doc: "Shift to start with the next fragment (default:50)"
    inputBinding:
      position: 101
      prefix: --shift
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "genome_frag"
    inputBinding:
      position: 101
      prefix: --out-dir
outputs:
  - id: out
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: altex-be
label: altex-be
doc: "Altex BE: A CLI tool for processing refFlat files and extracting target exons.\n
  \nTool homepage: https://github.com/kinari-labwork/AltEx-BE"
inputs:
  - id: assembly_name
    type: string
    doc: Name of the genome assembly to use
    inputBinding:
      position: 101
      prefix: --assembly-name
  - id: be_end
    type:
      - 'null'
      - int
    doc: Window end for the base editor (Count from next to PAM)
    inputBinding:
      position: 101
      prefix: --be-end
  - id: be_files
    type:
      - 'null'
      - File
    doc: input the path of csv file or txt file of base editor information
    inputBinding:
      position: 101
      prefix: --be-files
  - id: be_name
    type:
      - 'null'
      - string
    doc: Name of the base editor to optional use
    inputBinding:
      position: 101
      prefix: --be-name
  - id: be_pam
    type:
      - 'null'
      - string
    doc: PAM sequence for the base editor
    inputBinding:
      position: 101
      prefix: --be-pam
  - id: be_start
    type:
      - 'null'
      - int
    doc: Window start for the base editor (Count from next to PAM)
    inputBinding:
      position: 101
      prefix: --be-start
  - id: be_type
    type:
      - 'null'
      - string
    doc: Choose the type of base editor, this tool supports ABE and CBE
    inputBinding:
      position: 101
      prefix: --be-type
  - id: ensembl_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: List of interest gene Ensembl IDs (space-separated)
    inputBinding:
      position: 101
      prefix: --ensembl-ids
  - id: fasta_path
    type: File
    doc: Path of FASTA file
    inputBinding:
      position: 101
      prefix: --fasta-path
  - id: gene_file
    type:
      - 'null'
      - File
    doc: Path to a file (csv,txt,tsv) containing gene symbols or IDs correspond to
      reference of transcript (one per line)
    inputBinding:
      position: 101
      prefix: --gene-file
  - id: gene_symbols
    type:
      - 'null'
      - type: array
        items: string
    doc: List of interest gene symbols (space-separated)
    inputBinding:
      position: 101
      prefix: --gene-symbols
  - id: gtf_path
    type:
      - 'null'
      - File
    doc: Path of GTF file
    inputBinding:
      position: 101
      prefix: --gtf-path
  - id: refflat_path
    type:
      - 'null'
      - File
    doc: Path of refflat file
    inputBinding:
      position: 101
      prefix: --refflat-path
  - id: refseq_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: List of interest gene Refseq IDs (space-separated)
    inputBinding:
      position: 101
      prefix: --refseq-ids
outputs:
  - id: output_dir
    type: Directory
    doc: Directory of the output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/altex-be:1.0.5--pyhdfd78af_0

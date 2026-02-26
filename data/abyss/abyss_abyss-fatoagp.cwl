cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-fatoagp
label: abyss_abyss-fatoagp
doc: "Convert FASTA files to AGP format using ABySS\n\nTool homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs:
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional program arguments
    inputBinding:
      position: 1
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Input FASTA file
    inputBinding:
      position: 102
      prefix: -f
  - id: scaffold_id
    type:
      - 'null'
      - string
    doc: Scaffold ID prefix
    inputBinding:
      position: 102
      prefix: -S
  - id: scaffold_size
    type:
      - 'null'
      - int
    doc: Minimum scaffold size
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
stdout: abyss_abyss-fatoagp.out

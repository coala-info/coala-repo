cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - elprep
  - vcf-to-elsites
label: elprep_vcf-to-elsites
doc: "Converts a VCF file to an ELSIF sites file.\n\nTool homepage: https://github.com/ExaScience/elprep"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: elsites_file_name
    type: string
    doc: Name of the output file
    inputBinding:
      position: 2
  - id: log_path
    type:
      - 'null'
      - string
    doc: Path to store logs
    inputBinding:
      position: 102
      prefix: --log-path
outputs:
  - id: elsites_file
    type: File
    doc: Output ELSIF sites file
    outputBinding:
      glob: $(inputs.elsites_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elprep:5.1.3--he881be0_2

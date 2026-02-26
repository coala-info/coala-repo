cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - isescan
label: tooldistillator_isescan
doc: "Extract information from output(s) of isescan (OUTPUT.tsv)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: isescan version for isescan
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: annotation_hid
    type:
      - 'null'
      - string
    doc: Historic ID for gff annotation file from galaxy for isescan
    inputBinding:
      position: 102
      prefix: --annotation_hid
  - id: annotation_path
    type:
      - 'null'
      - File
    doc: isescan annotation gff3 file for isescan
    inputBinding:
      position: 102
      prefix: --annotation_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID for isescan file from galaxy for isescan
    inputBinding:
      position: 102
      prefix: --hid
  - id: is_fna_hid
    type:
      - 'null'
      - string
    doc: Historic ID for IS file from galaxy for isescan
    inputBinding:
      position: 102
      prefix: --is_fna_hid
  - id: is_fna_path
    type:
      - 'null'
      - File
    doc: fasta file with nucleotide IS sequences for isescan
    inputBinding:
      position: 102
      prefix: --is_fna_path
  - id: orf_faa_hid
    type:
      - 'null'
      - string
    doc: Historic ID for orf amino acid file from galaxy for isescan
    inputBinding:
      position: 102
      prefix: --orf_faa_hid
  - id: orf_faa_path
    type:
      - 'null'
      - File
    doc: fasta file with amino acide orf sequences for isescan
    inputBinding:
      position: 102
      prefix: --orf_faa_path
  - id: orf_fna_hid
    type:
      - 'null'
      - string
    doc: Historic ID for orf fasta file from galaxy for isescan
    inputBinding:
      position: 102
      prefix: --orf_fna_hid
  - id: orf_fna_path
    type:
      - 'null'
      - File
    doc: fasta file with nucleotide orf sequences for isescan
    inputBinding:
      position: 102
      prefix: --orf_fna_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for isescan
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: summary_hid
    type:
      - 'null'
      - string
    doc: Historic ID for summary file from galaxy for isescan
    inputBinding:
      position: 102
      prefix: --summary_hid
  - id: summary_path
    type:
      - 'null'
      - File
    doc: summary of isescan analysis for isescan
    inputBinding:
      position: 102
      prefix: --summary_path
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output location
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0

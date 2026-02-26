cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - coreprofiler
label: tooldistillator_coreprofiler
doc: "Extract information from output(s) of coreprofiler (results.tsv)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: alleles_fna_hid
    type:
      - 'null'
      - string
    doc: Historic ID for new alleles FASTA file from galaxy for coreprofiler
    inputBinding:
      position: 102
      prefix: --alleles_fna_hid
  - id: alleles_fna_path
    type:
      - 'null'
      - File
    doc: FASTA file with new alleles sequences if detected for coreprofiler
    inputBinding:
      position: 102
      prefix: --alleles_fna_path
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: coreprofiler version for coreprofiler
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID for coreprofiler file from galaxy for coreprofiler
    inputBinding:
      position: 102
      prefix: --hid
  - id: profiles_json_hid
    type:
      - 'null'
      - string
    doc: Historic ID for profiles JSON file from galaxy for coreprofiler
    inputBinding:
      position: 102
      prefix: --profiles_json_hid
  - id: profiles_json_path
    type:
      - 'null'
      - File
    doc: JSON file containing info about files with temp alleles for 
      coreprofiler
    inputBinding:
      position: 102
      prefix: --profiles_json_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for coreprofiler
    inputBinding:
      position: 102
      prefix: --reference_database_version
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

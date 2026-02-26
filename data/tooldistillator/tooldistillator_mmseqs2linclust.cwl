cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - mmseqs2linclust
label: tooldistillator_mmseqs2linclust
doc: "Extract information from output(s) of mmseqs2linclust (contig.fasta)\n\nTool
  homepage: https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: mmseqs2 version number for mmseqs2linclust
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: cluster_fasta_like_hid
    type:
      - 'null'
      - string
    doc: Historic ID to cluster FASTA-like format from Galaxy for 
      mmseqs2linclust
    inputBinding:
      position: 102
      prefix: --cluster_fasta_like_hid
  - id: cluster_fasta_like_path
    type:
      - 'null'
      - File
    doc: Cluster FASTA-like format for mmseqs2linclust
    inputBinding:
      position: 102
      prefix: --cluster_fasta_like_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to mmseqs2 linclust representative sequence file from 
      Galaxy for mmseqs2linclust
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for mmseqs2linclust
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: tsv_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to cluster TSV file from Galaxy for mmseqs2linclust
    inputBinding:
      position: 102
      prefix: --tsv_file_hid
  - id: tsv_file_path
    type:
      - 'null'
      - File
    doc: Cluster TSV file from mmseqs2 linclust for mmseqs2linclust
    inputBinding:
      position: 102
      prefix: --tsv_file_path
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

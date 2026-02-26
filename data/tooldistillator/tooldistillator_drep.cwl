cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - drep
label: tooldistillator_drep
doc: "Extract information from output(s) of drep (quality_and_cluster_summary.csv)\n\
  \nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: dRep version number for drep
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: bdb_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Bdb file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --bdb_file_hid
  - id: bdb_file_path
    type:
      - 'null'
      - File
    doc: Bdb file for dRep for drep
    inputBinding:
      position: 102
      prefix: --bdb_file_path
  - id: cdb_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Cdb file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --cdb_file_hid
  - id: cdb_file_path
    type:
      - 'null'
      - File
    doc: Cdb file for dRep for drep
    inputBinding:
      position: 102
      prefix: --cdb_file_path
  - id: chdb_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Chdb file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --chdb_file_hid
  - id: chdb_file_path
    type:
      - 'null'
      - File
    doc: Chdb file for dRep for drep
    inputBinding:
      position: 102
      prefix: --chdb_file_path
  - id: cluster_scoring_pdf_hid
    type:
      - 'null'
      - string
    doc: Historic ID to cluster scoring pdf file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --cluster_scoring_pdf_hid
  - id: cluster_scoring_pdf_path
    type:
      - 'null'
      - File
    doc: Cluster scoring pdf file for dRep for drep
    inputBinding:
      position: 102
      prefix: --cluster_scoring_pdf_path
  - id: clustering_scatterplots_pdf_hid
    type:
      - 'null'
      - string
    doc: Historic ID to clustering scatterplots pdf file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --clustering_scatterplots_pdf_hid
  - id: clustering_scatterplots_pdf_path
    type:
      - 'null'
      - File
    doc: Clustering scatterplots pdf file for dRep for drep
    inputBinding:
      position: 102
      prefix: --clustering_scatterplots_pdf_path
  - id: fasta_dereplicated_bin_zip_folder_hid
    type:
      - 'null'
      - string
    doc: Historic ID to dereplicated bin fasta format ZIP folder from Galaxy for
      drep
    inputBinding:
      position: 102
      prefix: --fasta_dereplicated_bin_zip_folder_hid
  - id: fasta_dereplicated_bin_zip_folder_path
    type:
      - 'null'
      - File
    doc: Dereplicated bin fasta format ZIP folder for dRep for drep
    inputBinding:
      position: 102
      prefix: --fasta_dereplicated_bin_zip_folder_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to dRep clusters file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --hid
  - id: log_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to dRep log file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --log_file_hid
  - id: log_file_path
    type:
      - 'null'
      - File
    doc: Log file from dRep for drep
    inputBinding:
      position: 102
      prefix: --log_file_path
  - id: mdb_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Mdb file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --mdb_file_hid
  - id: mdb_file_path
    type:
      - 'null'
      - File
    doc: Mdb file for dRep for drep
    inputBinding:
      position: 102
      prefix: --mdb_file_path
  - id: ndb_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Ndb file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --ndb_file_hid
  - id: ndb_file_path
    type:
      - 'null'
      - File
    doc: Ndb file for dRep for drep
    inputBinding:
      position: 102
      prefix: --ndb_file_path
  - id: primary_clustering_dendrogram_pdf_hid
    type:
      - 'null'
      - string
    doc: Historic ID to primary clustering dendrogram pdf file from Galaxy for 
      drep
    inputBinding:
      position: 102
      prefix: --primary_clustering_dendrogram_pdf_hid
  - id: primary_clustering_dendrogram_pdf_path
    type:
      - 'null'
      - File
    doc: Primary clustering dendrogram pdf file for dRep for drep
    inputBinding:
      position: 102
      prefix: --primary_clustering_dendrogram_pdf_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for drep
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: sdb_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Sdb file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --sdb_file_hid
  - id: sdb_file_path
    type:
      - 'null'
      - File
    doc: Sdb file for dRep for drep
    inputBinding:
      position: 102
      prefix: --sdb_file_path
  - id: secondary_clustering_dendrogram_pdf_hid
    type:
      - 'null'
      - string
    doc: Historic ID to secondary clustering dendrogram pdf file from Galaxy for
      drep
    inputBinding:
      position: 102
      prefix: --secondary_clustering_dendrogram_pdf_hid
  - id: secondary_clustering_dendrogram_pdf_path
    type:
      - 'null'
      - File
    doc: Secondary clustering dendrogram pdf file for dRep for drep
    inputBinding:
      position: 102
      prefix: --secondary_clustering_dendrogram_pdf_path
  - id: secondary_clustering_mds_pdf_hid
    type:
      - 'null'
      - string
    doc: Historic ID to secondary clustering MDS pdf file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --secondary_clustering_mds_pdf_hid
  - id: secondary_clustering_mds_pdf_path
    type:
      - 'null'
      - File
    doc: Secondary clustering MDS pdf file for dRep for drep
    inputBinding:
      position: 102
      prefix: --secondary_clustering_mds_pdf_path
  - id: wdb_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to Wdb file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --wdb_file_hid
  - id: wdb_file_path
    type:
      - 'null'
      - File
    doc: Wdb file for dRep for drep
    inputBinding:
      position: 102
      prefix: --wdb_file_path
  - id: winning_genomes_pdf_hid
    type:
      - 'null'
      - string
    doc: Historic ID to winning genomes pdf file from Galaxy for drep
    inputBinding:
      position: 102
      prefix: --winning_genomes_pdf_hid
  - id: winning_genomes_pdf_path
    type:
      - 'null'
      - File
    doc: Winning genomes pdf file for dRep for drep
    inputBinding:
      position: 102
      prefix: --winning_genomes_pdf_path
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

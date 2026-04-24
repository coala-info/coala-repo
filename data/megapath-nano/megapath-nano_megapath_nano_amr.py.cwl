cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath_nano_amr.py
label: megapath-nano_megapath_nano_amr.py
doc: "MegaPath-Nano: AMR Detection\n\nTool homepage: https://github.com/HKU-BAL/MegaPath-Nano"
inputs:
  - id: blast_perc_identity
    type:
      - 'null'
      - float
    doc: The threshold of percentage of identical matches in blast
    inputBinding:
      position: 101
      prefix: --blast_perc_identity
  - id: blast_qcov_hsp_perc
    type:
      - 'null'
      - float
    doc: The threshold of percentage of query coverage in blast
    inputBinding:
      position: 101
      prefix: --blast_qcov_hsp_perc
  - id: cbmar_prot_db_path
    type:
      - 'null'
      - File
    doc: The path of betalactamase family details in protein, collected from 
      http://proteininformatics.org/mkumar/lactamasedb/cllasification.html.
    inputBinding:
      position: 101
      prefix: --CBMAR_PROT_DB_PATH
  - id: family_details_path
    type:
      - 'null'
      - File
    doc: The path of betalactamase family details in protein, collected from 
      http://proteininformatics.org/mkumar/lactamasedb/cllasification.html.
    inputBinding:
      position: 101
      prefix: --FAMILY_DETAILS_PATH
  - id: nano_dir_path
    type:
      - 'null'
      - Directory
    doc: The path of root directory of MegaPath-Nano
    inputBinding:
      position: 101
      prefix: --NANO_DIR_PATH
  - id: query_bam
    type: File
    doc: Input sorted and indexed bam
    inputBinding:
      position: 101
      prefix: --query_bam
  - id: refseq_path
    type:
      - 'null'
      - Directory
    doc: The path of reference files. RefSeq by default
    inputBinding:
      position: 101
      prefix: --REFSEQ_PATH
  - id: taxon
    type:
      - 'null'
      - string
    doc: 'Taxon-specific options for AMRFinder, curated organisms: Campylobacter,
      Enterococcus_faecalis, Enterococcus_faecium, Escherichia, Klebsiella, Salmonella,
      Staphylococcus_aureus, Staphylococcus_pseudintermedius, Vibrio_cholerae'
    inputBinding:
      position: 101
      prefix: --taxon
  - id: threads
    type:
      - 'null'
      - int
    doc: Num of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_folder
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: download_eggnog_data.py
label: eggnog-mapper_download_eggnog_data.py
doc: "Download eggNOG data\n\nTool homepage: https://github.com/jhcepas/eggnog-mapper"
inputs:
  - id: data_dir
    type:
      - 'null'
      - boolean
    doc: Directory to use for DATA_PATH.
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: db_name
    type:
      - 'null'
      - string
    doc: Tax ID of eggNOG HMM database to download. e.g. "-H -d 2 --dbname 
      'Bacteria'" to download Bacteria (taxid 2) to a directory named Bacteria
    inputBinding:
      position: 101
      prefix: --dbname
  - id: force
    type:
      - 'null'
      - boolean
    doc: forces download even if the files exist
    inputBinding:
      position: 101
      prefix: -f
  - id: hmmer_tax_id
    type:
      - 'null'
      - string
    doc: Tax ID of eggNOG HMM database to download. e.g. "-H -d 2" for Bacteria.
      Required if "-H". Available tax IDs can be found at 
      http://eggnog5.embl.de/#/app/downloads.
    inputBinding:
      position: 101
      prefix: -d
  - id: install_diamond
    type:
      - 'null'
      - boolean
    doc: Do not install the diamond database
    inputBinding:
      position: 101
      prefix: -D
  - id: install_hmmer
    type:
      - 'null'
      - boolean
    doc: Install the HMMER database specified with "-d TAXID". Required for 
      "emapper.py -m hmmer -d TAXID"
    inputBinding:
      position: 101
      prefix: -H
  - id: install_mmseqs2
    type:
      - 'null'
      - boolean
    doc: Install the MMseqs2 database, required for "emapper.py -m mmseqs"
    inputBinding:
      position: 101
      prefix: -M
  - id: install_novel_families
    type:
      - 'null'
      - boolean
    doc: Install the novel families diamond and annotation databases, required 
      for "emapper.py -m novel_fams"
    inputBinding:
      position: 101
      prefix: -F
  - id: install_pfam
    type:
      - 'null'
      - boolean
    doc: Install the Pfam database, required for de novo annotation or 
      realignment
    inputBinding:
      position: 101
      prefix: -P
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet_mode
    inputBinding:
      position: 101
      prefix: -q
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: simulate and print commands. Nothing is downloaded
    inputBinding:
      position: 101
      prefix: -s
  - id: yes
    type:
      - 'null'
      - boolean
    doc: assume "yes" to all questions
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eggnog-mapper:2.1.13--pyhdfd78af_2
stdout: eggnog-mapper_download_eggnog_data.py.out

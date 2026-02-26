cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgatk
  - ensembl-downloader
label: pypgatk_ensembl-downloader
doc: "This tool enables to download from enseml ftp the FASTA and GTF files\n\nTool
  homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: config_file
    type:
      - 'null'
      - string
    doc: Configuration file for the ensembl data downloader pipeline
    inputBinding:
      position: 101
      prefix: --config_file
  - id: ensembl_name
    type:
      - 'null'
      - string
    doc: Ensembl name code to download, it can be use instead of taxonomy (e.g. 
      homo_sapiens)
    inputBinding:
      position: 101
      prefix: --ensembl_name
  - id: folder_prefix_release
    type:
      - 'null'
      - string
    doc: Output folder prefix to download the data
    inputBinding:
      position: 101
      prefix: --folder_prefix_release
  - id: grch37
    type:
      - 'null'
      - boolean
    doc: Download a previous version GRCh37 of ensembl genomes
    inputBinding:
      position: 101
      prefix: --grch37
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for the peptide databases
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: skip_cdna
    type:
      - 'null'
      - boolean
    doc: Skip the cDNA file download
    inputBinding:
      position: 101
      prefix: --skip_cdna
  - id: skip_cds
    type:
      - 'null'
      - boolean
    doc: Skip the CDS file download
    inputBinding:
      position: 101
      prefix: --skip_cds
  - id: skip_dna
    type:
      - 'null'
      - boolean
    doc: Skip the DNA (reference genome assembly) file download
    inputBinding:
      position: 101
      prefix: --skip_dna
  - id: skip_gtf
    type:
      - 'null'
      - boolean
    doc: Skip the GTF file during the download
    inputBinding:
      position: 101
      prefix: --skip_gtf
  - id: skip_ncrna
    type:
      - 'null'
      - boolean
    doc: Skip the ncRNA file download
    inputBinding:
      position: 101
      prefix: --skip_ncrna
  - id: skip_protein
    type:
      - 'null'
      - boolean
    doc: Skip the protein fasta file during download
    inputBinding:
      position: 101
      prefix: --skip_protein
  - id: skip_vcf
    type:
      - 'null'
      - boolean
    doc: Skip the VCF variant file
    inputBinding:
      position: 101
      prefix: --skip_vcf
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Taxonomy identifiers (comma separated list can be given) that will be 
      use to download the data from Ensembl
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: url_file
    type:
      - 'null'
      - File
    doc: Add the url to a downloaded file
    inputBinding:
      position: 101
      prefix: --url_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
stdout: pypgatk_ensembl-downloader.out

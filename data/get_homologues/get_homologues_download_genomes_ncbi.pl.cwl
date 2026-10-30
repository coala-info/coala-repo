cwlVersion: v1.2
class: CommandLineTool
baseCommand: download_genomes_ncbi.pl
label: get_homologues_download_genomes_ncbi.pl
doc: "Attempts to download a list of genomes from the NCBI: queries e-utils, the FTP site of complete genomes and the WGS repository. Genomes are written as _<name>.gbk files in the working directory.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: genome_list
    type: File
    doc: 'file with names of genomes to be downloaded, one per row; only the first column is required (accession, GCA/GCF assembly or WGS prefix), an optional second column gives the output name'
    inputBinding:
      position: 1
outputs:
  - id: genomes
    type:
      type: array
      items: File
    doc: Downloaded GenBank files.
    outputBinding:
      glob:
        - '_*.gbk'
        - '_*.gbff'
  - id: stdout
    type: stdout
    doc: Standard output
stdout: get_homologues_download_genomes_ncbi.pl.out
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0

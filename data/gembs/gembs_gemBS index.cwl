cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemBS index
label: gembs_gemBS index
doc: "Reference indexing for Bisulfite GEM mapping Generates by default a file called
  reference.BS.gem (GEM Index), reference.BS.info (Information about the index process)
  and reference.chrom.sizes (a list of contigs and sizes). Optionally the index command
  will also take a list of bed files with SNP names and locations (such as can be
  downloaded from dbSNP) and make an indexed file that can be used during the calling
  process to add SNP names into the output VCF/BCF file. The list of input files for
  thed dbSNP index generation can include shell wildcards (*, ? etc.) PLEASE NOTE!
  If bisulfite conversion control sequences have been added to the sequencing libraries
  then their sequences should be added to the fasta reference file, and gemBS should
  be told the names of these sequences. More details about the reference files, conversion
  control sequences, GEM index and dbSNP index can be found in the gemBS documentation.\n\
  \nTool homepage: https://github.com/heathsc/gemBS"
inputs:
  - id: list_dbSNP_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of dbSNP files (can be compressed) to create an index to later use
      it at the bscall step. The bed files should have the name of the SNP in 
      column 4.
    inputBinding:
      position: 101
      prefix: --list-dbSNP-files
  - id: populate_cache
    type:
      - 'null'
      - boolean
    doc: Populate reference cache if required (for CRAM).
    inputBinding:
      position: 101
      prefix: --populate-cache
  - id: sampling_rate
    type:
      - 'null'
      - string
    doc: Text sampling rate. Increasing will decrease index size at the expense 
      of slower performance.
    inputBinding:
      position: 101
      prefix: --sampling-rate
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. By default GEM indexer will use the maximum 
      available on the system.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
stdout: gembs_gemBS index.out

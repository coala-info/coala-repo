cwlVersion: v1.2
class: CommandLineTool
baseCommand: iseq
label: iseq
doc: "Download sequencing data and matadata for each Run from [GSA, SRA, ENA or DDBJ]
  databases.\n\nTool homepage: https://github.com/BioOmics/iSeq"
inputs:
  - id: accession
    type: string
    doc: 'Single accession or a file containing multiple accessions. Note: Only one
      accession per line in the file.'
    inputBinding:
      position: 101
      prefix: --input
  - id: aspera
    type:
      - 'null'
      - boolean
    doc: Use Aspera to download sequencing data, only support GSA/ENA database.
    inputBinding:
      position: 101
      prefix: --aspera
  - id: database
    type:
      - 'null'
      - string
    doc: 'Specify the database to download SRA sequencing data. Note: new SRA files
      may not be available in the ENA database, even if you specify "ena".'
    default: ena
    inputBinding:
      position: 101
      prefix: --database
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Convert SRA files to FASTQ format.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: 'Download FASTQ files in gzip format directly (*.fastq.gz). Note: if *.fastq.gz
      files are not available, SRA files will be downloaded and converted to *.fastq.gz
      files.'
    inputBinding:
      position: 101
      prefix: --gzip
  - id: merge
    type:
      - 'null'
      - string
    doc: 'Merge multiple fastq files into one fastq file for each Experiment, Sample
      or Study. ex: merge all fastq files of the same Experiment into one fastq file.
      Accession format: ERX, DRX, SRX, CRX. sa: merge all fastq files of the same
      Sample into one fastq file. Accession format: ERS, DRS, SRS, SAMC, GSM. st:
      merge all fastq files of the same Study into one fastq file. Accession format:
      ERP, DRP, SRP, CRA.'
    inputBinding:
      position: 101
      prefix: --merge
  - id: metadata_only
    type:
      - 'null'
      - boolean
    doc: Skip the sequencing data downloads and only fetch the metadata for the 
      accession.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The output directory. If not exists, it will be created
    default: .
    inputBinding:
      position: 101
      prefix: --output
  - id: parallel
    type:
      - 'null'
      - int
    doc: 'Download sequencing data in parallel, the number of connections needs to
      be specified, such as -p 10. Note: breakpoint continuation cannot be shared
      between different numbers of connections.'
    inputBinding:
      position: 101
      prefix: --parallel
  - id: protocol
    type:
      - 'null'
      - string
    doc: Specify the protocol only when downloading files from ENA
    default: ftp
    inputBinding:
      position: 101
      prefix: --protocol
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress download progress bars.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: skip_md5
    type:
      - 'null'
      - boolean
    doc: Skip the md5 check for the downloaded files.
    inputBinding:
      position: 101
      prefix: --skip-md5
  - id: speed
    type:
      - 'null'
      - int
    doc: Download speed limit (MB/s)
    default: 1000
    inputBinding:
      position: 101
      prefix: --speed
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use for converting SRA to FASTQ files or 
      compressing FASTQ files
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iseq:1.9.8--hdfd78af_0
stdout: iseq.out

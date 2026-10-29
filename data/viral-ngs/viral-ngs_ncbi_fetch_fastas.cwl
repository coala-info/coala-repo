cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ncbi.py
  - fetch_fastas
label: viral-ngs_ncbi_fetch_fastas
doc: "This function downloads and saves the FASTA files from the Genbank CoreNucleotide database given a given list of accession IDs.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: email_address
    type: string
    doc: "Your email address. To access the Genbank CoreNucleotide database, NCBI requires you to specify your email address with each request. In case of excessive usage of the E-utilities, NCBI will attempt to contact a user at the email address provided before blocking access. This email address should be registered with NCBI. To register an email address, simply send an email to eutilities@ncbi.nlm.nih.gov including your email address and the tool name (tool='https://github.com/broadinstitute/viral-ngs')."
    inputBinding:
      position: 1
  - id: destination_dir
    type: string
    doc: "Output directory with where .fasta and .tbl files will be saved"
    inputBinding:
      position: 2
  - id: accession_ids
    type:
      type: array
      items: string
    doc: "List of Genbank nuccore accession IDs"
    inputBinding:
      position: 3
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing files, if present."
    inputBinding:
      position: 20
      prefix: --forceOverwrite
  - id: combined_file_prefix
    type:
      - 'null'
      - string
    doc: "The prefix of the file containing the combined concatenated results returned by the list of accession IDs, in the order provided."
    inputBinding:
      position: 20
      prefix: --combinedFilePrefix
  - id: file_ext
    type:
      - 'null'
      - string
    doc: "The extension to use for the downloaded files"
    inputBinding:
      position: 20
      prefix: --fileExt
  - id: remove_separate_files
    type:
      - 'null'
      - boolean
    doc: "If specified, remove the individual files and leave only the combined file."
    inputBinding:
      position: 20
      prefix: --removeSeparateFiles
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "Causes files to be downloaded from GenBank in chunks of N accessions. Each chunk will be its own combined file, separate from any combined file created via --combinedFilePrefix (default: 1). If chunkSize is unspecified and >500 accessions are provided, chunkSize will be set to 500 to adhere to the NCBI guidelines on information retreival."
    inputBinding:
      position: 20
      prefix: --chunkSize
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: destination_dir_dir
    type: Directory
    doc: "Output directory destination_dir"
    outputBinding:
      glob: $(inputs.destination_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0

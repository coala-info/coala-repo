cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - index
label: gembs_gemBS_index
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
  - id: project_dirs
    type:
      type: array
      items: Directory
    doc: Project directories made by earlier gemBS steps (.gemBS, index, mapping, calls), staged writable in the working directory
  - id: project_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Project files named in the configuration, such as the reference FASTA and the FASTQ files, staged in the working directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: gemBS_state
    type:
      - 'null'
      - Directory
    doc: The .gemBS project directory (database and JSON file), updated by this step
    outputBinding:
      glob: .gemBS
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: The index directory written by this step
    outputBinding:
      glob: index
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project_dirs)
        writable: true
      - entry: '$(inputs.project_files ? inputs.project_files : [])'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
stdout: gembs_gemBS_index.out
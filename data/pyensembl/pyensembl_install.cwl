cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyensembl
  - install
label: pyensembl_install
doc: "Download and index any genome data that is not currently downloaded or indexed in the pyensembl cache (an Ensembl release, or a genome from GTF/FASTA source files).\n\nTool homepage: https://github.com/openvax/pyensembl"
inputs:
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Existing pyensembl cache directory to add to (copied; set as PYENSEMBL_CACHE_DIR)
  - id: cache_dir_name
    type:
      - 'null'
      - string
    default: pyensembl_cache
    doc: Name of the new cache directory when no cache_dir is given
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force download and indexing even if files already exist locally
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: release
    type:
      - 'null'
      - type: array
        items: int
    doc: Ensembl release version(s) (default is the newest release)
    inputBinding:
      position: 101
      prefix: --release
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: Which species to use Ensembl data for (default=human)
    inputBinding:
      position: 101
      prefix: --species
  - id: custom_mirror
    type:
      - 'null'
      - string
    doc: URL and directory to use instead of the default Ensembl FTP server
    inputBinding:
      position: 101
      prefix: --custom-mirror
  - id: reference_name
    type:
      - 'null'
      - string
    doc: Name of the reference, e.g. GRCh38 (for a genome from source files)
    inputBinding:
      position: 101
      prefix: --reference-name
  - id: annotation_name
    type:
      - 'null'
      - string
    doc: Name of annotation source (e.g. refseq), required with source files
    inputBinding:
      position: 101
      prefix: --annotation-name
  - id: annotation_version
    type:
      - 'null'
      - string
    doc: Version of annotation database
    inputBinding:
      position: 101
      prefix: --annotation-version
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF file containing annotations
    inputBinding:
      position: 101
      prefix: --gtf
  - id: transcript_fasta
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --transcript-fasta
    doc: FASTA file(s) containing the transcript data
    inputBinding:
      position: 101
  - id: protein_fasta
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --protein-fasta
    doc: FASTA file(s) containing protein data
    inputBinding:
      position: 101
  - id: shared_prefix
    type:
      - 'null'
      - string
    doc: Add this prefix to URLs or paths specified by --gtf, --transcript-fasta, --protein-fasta
    inputBinding:
      position: 101
      prefix: --shared-prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log)
  - id: cache_directory
    type: Directory
    doc: pyensembl cache directory (PYENSEMBL_CACHE_DIR)
    outputBinding:
      glob: "$(inputs.cache_dir ? inputs.cache_dir.basename : inputs.cache_dir_name)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.cache_dir)
        writable: true
  - class: EnvVarRequirement
    envDef:
      PYENSEMBL_CACHE_DIR: "$(runtime.outdir + '/' + (inputs.cache_dir ? inputs.cache_dir.basename : inputs.cache_dir_name))"
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
stdout: pyensembl_install.out

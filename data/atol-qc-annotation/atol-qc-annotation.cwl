cwlVersion: v1.2
class: CommandLineTool
baseCommand: atol-qc-annotation
label: atol-qc-annotation
doc: "Performs quality control and annotation for genome assemblies.\n\nTool homepage:
  https://github.com/TomHarrop/atol-qc-annotation"
inputs:
  - id: annot_file
    type:
      - 'null'
      - File
    doc: Path to the genome annotation file. Any annotation format recognised by
      agat_sp_extract_sequences works.
    inputBinding:
      position: 101
      prefix: --annot
  - id: dev_container
    type:
      - 'null'
      - string
    doc: For development use. Specify a container to run all the jobs in.
    inputBinding:
      position: 101
      prefix: --dev_container
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform a dry run without executing any commands.
    inputBinding:
      position: 101
      prefix: -n
  - id: ete_ncbi_db
    type: Directory
    doc: Path to the ete3 NCBI database to be used.
    inputBinding:
      position: 101
      prefix: --ete_ncbi_db
  - id: fasta
    type: File
    doc: Path to the genome assembly FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: lineage_dataset
    type: string
    doc: Specify the name of the BUSCO lineage to be used.
    default: eukaryota_odb10
    inputBinding:
      position: 101
      prefix: --lineage_dataset
  - id: lineages_path
    type: Directory
    doc: Path to the BUSCO lineages directory.
    inputBinding:
      position: 101
      prefix: --lineages_path
  - id: logs_directory
    type:
      - 'null'
      - Directory
    doc: 'Log output directory. Default: logs are discarded.'
    inputBinding:
      position: 101
      prefix: --logs
  - id: mem_gb
    type:
      - 'null'
      - int
    doc: Intended maximum RAM in GB.
    inputBinding:
      position: 101
      prefix: --mem
  - id: omamer_db
    type: string
    doc: OMAmer database
    inputBinding:
      position: 101
      prefix: --db
  - id: taxid
    type: int
    doc: NCBI Taxonomy ID
    inputBinding:
      position: 101
      prefix: --taxid
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-qc-annotation:0.1.4--pyhdfd78af_0

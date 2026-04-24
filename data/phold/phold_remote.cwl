cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phold
  - remote
label: phold_remote
doc: "Uses Foldseek API to run ProstT5 then Foldseek locally\n\nTool homepage: https://github.com/gbouras13/phold"
inputs:
  - id: card_vfdb_evalue
    type:
      - 'null'
      - float
    doc: Stricter E-value threshold for Foldseek CARD and VFDB hits
    inputBinding:
      position: 101
      prefix: --card_vfdb_evalue
  - id: custom_db
    type:
      - 'null'
      - string
    doc: Path to custom database
    inputBinding:
      position: 101
      prefix: --custom_db
  - id: database
    type:
      - 'null'
      - string
    doc: Specific path to installed phold database
    inputBinding:
      position: 101
      prefix: --database
  - id: evalue
    type:
      - 'null'
      - float
    doc: Evalue threshold for Foldseek
    inputBinding:
      position: 101
      prefix: --evalue
  - id: extra_foldseek_params
    type:
      - 'null'
      - string
    doc: Extra foldseek search params
    inputBinding:
      position: 101
      prefix: --extra_foldseek_params
  - id: foldseek_gpu
    type:
      - 'null'
      - boolean
    doc: Use this to enable compatibility with Foldseek-GPU search acceleration
    inputBinding:
      position: 101
      prefix: --foldseek_gpu
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_path
    type: File
    doc: Path to input file in Genbank format or nucleotide FASTA format
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary intermediate files, particularly the large 
      foldseek_results.tsv of all Foldseek hits
    inputBinding:
      position: 101
      prefix: --keep_tmp_files
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter. You 
      may want to reduce this to save disk space for enormous datasets
    inputBinding:
      position: 101
      prefix: --max_seqs
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Use this to restart phold from 'Processing Foldseek output' after 
      foldseek_results.tsv is generated
    inputBinding:
      position: 101
      prefix: --restart
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: Sensitivity parameter for foldseek
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: separate
    type:
      - 'null'
      - boolean
    doc: Output separate GenBank files for each contig
    inputBinding:
      position: 101
      prefix: --separate
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: ultra_sensitive
    type:
      - 'null'
      - boolean
    doc: Runs phold with maximum sensitivity by skipping Foldseek prefilter. Not
      recommended for large datasets.
    inputBinding:
      position: 101
      prefix: --ultra_sensitive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
stdout: phold_remote.out

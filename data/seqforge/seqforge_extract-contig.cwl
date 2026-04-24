cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - extract-contig
label: seqforge_extract-contig
doc: "Extract entire contigs containing matching sequences.\n\nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: csv_path
    type: File
    doc: Path to Query results file (all_results.csv or 
      all_filtered_results.csv)
    inputBinding:
      position: 101
      prefix: --csv-path
  - id: evalue
    type:
      - 'null'
      - float
    doc: Minimum e-value threshold
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fasta_directory
    type: Directory
    doc: Path to your FASTA files used to create 'makedb' databases
    inputBinding:
      position: 101
      prefix: --fasta-directory
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep extracted temporary files for debugging (only with archive 
      submission)
    inputBinding:
      position: 101
      prefix: --keep-temp-files
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum query coverage threshold
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_perc
    type:
      - 'null'
      - float
    doc: Minimum percent identity threshold
    inputBinding:
      position: 101
      prefix: --min-perc
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Specify a temporary directory (default = /tmp/)
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of cores to dedicate
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file with extension (.fa, .fas, .fna, .fasta)
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0

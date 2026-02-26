cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - fasta-metrics
label: seqforge_fasta-metrics
doc: "Compute FASTA statistics (e.g., N50, GC content).\n\nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: fasta_directory
    type: Directory
    doc: Path to FASTA file or directory of FASTA files
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
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum contig size (in bp) to include for calculation of all reported 
      metrics
    default: 500
    inputBinding:
      position: 101
      prefix: --min-contig-size
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Specify a temporary directory
    default: /tmp/
    inputBinding:
      position: 101
      prefix: --temp-dir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Optional name for CSV summary
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0

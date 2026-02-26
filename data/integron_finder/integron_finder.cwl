cwlVersion: v1.2
class: CommandLineTool
baseCommand: integron_finder
label: integron_finder
doc: "Finds integrons in a given genome sequence.\n\nTool homepage: https://github.com/gem-pasteur/Integron_Finder"
inputs:
  - id: genome_file
    type: File
    doc: Path to the genome sequence file (FASTA format).
    inputBinding:
      position: 1
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of an integron to be reported. Defaults to 100 bp.
    default: 100
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum score for an integron to be reported. Defaults to 0.7.
    default: 0.7
    inputBinding:
      position: 102
      prefix: --min-score
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for the analysis. Defaults to 1.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save the results. Defaults to the current directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/integron-finder:v1.5.1_cv2

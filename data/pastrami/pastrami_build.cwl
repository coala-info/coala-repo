cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - build
label: pastrami_build
doc: "Build reference copying matrices and pickle files for PASTRAMI\n\nTool homepage:
  https://github.com/healthdisparities/pastrami"
inputs:
  - id: haplotypes
    type: File
    doc: File of haplotype positions
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: log_file
    type:
      - 'null'
      - File
    doc: File containing log information
    inputBinding:
      position: 101
      prefix: --log-file
  - id: per_individual
    type:
      - 'null'
      - boolean
    doc: Generate per-individual copying rather than per-population copying
    inputBinding:
      position: 101
      prefix: --per-individual
  - id: reference_prefix
    type: string
    doc: Prefix for the reference TPED/TFAM input files
    inputBinding:
      position: 101
      prefix: --reference-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print program progress information on screen
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: reference_pickle_out
    type:
      - 'null'
      - File
    doc: The reference pickle file output
    outputBinding:
      glob: $(inputs.reference_pickle_out)
  - id: reference_out
    type:
      - 'null'
      - File
    doc: The reference copying matrix output
    outputBinding:
      glob: $(inputs.reference_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - align
label: yasma_align
doc: "Aligner based on shortstack3-style weighting\n\nTool homepage: https://github.com/NateyJay/YASMA"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use for alignment with bowtie.
    inputBinding:
      position: 101
      prefix: --cores
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Genome or assembly which was used for the original alignment.
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maxiumum allowed size for a trimmed read. (default 50). This should 
      only come into effect for pre-trimmed libraries.
    default: 50
    inputBinding:
      position: 101
      prefix: --max_length
  - id: max_multi
    type:
      - 'null'
      - int
    doc: The maximum number of possible mapping sites for a valid read.
    inputBinding:
      position: 101
      prefix: --max_multi
  - id: max_random
    type:
      - 'null'
      - int
    doc: Reads with no weighting will be unmapped if they exceed this number.
    inputBinding:
      position: 101
      prefix: --max_random
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum allowed size for a trimmed read. (default 10). This should only
      come into effect for pre-trimmed libraries.
    default: 10
    inputBinding:
      position: 101
      prefix: --min_length
  - id: offrate
    type:
      - 'null'
      - int
    doc: Offrate governs the tradeoff betwee disk + memory impact and speed with
      bowtie. Lower is faster, but with higher system requirements. Bowtie sets 
      this to 5 by defaut, but yasma chooses 3, assuming higher memory 
      availability.
    inputBinding:
      position: 101
      prefix: --offrate
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory name for annotation output. Defaults to the current 
      directory, with this directory name as the project name.
    default: current directory, with this directory name as the project name
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: override
    type:
      - 'null'
      - boolean
    doc: Overrides config file changes without prompting.
    inputBinding:
      position: 101
      prefix: --override
  - id: trimmed_libraries
    type:
      - 'null'
      - File
    doc: Path to trimmed libraries. Accepts wildcards (*).
    inputBinding:
      position: 101
      prefix: --trimmed_libraries
  - id: unique_locality
    type:
      - 'null'
      - int
    doc: Window size in nucleotides for unique weighting.
    inputBinding:
      position: 101
      prefix: --unique_locality
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_align.out

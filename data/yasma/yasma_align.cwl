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
    type: Directory
    doc: Directory name for annotation output. Defaults to the current 
      directory, with this directory name as the project name.
    inputBinding:
      position: 101
      prefix: --output_directory
      valueFrom: $(self.basename)
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
      - type: array
        items: File
        inputBinding:
          prefix: --trimmed_libraries
    doc: Path to trimmed libraries. Accepts wildcards (*).
    inputBinding:
      position: 101
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
  - id: project_directory
    type: Directory
    doc: Project directory with the files this step wrote
    outputBinding:
      glob: $(inputs.output_directory.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{entry: inputs.output_directory, writable: true}];
        if (inputs.genome_file) { l.push({entry: inputs.genome_file, writable: true}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_align.out

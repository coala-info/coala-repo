cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - inStrain
  - genome_wide
label: instrain_genome_wide
doc: "Add genome-wide tables to an existing inStrain profile\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: IS
    type: Directory
    doc: An inStrain profile object (genome-wide results are written into it)
    inputBinding:
      position: 101
      prefix: --IS
  - id: stb
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Scaffold to bin. A file with each line listing a scaffold and a bin name, tab-separated, or a list of .fasta files with one genome per .fasta file. If nothing is provided, all scaffolds are treated as belonging to the same genome'
    inputBinding:
      position: 101
      prefix: --stb
  - id: store_everything
    type:
      - 'null'
      - boolean
    doc: 'Store gene sequences in the IS object (default: False)'
    inputBinding:
      position: 101
      prefix: --store_everything
  - id: mm_level
    type:
      - 'null'
      - boolean
    doc: 'Create output files on the mm level (default: False)'
    inputBinding:
      position: 101
      prefix: --mm_level
  - id: skip_mm_profiling
    type:
      - 'null'
      - boolean
    doc: 'Dont perform analysis on an mm level; saves RAM and time; impacts plots and raw_data (default: False)'
    inputBinding:
      position: 101
      prefix: --skip_mm_profiling
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (default: 6)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Make extra debugging output (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: profile_dir
    type: Directory
    doc: The inStrain object with the genome-wide results added
    outputBinding:
      glob: $(inputs.IS.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.IS)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0

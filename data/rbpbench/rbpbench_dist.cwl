cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench dist
label: rbpbench_dist
doc: "Distribution plot results output folder\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: cp_mode
    type:
      - 'null'
      - int
    doc: 'Define which position of --in genomic sites to use as zero position for
      plotting. 1: upstream end position, 2: center position, 3: downstream end position'
    default: 1
    inputBinding:
      position: 101
      prefix: --cp-mode
  - id: ext
    type:
      - 'null'
      - int
    doc: Up- and downstream extension of defined genomic positions (define via 
      --cp-mode) in nucleotides (nt). Set e.g. --ext 20 for 20 nt on both sides
    default: 10
    inputBinding:
      position: 101
      prefix: --ext
  - id: genome
    type: File
    doc: 'Genomic sequences file (currently supported formats: FASTA)'
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_file
    type: File
    doc: Genomic RBP binding sites (peak regions) file in BED format (can be 
      single positions or extended regions). Use --cp-mode to define zero 
      position for plotting
    inputBinding:
      position: 101
      prefix: --in
  - id: no_uniq_check
    type:
      - 'null'
      - boolean
    doc: Disable checking for unique input regions and positions (defined by 
      --cp-mode). By default, duplicate input regions are removed, and 
      encountering identical genomic positions (defined by --cp-mode) for 
      plotting results in an assert error
    default: false
    inputBinding:
      position: 101
      prefix: --no-uniq-check
  - id: plot_pdf
    type:
      - 'null'
      - boolean
    doc: 'Plot .pdf (default: .png)'
    inputBinding:
      position: 101
      prefix: --plot-pdf
outputs:
  - id: output_folder
    type: Directory
    doc: Distribution plot results output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0

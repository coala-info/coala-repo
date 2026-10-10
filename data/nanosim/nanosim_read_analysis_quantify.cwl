cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_analysis.py, quantify]
label: nanosim_read_analysis_quantify
doc: "Quantify transcriptome expression or metagenome abundance from ONT reads.\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs:
  - id: mode_e
    type: string
    doc: "Select from (trans, meta)."
    inputBinding:
      position: 1
      prefix: -e
  - id: read
    type: File
    doc: "Input reads for quantification."
    inputBinding:
      position: 1
      prefix: --read
  - id: ref_t
    type:
      - 'null'
      - File
    doc: "Reference transcriptome."
    inputBinding:
      position: 1
      prefix: --ref_t
  - id: genome_list
    type:
      - 'null'
      - File
    doc: "Reference metagenome list, tsv file: species/strain name, reference genome path, and optional expected abundance (sum up to 100)."
    inputBinding:
      position: 1
      prefix: --genome_list
  - id: g_alnm
    type:
      - 'null'
      - File
    doc: "Genome alignment file in sam format, the header of each species should match the metagenome list (optional)."
    inputBinding:
      position: 1
      prefix: --g_alnm
  - id: t_alnm
    type:
      - 'null'
      - File
    doc: "Transcriptome alignment file in sam format (optional)."
    inputBinding:
      position: 1
      prefix: --t_alnm
  - id: output
    type:
      - 'null'
      - string
    doc: "The location and prefix of output profiles (Default = expression)."
    inputBinding:
      position: 1
      prefix: --output
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Genome FASTA files named in the genome list; staged in the working directory so the names resolve."
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads for alignment (Default = 1)."
    inputBinding:
      position: 1
      prefix: --num_threads
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: "Normalize by transcript length."
    inputBinding:
      position: 1
      prefix: --normalize
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Abundance table written with the output prefix.
    outputBinding:
      glob: "$((inputs.output ? inputs.output : 'expression') + '*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.genome_files ? inputs.genome_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0

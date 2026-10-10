cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_analysis.py, transcriptome]
label: nanosim_read_analysis_transcriptome
doc: "Read characterization step in transcriptome mode: given raw ONT reads, a reference genome and a reference transcriptome, learn read features and output error profiles.\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs:
  - id: read
    type: File
    doc: "Input read for training."
    inputBinding:
      position: 1
      prefix: --read
  - id: ref_g
    type: File
    doc: "Reference genome."
    inputBinding:
      position: 1
      prefix: --ref_g
  - id: ref_t
    type: File
    doc: "Reference transcriptome."
    inputBinding:
      position: 1
      prefix: --ref_t
  - id: annotation
    type:
      - 'null'
      - File
    doc: "Annotation file in ensemble GTF/GFF formats, required for intron retention detection."
    inputBinding:
      position: 1
      prefix: --annotation
  - id: aligner
    type:
      - 'null'
      - string
    doc: "The aligner to be used, minimap2 or LAST (Default = minimap2)."
    inputBinding:
      position: 1
      prefix: --aligner
  - id: g_alnm
    type:
      - 'null'
      - File
    doc: "Genome alignment file in SAM/BAM format (optional)."
    inputBinding:
      position: 1
      prefix: --g_alnm
  - id: t_alnm
    type:
      - 'null'
      - File
    doc: "Transcriptome alignment file in SAM/BAM format (optional)."
    inputBinding:
      position: 1
      prefix: --t_alnm
  - id: output
    type:
      - 'null'
      - string
    doc: "The location and prefix of output profiles (Default = training)."
    inputBinding:
      position: 1
      prefix: --output
  - id: no_model_fit
    type:
      - 'null'
      - boolean
    doc: "Disable model fitting step."
    inputBinding:
      position: 1
      prefix: --no_model_fit
  - id: no_intron_retention
    type:
      - 'null'
      - boolean
    doc: "Disable Intron Retention analysis."
    inputBinding:
      position: 1
      prefix: --no_intron_retention
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Default = 1)."
    inputBinding:
      position: 1
      prefix: --num_threads
  - id: quantification
    type:
      - 'null'
      - boolean
    doc: "Perform abundance quantification (Default = False)."
    inputBinding:
      position: 1
      prefix: --quantification
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: "Normalize by transcript length."
    inputBinding:
      position: 1
      prefix: --normalize
  - id: homopolymer
    type:
      - 'null'
      - boolean
    doc: "Analyze homopolymer lengths (Default = False)."
    inputBinding:
      position: 1
      prefix: --homopolymer
  - id: min_homopolymer_len
    type:
      - 'null'
      - int
    doc: "Minimum length of homopolymers to analyze (Default = 5 bp)."
    inputBinding:
      position: 1
      prefix: --min_homopolymer_len
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Analyze base qualities (Default = False)."
    inputBinding:
      position: 1
      prefix: --fastq
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Error profile files written with the output prefix.
    outputBinding:
      glob: "$((inputs.output ? inputs.output : 'training') + '*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0

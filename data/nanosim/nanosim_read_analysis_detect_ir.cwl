cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_analysis.py, detect_ir]
label: nanosim_read_analysis_detect_ir
doc: "Detect intron retention events using the alignment file.\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs:
  - id: annotation
    type: File
    doc: "Annotation file in ensemble GTF/GFF formats."
    inputBinding:
      position: 1
      prefix: --annotation
  - id: read
    type:
      - 'null'
      - File
    doc: "Input read for training, not required if alignment files are provided."
    inputBinding:
      position: 1
      prefix: --read
  - id: ref_g
    type:
      - 'null'
      - File
    doc: "Reference genome, not required if genome alignment file is provided."
    inputBinding:
      position: 1
      prefix: --ref_g
  - id: ref_t
    type:
      - 'null'
      - File
    doc: "Reference transcriptome, not required if transcriptome alignment file is provided."
    inputBinding:
      position: 1
      prefix: --ref_t
  - id: aligner
    type:
      - 'null'
      - string
    doc: "The aligner to be used, minimap2 or LAST (Default = minimap2)."
    inputBinding:
      position: 1
      prefix: --aligner
  - id: output
    type:
      - 'null'
      - string
    doc: "The output name and location."
    inputBinding:
      position: 1
      prefix: --output
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
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads for alignment (Default = 1)."
    inputBinding:
      position: 1
      prefix: --num_threads
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Intron retention detection output written with the output prefix.
    outputBinding:
      glob: "$((inputs.output ? inputs.output : 'ir_detection') + '*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0

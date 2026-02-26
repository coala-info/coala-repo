cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuna detect
label: cuna_detect
doc: "Detect modifications using a trained model.\n\nTool homepage: https://github.com/iris1901/CUNA"
inputs:
  - id: bam
    type: File
    doc: Path to aligned BAM file from Dorado basecalling.
    inputBinding:
      position: 101
      prefix: --bam
  - id: bam_threads
    type:
      - 'null'
      - int
    doc: Number of threads for BAM output compression.
    default: 4
    inputBinding:
      position: 101
      prefix: --bam_threads
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size to use for GPU inference.
    default: 1024
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: device
    type:
      - 'null'
      - string
    doc: 'Device to use for model inference: "cpu", "cuda", "cuda:0", "mps", etc.'
    inputBinding:
      position: 101
      prefix: --device
  - id: disable_pruning
    type:
      - 'null'
      - boolean
    doc: Disable model pruning (may slow down CPU inference).
    default: false
    inputBinding:
      position: 101
      prefix: --disable_pruning
  - id: input
    type: File
    doc: Path to POD5 file or folder containing POD5 files.
    inputBinding:
      position: 101
      prefix: --input
  - id: length_cutoff
    type:
      - 'null'
      - int
    doc: Minimum cutoff for read length
    default: 0
    inputBinding:
      position: 101
      prefix: --length_cutoff
  - id: mod_symbol
    type:
      - 'null'
      - string
    doc: Symbol to use for modified base in BAM tag MM (e.g. "u" for uracil).
    inputBinding:
      position: 101
      prefix: --mod_symbol
  - id: mod_t
    type:
      - 'null'
      - float
    doc: Probability threshold for a per-read prediction to be considered 
      modified.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --mod_t
  - id: model
    type: string
    doc: Name of the model to use. For custom models, provide 
      "config.cfg,model.pt".
    inputBinding:
      position: 101
      prefix: --model
  - id: motif
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Motif to detect. Format: "<MOTIF> <INDEX>". Example: "T 0" to detect modifications
      on T.'
    inputBinding:
      position: 101
      prefix: --motif
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to folder where intermediate and final files will be stored
    default: current working directory
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files
    default: output
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qscore_cutoff
    type:
      - 'null'
      - float
    doc: Minimum cutoff for mean quality score of a read
    default: 0
    inputBinding:
      position: 101
      prefix: --qscore_cutoff
  - id: skip_per_site
    type:
      - 'null'
      - boolean
    doc: Skip per-site output generation.
    default: false
    inputBinding:
      position: 101
      prefix: --skip_per_site
  - id: skip_unmapped
    type:
      - 'null'
      - boolean
    doc: Skip unmapped reads from modification calling.
    default: false
    inputBinding:
      position: 101
      prefix: --skip_unmapped
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for processing signal and running model inference.
      Recommended: at least 4.'
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: unmod_t
    type:
      - 'null'
      - float
    doc: Probability threshold for a per-read prediction to be considered 
      unmodified.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --unmod_t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
stdout: cuna_detect.out

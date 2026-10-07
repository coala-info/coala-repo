cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cuna
  - detect
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
    inputBinding:
      position: 101
      prefix: --bam_threads
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size to use for GPU inference.
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
    inputBinding:
      position: 101
      prefix: --disable_pruning
  - id: input
    type:
      - File
      - Directory
    doc: Path to POD5 file or folder containing POD5 files.
    inputBinding:
      position: 101
      prefix: --input
  - id: length_cutoff
    type:
      - 'null'
      - int
    doc: Minimum cutoff for read length
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
    inputBinding:
      position: 101
      prefix: --mod_t
  - id: model
    type:
      - 'null'
      - string
    doc: Name of the model to use. For custom models, give model_config and 
      model_checkpoint instead.
  - id: model_config
    type:
      - 'null'
      - File
    doc: Custom model configuration file (model.cfg); passed as 
      "config.cfg,model.pt" to --model together with model_checkpoint.
  - id: model_checkpoint
    type:
      - 'null'
      - File
    doc: Custom model checkpoint file (model.pt); used with model_config.
  - id: motif
    type:
      type: array
      items: string
    doc: 'Motif to detect. Format: "<MOTIF> <INDEX>". Example: "T 0" to detect modifications
      on T.'
    inputBinding:
      position: 101
      prefix: --motif
  - id: output
    type: string
    doc: Path to folder where intermediate and final files will be stored
    default: cuna_detect_output
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qscore_cutoff
    type:
      - 'null'
      - float
    doc: Minimum cutoff for mean quality score of a read
    inputBinding:
      position: 101
      prefix: --qscore_cutoff
  - id: skip_per_site
    type:
      - 'null'
      - boolean
    doc: Skip per-site output generation.
    inputBinding:
      position: 101
      prefix: --skip_per_site
  - id: skip_unmapped
    type:
      - 'null'
      - boolean
    doc: Skip unmapped reads from modification calling.
    inputBinding:
      position: 101
      prefix: --skip_unmapped
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for processing signal and running model inference.
      Recommended: at least 4.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: unmod_t
    type:
      - 'null'
      - float
    doc: Probability threshold for a per-read prediction to be considered 
      unmodified.
    inputBinding:
      position: 101
      prefix: --unmod_t
arguments:
  - position: 101
    prefix: --model
    valueFrom: |-
      ${
        if (inputs.model_config && inputs.model_checkpoint)
          return inputs.model_config.path + "," + inputs.model_checkpoint.path;
        return inputs.model;
      }
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Output folder with the <prefix>.per_read, <prefix>.per_site, 
      <prefix>.bam and args files
    outputBinding:
      glob: $(inputs.output)
  - id: per_read
    type:
      - 'null'
      - File
    doc: Per-read modification predictions
    outputBinding:
      glob: $(inputs.output)/$(inputs.prefix || 'output').per_read
  - id: per_site
    type:
      - 'null'
      - File
    doc: Per-site modification predictions
    outputBinding:
      glob: $(inputs.output)/$(inputs.prefix || 'output').per_site
  - id: mod_bam
    type:
      - 'null'
      - File
    doc: BAM file annotated with modification tags
    outputBinding:
      glob: $(inputs.output)/$(inputs.prefix || 'output').bam
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
stdout: cuna_detect.out

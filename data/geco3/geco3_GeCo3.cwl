cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./GeCo3
label: geco3_GeCo3
doc: "efficient compression and analysis of genomic sequences.\n\nTool homepage: https://github.com/cobilab/geco3"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'Input sequence filename (to compress) -- MANDATORY. File(s) to compress
      (last argument). For more files use splitting ":" characters. Example: file1.txt:file2.txt:file3.txt.'
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level (integer [1;16]). It defines compressibility in 
      balance with computational resources (RAM & time). Use -s for levels 
      perception.
    default: 5
    inputBinding:
      position: 102
      prefix: --level
  - id: estimate_information_content
    type:
      - 'null'
      - boolean
    doc: it creates a file with the extension ".iae" with the respective 
      information content. If the file is FASTA or FASTQ it will only use the 
      "ACGT" (genomic) sequence.
    inputBinding:
      position: 102
      prefix: --estimate
  - id: force_mode
    type:
      - 'null'
      - boolean
    doc: force mode. Overwrites old files.
    inputBinding:
      position: 102
      prefix: --force
  - id: hidden_layer_size
    type:
      - 'null'
      - int
    doc: Hidden layer size (integer). It defines number of hidden nodes for the 
      neural network.
    default: 40
    inputBinding:
      position: 102
      prefix: --hidden-size
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: Learning rate (real). It defines learning rate the neural network uses.
    default: 0.03
    inputBinding:
      position: 102
      prefix: --learning-rate
  - id: reference_context_model
    type:
      - 'null'
      - string
    doc: 'Template of a reference context model. Use only when -r [FILE] is set (referential
      compression). Parameters: the same as in -tm.'
    inputBinding:
      position: 102
      prefix: -rm
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: 'Reference sequence filename ("-rm" are trainned here). Example: -r file1.txt.'
    inputBinding:
      position: 102
      prefix: --reference
  - id: show_examples
    type:
      - 'null'
      - boolean
    doc: show several running examples (parameter examples).
    inputBinding:
      position: 102
      prefix: --examples
  - id: show_levels
    type:
      - 'null'
      - boolean
    doc: show pre-computed compression levels (configured parameters).
    inputBinding:
      position: 102
      prefix: --show-levels
  - id: target_context_model
    type:
      - 'null'
      - string
    doc: 'Template of a target context model. Parameters: [NB_C]: (integer [1;20])
      order size of the regular context model. Higher values use more RAM but, usually,
      are related to a better compression score. [NB_D]: (integer [1;5000]) denominator
      to build alpha, which is a parameter estimator. Alpha is given by 1/[NB_D].
      Higher values are usually used with higher [NB_C], and related to confiant bets.
      When [NB_D] is one, the probabilities assume a Laplacian distribution. [NB_I]:
      (integer {0,1,2}) number to define if a sub-program which addresses the specific
      properties of DNA sequences (Inverted repeats) is used or not. The number 2
      turns ON this sub-program without the regular context model (only inverted repeats).
      The number 1 turns ON the sub-program using at the same time the regular context
      model. The number 0 does not contemple its use (Inverted repeats OFF). The use
      of this sub-program increases the necessary time to compress but it does not
      affect the RAM. [NB_H]: (integer [1;254]) size of the cache-hash for deeper
      context models, namely for [NB_C] > 14. When the [NB_C] <= 14 use, for example,
      1 as a default. The RAM is highly dependent of this value (higher value stand
      for higher RAM). [NB_G]: (real [0;1)) real number to define gamma. This value
      represents the decayment forgetting factor of the regular context model in definition.
      [NB_S]: (integer [0;20]) maximum number of editions allowed to use a substitutional
      tolerant model with the same memory model of the regular context model with
      order size equal to [NB_C]. The value 0 stands for turning the tolerant context
      model off. When the model is on, it pauses when the number of editions is higher
      that [NB_C], while it is turned on when a complete match of size [NB_C] is seen
      again. This is probabilistic-algorithmic model very usefull to handle the high
      substitutional nature of genomic sequences. When [NB_S] > 0, the compressor
      used more processing time, but uses the same RAM and, usually, achieves a substantial
      higher compression ratio. The impact of this model is usually only noticed for
      [NB_C] >= 14. [NB_E]: (integer [1;5000]) denominator to build alpha for substitutional
      tolerant context model. It is analogous to [NB_D], however to be only used in
      the probabilistic model for computing the statistics of the substitutional tolerant
      context model. [NB_A]: (real [0;1)) real number to define gamma. This value
      represents the decayment forgetting factor of the substitutional tolerant context
      model in definition. Its definition and use is analogus to [NB_G].'
    inputBinding:
      position: 102
      prefix: -tm
  - id: verbose_mode
    type:
      - 'null'
      - boolean
    doc: verbose mode (more information).
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geco3:1.0--h7b50bb2_5
stdout: geco3_GeCo3.out

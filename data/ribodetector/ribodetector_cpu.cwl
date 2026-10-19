cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribodetector_cpu
label: ribodetector_cpu
doc: "rRNA sequence detector\n\nTool homepage: https://github.com/hzi-bifo/RiboDetector"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "chunk_size * 1024 reads to load each time. When chunk_size=1000 and threads=20, consumming ~20G memory, better to be multiples of the number of threads."
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: config
    type:
      - 'null'
      - string
    doc: Path of config file
    inputBinding:
      position: 101
      prefix: --config
  - id: ensure
    type:
      - 'null'
      - string
    doc: "Ensure which classificaion has high confidence for paired end reads.\nnorma:
      output only high confident non-rRNAs, the rest are clasified as rRNAs;\nrna:
      vice versa, only high confident rRNAs are classified as rRNA and the rest output
      as non-rRNAs;\nboth: both non-rRNA and rRNA prediction with high confidence;\n\
      none: give label based on the mean probability of read pair.\n(Only applicable
      for paired end reads, discard the read pair when their predicitons are discordant)"
    inputBinding:
      position: 101
      prefix: --ensure
  - id: input
    type:
      type: array
      items: File
    doc: Path of input sequence files (fasta and fastq), the second file will be
      considered as second end if two files given.
    inputBinding:
      position: 101
      prefix: --input
  - id: len
    type: int
    doc: 'Sequencing read length. Note: the accuracy reduces for reads shorter than
      40.'
    inputBinding:
      position: 101
      prefix: --len
  - id: log
    type:
      - 'null'
      - string
    doc: Log file name
    inputBinding:
      position: 101
      prefix: --log
  - id: model_file
    type:
      - 'null'
      - string
    doc: 'Model file path without extension (uses .onnx). Default: packaged model_len70_101.'
    inputBinding:
      position: 101
      prefix: --model-file
  - id: rrna
    type:
      - 'null'
      - type: array
        items: string
    doc: Path of the output sequence file of detected rRNAs (same number of 
      files as input)
    inputBinding:
      position: 101
      prefix: --rrna
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed.
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type:
      type: array
      items: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      type: array
      items: File
    doc: 'Path of the output sequence files after rRNAs removal (same number of files
      as input). (Note: 2 times slower to write gz files)'
    outputBinding:
      glob: $(inputs.output_path)
  - id: rrna_output
    type:
      - 'null'
      - type: array
        items: File
    doc: Detected rRNA sequences (written with --rrna)
    outputBinding:
      glob: $(inputs.rrna)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribodetector:0.3.3--pyhdfd78af_0

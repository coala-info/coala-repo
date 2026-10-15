cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polyQtlseq
  - qc
label: poly-qtlseq_polyQtlseq_qc
doc: "Quality Control by fastp.\n\nTool homepage: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_dir
    type: Directory
    doc: Raw fastq directory. Fastq file extension should be fq.gz or fastq.gz; single-end
      files are not supported.
    inputBinding:
      position: 101
      prefix: --inputDir
  - id: output_dir
    type: string
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outputDir
  - id: length_required
    type:
      - 'null'
      - int
    doc: 'Minimum read length after trimming. length_required in fastp. Default value is: 50.'
    inputBinding:
      position: 101
      prefix: --lengthRequired
  - id: n_base_limit
    type:
      - 'null'
      - int
    doc: 'Maximum number of N bases. n_base_limit in fastp. Default value is: 5.'
    inputBinding:
      position: 101
      prefix: --nBaseLimit
  - id: quality
    type:
      - 'null'
      - int
    doc: 'Threshold for base quality. qualified_quality_phred in fastp. Default value
      is: 15.'
    inputBinding:
      position: 101
      prefix: --quality
  - id: cut_tail_mean_quality
    type:
      - 'null'
      - int
    doc: "Threshold of average quality for trimming at 3' end. cut_tail_mean_quality
      in fastp. Default value is: 20."
    inputBinding:
      position: 101
      prefix: --cutTailMeanQuality
  - id: cut_tail_window_size
    type:
      - 'null'
      - int
    doc: "Window size when trimmed at 3' end. cut_tail_window_size in fastp. Default
      value is: 1."
    inputBinding:
      position: 101
      prefix: --cutTailWindowSize
  - id: thread
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. Up to 16. Default value is: 10.'
    inputBinding:
      position: 101
      prefix: --thread
  - id: params_file
    type:
      - 'null'
      - File
    doc: Parameter file.
    inputBinding:
      position: 101
      prefix: --paramsFile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Directory with the quality-controlled fastq files and fastp reports
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
stdout: poly-qtlseq_polyQtlseq_qc.out

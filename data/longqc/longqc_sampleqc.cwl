cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - /usr/local/bin/longQC.py
  - sampleqc
label: longqc_sampleqc
doc: "LongQC sampleqc - quality control of long reads (fasta, fastq or pbbam) by sampling a subset of the reads. The longQC.py script in the image has no shebang line, so it is run through python.\n\nTool homepage: https://github.com/yfukasawa/LongQC"
inputs:
  - id: input
    type: File
    doc: Input [fasta, fastq or pbbam]
    inputBinding:
      position: 100
  - id: output_dir
    type: string
    doc: path for output directory
    inputBinding:
      position: 1
      prefix: --output
  - id: preset
    type: string
    doc: a platform/kit to be evaluated. adapter and some ovlp parameters are 
      automatically applied. (pb-rs2, pb-sequel, pb-hifi, ont-ligation, 
      ont-rapid, ont-1dsq)
    inputBinding:
      position: 1
      prefix: --preset
  - id: transcript
    type:
      - 'null'
      - boolean
    doc: applies the preset for transcripts, RNA or cDNA sequences
    inputBinding:
      position: 1
      prefix: --transcript
  - id: n_sample
    type:
      - 'null'
      - int
    doc: the number of sequences for sampling. (>0 and <=10000) [Default is 
      5000].
    inputBinding:
      position: 1
      prefix: --n_sample
  - id: sample_name
    type:
      - 'null'
      - string
    doc: sample name is added as a suffix for each output file.
    inputBinding:
      position: 1
      prefix: --sample_name
  - id: trim_output
    type:
      - 'null'
      - string
    doc: path for trimmed reads. If this is not given, trimmed reads won't be 
      saved.
    inputBinding:
      position: 1
      prefix: --trim_output
  - id: adapter_5
    type:
      - 'null'
      - string
    doc: adapter sequence for 5'.
    inputBinding:
      position: 1
      prefix: --adapter_5
  - id: adapter_3
    type:
      - 'null'
      - string
    doc: adapter sequence for 3'.
    inputBinding:
      position: 1
      prefix: --adapter_3
  - id: fast
    type:
      - 'null'
      - boolean
    doc: this turns off sensitive setting. Faster but less accurate.
    inputBinding:
      position: 1
      prefix: --fast
  - id: ncpu
    type:
      - 'null'
      - int
    doc: the number of cpus for LongQC analysis [Default is 4. >=4 is 
      required.]
    inputBinding:
      position: 1
      prefix: --ncpu
  - id: db
    type:
      - 'null'
      - boolean
    doc: make minimap2 db in parallel to other tasks.
    inputBinding:
      position: 1
      prefix: --db
  - id: mem
    type:
      - 'null'
      - float
    doc: memory limit for chunking. Please specify in gigabytes (>0 and <=2). 
      [Default is 0.5]
    inputBinding:
      position: 1
      prefix: --mem
  - id: index
    type:
      - 'null'
      - string
    doc: Give index size for minimap2 (-I) in bp. Reduce when running on a 
      small memory machine. Default is 4G.
    inputBinding:
      position: 1
      prefix: --index
  - id: short
    type:
      - 'null'
      - boolean
    doc: this turns on the highly sensitive setting for very short and erroneous 
      reads (<500bp).
    inputBinding:
      position: 1
      prefix: --short
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: Output directory with the QC report and plots.
    outputBinding:
      glob: $(inputs.output_dir)
  - id: trimmed_reads
    type:
      - 'null'
      - File
    doc: Trimmed reads, written when trim_output is given.
    outputBinding:
      glob: $(inputs.trim_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longqc:1.2.0c--hdfd78af_0
stdout: longqc_sampleqc.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - calc_features
label: metafx_calc_features
doc: "count values for new samples based on previously extracted features\n\nTool homepage: https://github.com/ctlab/metafx"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reads)
inputs:
  - id: k
    type: int
    doc: "k-mer size (in nucleotides, maximum value is 31)"
    inputBinding:
      position: 101
      prefix: --k
  - id: reads
    type: File[]
    doc: "list of reads files from single environment. FASTQ, FASTA, gzip- or bzip2-compressed. The files are staged together in the working directory (mates of a pair must sit in one folder to be detected)."
    inputBinding:
      position: 101
      prefix: --reads
      valueFrom: |-
        ${ return self.map(function(f){ return f.basename; }); }
  - id: feature_dir
    type: Directory
    doc: "directory containing folders with components.bin file for each category and categories_samples.tsv file. Usually, it is workDir from other MetaFX modules (unique, stats, colored, metafast, metaspades)"
    inputBinding:
      position: 101
      prefix: --feature-dir
  - id: bad_frequency
    type: ['null', int]
    doc: "maximal frequency for a k-mer to be assumed erroneous"
    inputBinding:
      position: 101
      prefix: --bad-frequency
  - id: kmers_dir
    type: ['null', Directory]
    doc: "directory with pre-computed k-mers for samples in binary format"
    inputBinding:
      position: 101
      prefix: --kmers-dir
  - id: threads
    type: ['null', int]
    doc: "number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: memory
    type: ['null', string]
    doc: "memory to use (values with suffix: 1500M, 4G, etc.)"
    inputBinding:
      position: 101
      prefix: --memory
  - id: work_dir
    type: string
    doc: "working directory (created by the tool, it must not exist before the run)"
    default: workDir
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: results_dir
    type: Directory
    doc: "Working directory with the results"
    outputBinding:
      glob: $(inputs.work_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx_calc_features.out

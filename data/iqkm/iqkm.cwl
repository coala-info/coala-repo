cwlVersion: v1.2
class: CommandLineTool
baseCommand: iqkm
label: iqkm
doc: "Workflow for KM assignment and/or quantification, on both contig and sample
  basis\n\nTool homepage: https://github.com/lijingdi/iqKM"
inputs:
  - id: apply_distance_threshold
    type:
      - 'null'
      - boolean
    doc: Apply KM minimum distance threshold (default = True)
    inputBinding:
      position: 101
      prefix: --dist
  - id: completeness_threshold
    type:
      - 'null'
      - float
    doc: KM completeness threshold on contig basis (only KM with completeness 
      above the threshold will be considered present), default = 66.67
    inputBinding:
      position: 101
      prefix: --com
  - id: fastq1
    type:
      - 'null'
      - File
    doc: Input first or only read file (fastq or fastq.gz), required when 
      '--quantify' is specified
    inputBinding:
      position: 101
      prefix: --fq
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Input reverse read (fastq or fastq.gz format), optional
    inputBinding:
      position: 101
      prefix: --rq
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force reruning the whole pipeline, don't resume previous run (default =
      False)
    inputBinding:
      position: 101
      prefix: --force
  - id: genome_equivalent
    type:
      - 'null'
      - string
    doc: 'Genome equivalent output generated from microbe-census, can be used for
      library-size normalization when doing quantification. Optional (default: None)'
    inputBinding:
      position: 101
      prefix: --genome_equivalent
  - id: help_dir
    type: Directory
    doc: Folder containing Kofam HMM database and help files, refer to README.md
      for downloading
    inputBinding:
      position: 101
      prefix: --help_dir
  - id: hmmdb
    type:
      - 'null'
      - File
    doc: Kofam HMM database for KO assignment, default 
      path='/help_dir/db/kofam.hmm', you can change it to your customised db
    inputBinding:
      position: 101
      prefix: --db
  - id: include_weights
    type:
      - 'null'
      - boolean
    doc: Include weights of each KO when doing KM assignment (default = True)
    inputBinding:
      position: 101
      prefix: --include_weights
  - id: input_genome
    type: File
    doc: Input genome/metagenomes, required
    inputBinding:
      position: 101
      prefix: --input
  - id: metagenome_mode
    type:
      - 'null'
      - boolean
    doc: Running in metagenome mode (prodigal -p meta; default = False)
    inputBinding:
      position: 101
      prefix: --meta
  - id: out_dir
    type: Directory
    doc: Output folder
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix of output files, default: your input genome/metagenome file name
      without postfix'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: quantify
    type:
      - 'null'
      - boolean
    doc: Run both KM assignment and quantification (default = False, add '-q' or
      '--quantify' to enable)
    inputBinding:
      position: 101
      prefix: --quantify
  - id: skip
    type:
      - 'null'
      - boolean
    doc: Force skip steps if relevant output files have been found under 
      designated directories, not recommanded if your input file is newer 
      (default = False)
    inputBinding:
      position: 101
      prefix: --skip
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used for computation (default = 1)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iqkm:1.0--pyhdfd78af_0
stdout: iqkm.out

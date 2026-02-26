cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctseq analyze
label: ctseq_analyze
doc: "Analyze sequencing data from ctseq.\n\nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: bismark_cores
    type:
      - 'null'
      - int
    doc: number of cores to use to align with Bismark. Default=1. Highly 
      recommended to run with more than 1 core, try starting with 6 cores
    default: 1
    inputBinding:
      position: 101
      prefix: --bismarkCores
  - id: cis_cg
    type:
      - 'null'
      - float
    doc: cis-CG threshold to determine if a molecule is methylated 
      (default=0.75)
    default: 0.75
    inputBinding:
      position: 101
      prefix: --cisCG
  - id: consensus
    type:
      - 'null'
      - float
    doc: consensus threshold to make consensus methylation call from all the 
      reads with the same UMI (default=0.9)
    default: 0.9
    inputBinding:
      position: 101
      prefix: --consensus
  - id: cutadapt_cores
    type:
      - 'null'
      - int
    doc: number of cores to use with Cutadapt. Default=1. Highly recommended to 
      run with more than 1 core, try starting with 18 cores
    default: 1
    inputBinding:
      position: 101
      prefix: --cutadaptCores
  - id: forward_adapter
    type:
      - 'null'
      - string
    doc: adapter sequence to remove from FORWARD reads
    default: AGTGTGGGAGGGTAGTTGGTGTT
    inputBinding:
      position: 101
      prefix: --forwardAdapter
  - id: forward_ext
    type: string
    doc: Unique extension of fastq files containing FORWARD reads. Make sure to 
      include '.gz' if your files are compressed (required)
    inputBinding:
      position: 101
      prefix: --forwardExt
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory where you have your fastq files. If no '--dir' is 
      specified, ctseq will look in your current directory.
    inputBinding:
      position: 101
      prefix: --dir
  - id: molecule_threshold
    type:
      - 'null'
      - int
    doc: number of reads needed to be counted as a unique molecule (default=5)
    default: 5
    inputBinding:
      position: 101
      prefix: --moleculeThreshold
  - id: name_run
    type: string
    doc: number of reads needed to be counted as a unique molecule (required)
    inputBinding:
      position: 101
      prefix: --nameRun
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processes (default=1; default settings could take a long time
      to run)
    default: 1
    inputBinding:
      position: 101
      prefix: --processes
  - id: reads_per_file
    type:
      - 'null'
      - int
    doc: number of reads to analyze per fastq file (should only adjust this if 
      you think you are too big of a file through bismark). Default=5000000 (5 
      million)
    default: 5000000
    inputBinding:
      position: 101
      prefix: --readsPerFile
  - id: ref_dir
    type:
      - 'null'
      - Directory
    doc: Full path to directory where you have already built your methylation 
      reference files. If no '--refDir' is specified, ctseq will look in your 
      current directory.
    inputBinding:
      position: 101
      prefix: --refDir
  - id: reverse_adapter
    type:
      - 'null'
      - string
    doc: adapter sequence to remove from REVERSE reads
    default: ACTCCCCACCTTCCTCATTCTCTAAGACGGTGT
    inputBinding:
      position: 101
      prefix: --reverseAdapter
  - id: reverse_ext
    type: string
    doc: Unique extension of fastq files containing REVERSE reads. Make sure to 
      include '.gz' if your files are compressed (required)
    inputBinding:
      position: 101
      prefix: --reverseExt
  - id: umi_collapse_alg
    type:
      - 'null'
      - string
    doc: 'algorithm used to collapse UMIs, options: default=directional'
    default: directional
    inputBinding:
      position: 101
      prefix: --umiCollapseAlg
  - id: umi_ext
    type:
      - 'null'
      - string
    doc: Unique extension of fastq files containing the UMIs (This flag is 
      REQUIRED if UMIs are contained in separate fastq file). Make sure to 
      include '.gz' if your files are compressed.
    inputBinding:
      position: 101
      prefix: --umiExt
  - id: umi_length
    type: int
    doc: Length of UMI sequence, e.g. 12 (required)
    inputBinding:
      position: 101
      prefix: --umiLength
  - id: umi_threshold
    type:
      - 'null'
      - int
    doc: UMIs with this edit distance will be collapsed together, default=0 
      (don't collapse)
    default: 0
    inputBinding:
      position: 101
      prefix: --umiThreshold
  - id: umi_type
    type: string
    doc: "Choose 'separate' if the UMIs for the reads are contained in a separate
      fastq file where the line after the read name is the UMI. Choose 'inline' if
      the UMIs are already included in the forward/reverse read fastq files in the
      following format: '@M01806:488:0000 00000-J36GT:1:1101:15963:1363:GTAGGTAAAGTG
      1:N:0:CGAGTAAT' where 'GTAGGTAAAGTG' is the UMI"
    inputBinding:
      position: 101
      prefix: --umiType
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_analyze.out

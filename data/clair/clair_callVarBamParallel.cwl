cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - callVarBamParallel
label: clair_callVarBamParallel
doc: "Create commands for calling variants in parallel using a trained model and a BAM file\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: chkpnt_fn
    type: File
    doc: "Trained model checkpoint: give the .index file of the model; the checkpoint prefix (path without .index) is passed, with the .meta and .data-00000-of-00001 files beside it"
    secondaryFiles:
      - pattern: "^.meta"
        required: true
      - pattern: "^.data-00000-of-00001"
        required: true
    inputBinding:
      position: 101
      prefix: --chkpnt_fn
      valueFrom: "$(self.path.replace(/\\.index$/, ''))"
  - id: ref_fn
    type: File
    doc: "Reference fasta file input"
    secondaryFiles:
      - pattern: ".fai"
        required: false
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: bed_fn
    type:
      - 'null'
      - File
    doc: "Call variant only in these regions, default: whole genome"
    inputBinding:
      position: 101
      prefix: --bed_fn
  - id: refChunkSize
    type:
      - 'null'
      - int
    doc: "Divide job with smaller genome chunk size for parallelism, default: 10000000"
    inputBinding:
      position: 101
      prefix: --refChunkSize
  - id: bam_fn
    type: File
    doc: "BAM file input"
    secondaryFiles:
      - pattern: ".bai"
        required: true
    inputBinding:
      position: 101
      prefix: --bam_fn
  - id: vcf_fn
    type:
      - 'null'
      - File
    doc: "Candidate sites VCF file input, if provided, variants will only be called at the sites in the VCF file"
    inputBinding:
      position: 101
      prefix: --vcf_fn
  - id: output_prefix
    type: string
    doc: "Output prefix used in the generated commands"
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: includingAllContigs
    type:
      - 'null'
      - boolean
    doc: "Call variants on all contigs, default: chr{1..22,X,Y,M,MT} and {1..22,X,Y,MT}"
    inputBinding:
      position: 101
      prefix: --includingAllContigs
  - id: tensorflowThreads
    type:
      - 'null'
      - int
    doc: "Number of threads per tensorflow job, default: 4"
    inputBinding:
      position: 101
      prefix: --tensorflowThreads
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Minimum allele frequence of the 1st non-reference allele for a site to be considered as a condidate site, default: 0.200000"
    inputBinding:
      position: 101
      prefix: --threshold
  - id: minCoverage
    type:
      - 'null'
      - float
    doc: "Minimum coverage required to call a variant, default: 4"
    inputBinding:
      position: 101
      prefix: --minCoverage
  - id: stop_consider_left_edge
    type:
      - 'null'
      - boolean
    doc: "If not set, would consider left edge only."
    inputBinding:
      position: 101
      prefix: --stop_consider_left_edge
  - id: samtools
    type:
      - 'null'
      - string
    doc: "Path to the 'samtools', default: samtools"
    inputBinding:
      position: 101
      prefix: --samtools
  - id: pypy
    type:
      - 'null'
      - string
    doc: "Path to the 'pypy', default: pypy3. The CWL default is python3 because the pypy3 in the image lacks the intervaltree module"
    default: python3
    inputBinding:
      position: 101
      prefix: --pypy
  - id: delay
    type:
      - 'null'
      - int
    doc: "Wait a short while for no more than 10 to start the job, default: 10"
    inputBinding:
      position: 101
      prefix: --delay
  - id: qual
    type:
      - 'null'
      - int
    doc: "If set, variant with equal or higher quality will be marked PASS, or LowQual otherwise"
    inputBinding:
      position: 101
      prefix: --qual
  - id: sampleName
    type:
      - 'null'
      - string
    doc: "Define the sample name to be shown in the VCF file"
    inputBinding:
      position: 101
      prefix: --sampleName
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Debug mode"
    inputBinding:
      position: 101
      prefix: --debug
  - id: pysam_for_all_indel_bases
    type:
      - 'null'
      - boolean
    doc: "Always using pysam for outputting indel bases"
    inputBinding:
      position: 101
      prefix: --pysam_for_all_indel_bases
  - id: haploid_precision
    type:
      - 'null'
      - boolean
    doc: "call haploid instead of diploid (output homo-variant only)"
    inputBinding:
      position: 101
      prefix: --haploid_precision
  - id: haploid_sensitive
    type:
      - 'null'
      - boolean
    doc: "call haploid instead of diploid (output non-multi-variant only)"
    inputBinding:
      position: 101
      prefix: --haploid_sensitive
  - id: activation_only
    type:
      - 'null'
      - boolean
    doc: "Output activation only, no prediction"
    inputBinding:
      position: 101
      prefix: --activation_only
  - id: max_plot
    type:
      - 'null'
      - int
    doc: "The maximum number of plots output, negative number means no limit (plot all), default: 10"
    inputBinding:
      position: 101
      prefix: --max_plot
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path for tensorflow logging, default: None"
    inputBinding:
      position: 101
      prefix: --log_path
  - id: parallel_level
    type:
      - 'null'
      - int
    doc: "The level of parallelism in plotting (currently available: 0, 2), default: 2"
    inputBinding:
      position: 101
      prefix: --parallel_level
  - id: fast_plotting
    type:
      - 'null'
      - boolean
    doc: "Enable fast plotting."
    inputBinding:
      position: 101
      prefix: --fast_plotting
  - id: workers
    type:
      - 'null'
      - int
    doc: "The number of workers in plotting, default: 8"
    inputBinding:
      position: 101
      prefix: --workers
  - id: output_for_ensemble
    type:
      - 'null'
      - boolean
    doc: "Output for ensemble"
    inputBinding:
      position: 101
      prefix: --output_for_ensemble
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
stdout: clair_callVarBamParallel.out

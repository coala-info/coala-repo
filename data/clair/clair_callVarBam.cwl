cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - callVarBam
label: clair_callVarBam
doc: "Call variants using a trained model and a BAM file\n\nTool homepage: https://github.com/HKU-BAL/Clair"
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
    doc: "Call variant only in these regions, works in intersection with ctgName, ctgStart and ctgEnd"
    inputBinding:
      position: 101
      prefix: --bed_fn
  - id: bam_fn
    type: File
    doc: "BAM file input"
    secondaryFiles:
      - pattern: ".bai"
        required: true
    inputBinding:
      position: 101
      prefix: --bam_fn
  - id: call_fn
    type: string
    doc: "Output variant predictions (VCF)"
    inputBinding:
      position: 101
      prefix: --call_fn
  - id: vcf_fn
    type:
      - 'null'
      - File
    doc: "Candidate sites VCF file input, if provided, variants will only be called at the sites in the VCF file"
    inputBinding:
      position: 101
      prefix: --vcf_fn
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Minimum allele frequence of the 1st non-reference allele for a site to be considered as a condidate site, default: 0.125000"
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
  - id: ctgName
    type:
      - 'null'
      - string
    doc: "The name of sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgName
  - id: ctgStart
    type:
      - 'null'
      - int
    doc: "The 1-based starting position of the sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgStart
  - id: ctgEnd
    type:
      - 'null'
      - int
    doc: "The 1-based inclusive ending position of the sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgEnd
  - id: stop_consider_left_edge
    type:
      - 'null'
      - boolean
    doc: "If not set, would consider left edge only. That is, count the left-most base-pairs of a read for coverage even if the starting position of a read is after the starting position of a tensor"
    inputBinding:
      position: 101
      prefix: --stop_consider_left_edge
  - id: dcov
    type:
      - 'null'
      - int
    doc: "Cap depth per position at 250"
    inputBinding:
      position: 101
      prefix: --dcov
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
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
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
  - id: calls
    type: File
    doc: "Variant calls (VCF)"
    outputBinding:
      glob: "$(inputs.call_fn)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1

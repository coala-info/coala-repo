cwlVersion: v1.2
class: CommandLineTool
baseCommand: vechat
label: vechat
doc: "Haplotype-aware Error Correction for Noisy Long Reads Using Variation Graphs\n\
  \nTool homepage: https://github.com/HaploKit/vechat"
inputs:
  - id: sequences
    type: File
    doc: input file in FASTA/FASTQ format (can be compressed with gzip) 
      containing sequences used for correction
    inputBinding:
      position: 1
  - id: base
    type:
      - 'null'
      - boolean
    doc: perform base level alignment when computing read overlaps in the first 
      iteration
    inputBinding:
      position: 102
      prefix: --base
  - id: cuda_banded_alignment
    type:
      - 'null'
      - boolean
    doc: use banding approximation for polishing on GPU. Only applicable when -c
      is used.
    inputBinding:
      position: 102
      prefix: --cuda-banded-alignment
  - id: cudaaligner_batches
    type:
      - 'null'
      - int
    doc: number of batches for CUDA accelerated alignment
    inputBinding:
      position: 102
      prefix: --cudaaligner-batches
  - id: cudapoa_batches
    type:
      - 'null'
      - int
    doc: number of batches for CUDA accelerated polishing
    inputBinding:
      position: 102
      prefix: --cudapoa-batches
  - id: error_threshold
    type:
      - 'null'
      - float
    doc: maximum allowed error rate used for filtering overlaps
    inputBinding:
      position: 102
      prefix: --error-threshold
  - id: gap
    type:
      - 'null'
      - int
    doc: gap penalty (must be negative)
    inputBinding:
      position: 102
      prefix: --gap
  - id: include_unpolished
    type:
      - 'null'
      - boolean
    doc: output unpolished target sequences
    inputBinding:
      position: 102
      prefix: --include-unpolished
  - id: linear
    type:
      - 'null'
      - boolean
    doc: perform linear based fragment correction rather than variation graph 
      based fragment correction
    inputBinding:
      position: 102
      prefix: --linear
  - id: match
    type:
      - 'null'
      - int
    doc: score for matching bases
    inputBinding:
      position: 102
      prefix: --match
  - id: min_confidence
    type:
      - 'null'
      - float
    doc: minimum confidence for keeping edges in the graph
    inputBinding:
      position: 102
      prefix: --min-confidence
  - id: min_identity
    type:
      - 'null'
      - float
    doc: minimum identity used for filtering overlaps, only works combined with 
      --base
    inputBinding:
      position: 102
      prefix: --min-identity
  - id: min_identity_cns
    type:
      - 'null'
      - float
    doc: minimum sequence identity between read overlaps in the consensus round
    inputBinding:
      position: 102
      prefix: --min-identity-cns
  - id: min_ovlplen_cns
    type:
      - 'null'
      - int
    doc: minimum read overlap length in the consensus round
    inputBinding:
      position: 102
      prefix: --min-ovlplen-cns
  - id: min_support
    type:
      - 'null'
      - float
    doc: minimum support for keeping edges in the graph
    inputBinding:
      position: 102
      prefix: --min-support
  - id: mismatch
    type:
      - 'null'
      - int
    doc: score for mismatching bases
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: platform
    type:
      - 'null'
      - string
    doc: 'sequencing platform: pb/ont'
    inputBinding:
      position: 102
      prefix: --platform
  - id: quality_threshold
    type:
      - 'null'
      - float
    doc: threshold for average base quality of windows used in POA
    inputBinding:
      position: 102
      prefix: --quality-threshold
  - id: scrub
    type:
      - 'null'
      - boolean
    doc: scrub chimeric reads
    inputBinding:
      position: 102
      prefix: --scrub
  - id: split
    type:
      - 'null'
      - boolean
    doc: split target sequences into chunks (recommend for FASTQ > 20G or FASTA 
      > 10G)
    inputBinding:
      position: 102
      prefix: --split
  - id: split_size
    type:
      - 'null'
      - int
    doc: split target sequences into chunks of desired size in lines, only valid
      when using --split
    inputBinding:
      position: 102
      prefix: --split-size
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: window_length
    type:
      - 'null'
      - int
    doc: size of window on which POA is performed
    inputBinding:
      position: 102
      prefix: --window-length
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vechat:1.1.1--hdcf5f25_1

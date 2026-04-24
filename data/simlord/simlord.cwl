cwlVersion: v1.2
class: CommandLineTool
baseCommand: simlord
label: simlord
doc: "SimLoRD is a read simulator for long reads from third generation sequencing
  and is currently focused on the Pacific Biosciences SMRT error model.\n\nTool homepage:
  https://bitbucket.org/genomeinformatics/simlord/"
inputs:
  - id: output_prefix
    type: string
    doc: Save the simulated reads as a fastq-file at OUTPUT_PREFIX.fastq
    inputBinding:
      position: 1
  - id: chi2_params_n
    type:
      - 'null'
      - type: array
        items: float
    doc: "Parameters for the function determining the parameter n for the chi^2 distribution:
      m, b, z for 'm*x + b' if x < z and 'm*z + b' for x >=z"
      - 0.00189237136
      - 2.5394497
      - 5500
    inputBinding:
      position: 102
      prefix: --chi2-params-n
  - id: chi2_params_s
    type:
      - 'null'
      - type: array
        items: float
    doc: "Parameters for the curve determining the parameter scale for the chi^2 distribution:
      m,b, z, c, a for 'm*x + b' if x <= z and 'c * x^-a' if x > z"
      - 0.01214
      - -5.12
      - 675
      - 48303.0732881
      - 1.4691051212330266
    inputBinding:
      position: 102
      prefix: --chi2-params-s
  - id: coverage
    type:
      - 'null'
      - float
    doc: Desired read coverage.
    inputBinding:
      position: 102
      prefix: --coverage
  - id: fixed_readlength
    type:
      - 'null'
      - int
    doc: Fixed read length for all reads.
    inputBinding:
      position: 102
      prefix: --fixed-readlength
  - id: generate_reference
    type:
      - 'null'
      - string
    doc: Generate a random reference with given GC-content and given length
    inputBinding:
      position: 102
      prefix: --generate-reference
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress the simulated reads using gzip and save them at 
      OUTPUT_PREFIX.fastq.gz
    inputBinding:
      position: 102
      prefix: --gzip
  - id: lognorm_readlength
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Parameters for lognormal read length distribution: (sigma, loc, scale),
      empty for defaults'
    inputBinding:
      position: 102
      prefix: --lognorm-readlength
  - id: max_passes
    type:
      - 'null'
      - int
    doc: Maximal number of passes for one molecule
    inputBinding:
      position: 102
      prefix: --max-passes
  - id: min_readlength
    type:
      - 'null'
      - int
    doc: Minium read length for lognormal distribution
    inputBinding:
      position: 102
      prefix: --min-readlength
  - id: no_sam
    type:
      - 'null'
      - boolean
    doc: Do not calculate the alignment and write a sam file.
    inputBinding:
      position: 102
      prefix: --no-sam
  - id: norm_params
    type:
      - 'null'
      - type: array
        items: float
    doc: Parameters for normal distributed noise added to quality increase sqare
      root function
      - 0
      - 0.2
    inputBinding:
      position: 102
      prefix: --norm-params
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to simulate
    inputBinding:
      position: 102
      prefix: --num-reads
  - id: old_read_names
    type:
      - 'null'
      - boolean
    doc: Use old long read names where all information is encoded in one large 
      string. New format is according to PacBio convention m{}/{}/CCS with read 
      information following after a whitespace.
    inputBinding:
      position: 102
      prefix: --old-read-names
  - id: prob_del
    type:
      - 'null'
      - float
    doc: Probability for deletions for reads with one pass.
    inputBinding:
      position: 102
      prefix: --prob-del
  - id: prob_ins
    type:
      - 'null'
      - float
    doc: Probability for insertions for reads with one pass.
    inputBinding:
      position: 102
      prefix: --prob-ins
  - id: prob_sub
    type:
      - 'null'
      - float
    doc: Probability for substitutions for reads with one pass.
    inputBinding:
      position: 102
      prefix: --prob-sub
  - id: probability_threshold
    type:
      - 'null'
      - float
    doc: Upper bound for the modified total error probability
    inputBinding:
      position: 102
      prefix: --probability-threshold
  - id: read_reference
    type:
      - 'null'
      - File
    doc: Read a reference from PATH to sample reads from
    inputBinding:
      position: 102
      prefix: --read-reference
  - id: sample_readlength_from_fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Sample read length from a fastq-file at PATH containing reads.
    inputBinding:
      position: 102
      prefix: --sample-readlength-from-fastq
  - id: sample_readlength_from_text
    type:
      - 'null'
      - File
    doc: Sample read length from a text file (one length per line).
    inputBinding:
      position: 102
      prefix: --sample-readlength-from-text
  - id: save_reference
    type:
      - 'null'
      - File
    doc: Save the random reference as fasta-file at given PATH. By default, save
      at output path with '_reference.fasta' appended.
    inputBinding:
      position: 102
      prefix: --save-reference
  - id: sqrt_params
    type:
      - 'null'
      - type: array
        items: float
    doc: "Parameters for the sqare root function for the quality increase: a, b for
      'sqrt(x+a) - b'"
      - 0.5
      - 0.2247
    inputBinding:
      position: 102
      prefix: --sqrt-params
  - id: uniform_chromosome_probability
    type:
      - 'null'
      - boolean
    doc: Sample chromosomes for reads equally distributed instead of weighted by
      their length. (Was default behaviour up to version 1.0.1)
    inputBinding:
      position: 102
      prefix: --uniform-chromosome-probability
  - id: without_ns
    type:
      - 'null'
      - boolean
    doc: Skip regions containing Ns and sample reads only from parts completly 
      without Ns.
    inputBinding:
      position: 102
      prefix: --without-ns
outputs:
  - id: sam_output
    type:
      - 'null'
      - File
    doc: Save the alignments in a sam-file at SAM_OUTPUT. By default, use 
      OUTPUT_PREFIX.sam.
    outputBinding:
      glob: $(inputs.sam_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simlord:1.0.4--py39hbcbf7aa_5

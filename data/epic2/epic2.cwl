cwlVersion: v1.2
class: CommandLineTool
baseCommand: epic2
label: epic2
doc: "epic2, version: 0.0.54 (Visit github.com/endrebak/epic2 for examples and help.
  Run epic2-example for a simple example command.)\n\nTool homepage: http://github.com/endrebak/epic2"
inputs:
  - id: treatment
    type:
      type: array
      items: File
    doc: 'Treatment (pull-down) file(s) in one of these formats: bed, bedpe, bed.gz,
      bedpe.gz or (single-end) bam, sam. The --guess-bampe flag enables optional support
      for (paired-end) bampe and sampe formats. Mixing file formats is allowed.'
    inputBinding:
      position: 1
  - id: control
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Control (input) file(s) in one of these formats: bed, bedpe, bed.gz, bedpe.gz
      or (single-end) bam, sam. The --guess-bampe flag enables optional support for
      (paired-end) bampe and sampe formats. Mixing file formats is allowed.'
    inputBinding:
      position: 2
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Which genome to analyze. Default: hg19. If --chromsizes and --egf flag is
      given, --genome is not required.'
    inputBinding:
      position: 103
      prefix: --genome
  - id: autodetect_chroms
    type:
      - 'null'
      - boolean
    doc: (bampe/bam only.) Autodetect chromosomes from bam file. Use with 
      --discard-chromosomes flag to avoid non-canonical chromosomes.
    inputBinding:
      position: 103
      prefix: --autodetect-chroms
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Size of the windows to scan the genome. BIN-SIZE is the smallest 
      possible island. Default 200.
    inputBinding:
      position: 103
      prefix: --bin-size
  - id: chromsizes
    type:
      - 'null'
      - File
    doc: 'Set the chromosome lengths yourself in a file with two columns: chromosome
      names and sizes. Useful to analyze custom genomes, assemblies or simulated data.
      Only chromosomes included in the file will be analyzed.'
    inputBinding:
      position: 103
      prefix: --chromsizes
  - id: discard_chromosomes_pattern
    type:
      - 'null'
      - string
    doc: (bampe/bam only.) Discard reads from chromosomes matching this pattern.
      Default '_'. Note that if you are not interested in the results from 
      non-canonical chromosomes, you should ensure they are removed with this 
      flag, otherwise they will make the statistical analysis too stringent.
    inputBinding:
      position: 103
      prefix: --discard-chromosomes-pattern
  - id: e_value
    type:
      - 'null'
      - int
    doc: 'The E-value controls the genome-wide error rate of identified islands under
      the random background assumption. Should be used when not using a control library.
      Default: 1000.'
    inputBinding:
      position: 103
      prefix: --e-value
  - id: effective_genome_fraction
    type:
      - 'null'
      - float
    doc: Use a different effective genome fraction than the one included in 
      epic2. The default value depends on the genome and readlength, but is a 
      number between 0 and 1.
    inputBinding:
      position: 103
      prefix: --effective-genome-fraction
  - id: example
    type:
      - 'null'
      - boolean
    doc: Show the paths of the example data and an example command.
    inputBinding:
      position: 103
      prefix: --example
  - id: false_discovery_rate_cutoff
    type:
      - 'null'
      - float
    doc: Remove all islands with an FDR above cutoff. Default 0.05.
    inputBinding:
      position: 103
      prefix: --false-discovery-rate-cutoff
  - id: filter_flag
    type:
      - 'null'
      - int
    doc: '(bampe/bam only.) Discard reads with these bits set in flag. Same as `samtools
      view -F`. Default 1540 (hex: 0x604). See https://broadinstitute.github.io/picard/explain-flags.html
      for more info.'
    inputBinding:
      position: 103
      prefix: --filter-flag
  - id: fragment_size
    type:
      - 'null'
      - int
    doc: (Single end reads only) Size of the sequenced fragment. Each read is 
      extended half the fragment size from the 5' end. Default 150 (i.e. extend 
      by 75).
    inputBinding:
      position: 103
      prefix: --fragment-size
  - id: gaps_allowed
    type:
      - 'null'
      - int
    doc: 'This number is multiplied by the window size to determine the number of
      gaps (ineligible windows) allowed between two eligible windows. Must be an integer.
      Default: 3.'
    inputBinding:
      position: 103
      prefix: --gaps-allowed
  - id: guess_bampe
    type:
      - 'null'
      - boolean
    doc: Autodetect bampe file format based on flags from the first 100 reads. 
      If all of them are paired, then the format is bampe. Only properly paired 
      reads are processed by default (0x1 and 0x2 samtools flags).
    inputBinding:
      position: 103
      prefix: --guess-bampe
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: 'Keep reads mapping to the same position on the same strand within a library.
      Default: False.'
    inputBinding:
      position: 103
      prefix: --keep-duplicates
  - id: mapq
    type:
      - 'null'
      - int
    doc: (bampe/bam only.) Discard reads with mapping quality lower than this. 
      Default 5.
    inputBinding:
      position: 103
      prefix: --mapq
  - id: original_algorithm
    type:
      - 'null'
      - boolean
    doc: Use the original SICER algorithm, without the epic2 fix. This will use 
      all reads in your files to compute the p-values, including those falling 
      outside the genome boundaries.
    inputBinding:
      position: 103
      prefix: --original-algorithm
  - id: original_statistics
    type:
      - 'null'
      - boolean
    doc: Use the original SICER way of computing the statistics. Like SICER 
      itself, this method raises an error on large datasets. Only included for 
      debugging-purposes.
    inputBinding:
      position: 103
      prefix: --original-statistics
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output messages to stderr.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: required_flag
    type:
      - 'null'
      - int
    doc: (bampe/bam only.) Keep reads with these bits set in flag. Same as 
      `samtools view -f`. Default 0
    inputBinding:
      position: 103
      prefix: --required-flag
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'File to write results to. Default: stdout.'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epic2:0.0.54--py310h5140242_0

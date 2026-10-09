cwlVersion: v1.2
class: CommandLineTool
baseCommand: kingaroo
label: kin_kingaroo
doc: "Input generation pipeline for KIN: converts BAM files into the window counts and\
  \ runs-of-homozygosity files that KIN reads. The BAM files are staged in the working\
  \ directory, which is also where the output files are written.\n\nTool homepage:\
  \ https://github.com/DivyaratanPopli/Kinship_Inference"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.bam_files)
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: BAM files to analyse. They are staged in the working directory; the
      chromosomes must be named 1, 2, ..., X, Y. Name them as in target_location.
  - id: bamfiles_location
    type: string
    default: .
    doc: bamfiles directory (the working directory, where bam_files are staged)
    inputBinding:
      position: 1
      prefix: --bamfiles_location
  - id: bedfile
    type: File
    doc: Path to a tab-separated .bed file with chromosome, position, position+1,
      reference allele and alternate allele at all available positions.
    inputBinding:
      position: 1
      prefix: --bedfile
  - id: target_location
    type: File
    doc: File with the bamfile names (without the .bam extension) that should be used.
    inputBinding:
      position: 1
      prefix: --target_location
  - id: contam_parameter
    type: float
    doc: Enter 0 for no contamination correction. Enter 1 for contamination
      correction with divergence calculated from vcf.gz. Enter divergence
      (between 0 and 1) if known.
    inputBinding:
      position: 1
      prefix: --contam_parameter
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores available
    inputBinding:
      position: 1
      prefix: --cores
  - id: interval
    type:
      - 'null'
      - int
    doc: 'Length of a genomic window in bases. Options: 1000000, 10000000 (by default
      10000000)'
    inputBinding:
      position: 1
      prefix: --interval
  - id: threshold
    type:
      - 'null'
      - int
    doc: p_0 is estimated with all libraries that have at least t number of
      informative windows (by default t=10)
    inputBinding:
      position: 1
      prefix: --threshold
  - id: contamination_estimates
    type:
      - 'null'
      - File
    doc: 'Tab-separated contamination estimates file with columns: name,contamination'
    inputBinding:
      position: 1
      prefix: --contamination_estimates
  - id: divergence_file
    type:
      - 'null'
      - File
    doc: Indexed compressed vcf file with an individual from the target and the
      contaminating population each. Diploid genotypes (GT) should be represented.
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 1
      prefix: --divergence_file
  - id: target_ind
    type:
      - 'null'
      - string
    doc: Name of target individual in divergence_vcf file
    inputBinding:
      position: 1
      prefix: --target_ind
  - id: contaminating_ind
    type:
      - 'null'
      - string
    doc: Name of contaminating individual in divergence_vcf file
    inputBinding:
      position: 1
      prefix: --contaminating_ind
  - id: roh
    type:
      - 'null'
      - int
    doc: Enter 1 if you need ROH estimates. Enter 0 if you already have the
      positions of ROH tracts (by default 1).
    inputBinding:
      position: 1
      prefix: --roh
  - id: diversity_parameter_p_0
    type:
      - 'null'
      - float
    doc: Enter p_0 estimate for input to ROH-HMM, if quality of samples is not
      good enough to estimate p_0.
    inputBinding:
      position: 1
      prefix: --diversity_parameter_p_0
  - id: noisy_wins
    type:
      - 'null'
      - File
    doc: File with a list of noisy window indexes (0-based) that should be filtered out.
    inputBinding:
      position: 1
      prefix: --noisy_wins
  - id: test_input
    type:
      - 'null'
      - int
    doc: Enter 1 to test your input files
    inputBinding:
      position: 1
      prefix: --test_input
  - id: number_of_chromosomes
    type:
      - 'null'
      - int
    doc: Enter the total number of chromosomes. Default=22
    inputBinding:
      position: 1
      prefix: --number_of_chromosomes
  - id: sort_index
    type:
      - 'null'
      - int
    doc: Enter 1 if you need to sort and index the bamfiles. Enter 0 to skip
      this step (by default 1).
    inputBinding:
      position: 1
      prefix: --sort_index
outputs:
  - id: kin_input_files
    type:
      type: array
      items: File
    doc: Input files for KIN (window counts, interval, target samples, ROH files)
    outputBinding:
      glob: ['*.csv', '*.txt']
  - id: hmm_parameters
    type:
      - 'null'
      - Directory
    outputBinding:
      glob: hmm_parameters
  - id: hbd_results
    type:
      - 'null'
      - Directory
    outputBinding:
      glob: hbd_results
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kin:3.1.4--pyhdfd78af_0

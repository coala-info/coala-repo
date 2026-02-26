cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfsim
label: vcfsim
doc: "VCFSim is used to accurately simulate VCFs\n\nTool homepage: https://github.com/Pie115/VCFSimulator-SamukLab"
inputs:
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Chromosome name
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: chromosome_file
    type:
      - 'null'
      - File
    doc: Specified file for multiple chromosome inputs
    inputBinding:
      position: 101
      prefix: --chromosome_file
  - id: hmm_baseline
    type:
      - 'null'
      - float
    doc: Baseline site missing probability in good regions
    inputBinding:
      position: 101
      prefix: --hmm_baseline
  - id: hmm_multiplier
    type:
      - 'null'
      - float
    doc: Multiplier for missingness in bad regions
    inputBinding:
      position: 101
      prefix: --hmm_multiplier
  - id: hmm_p_bad_to_good
    type:
      - 'null'
      - float
    doc: Probability of switching from bad to good region
    inputBinding:
      position: 101
      prefix: --hmm_p_bad_to_good
  - id: hmm_p_good_to_bad
    type:
      - 'null'
      - float
    doc: Probability of switching from good to bad region
    inputBinding:
      position: 101
      prefix: --hmm_p_good_to_bad
  - id: mu
    type:
      - 'null'
      - float
    doc: Mutation rate in the simulated population
    inputBinding:
      position: 101
      prefix: --mu
  - id: ne
    type:
      - 'null'
      - float
    doc: Effective population size of the simulated population
    inputBinding:
      position: 101
      prefix: --Ne
  - id: percent_missing_genotypes
    type: string
    doc: Percent of samples missing from your VCF
    inputBinding:
      position: 101
      prefix: --percent_missing_genotypes
  - id: percent_missing_sites
    type: string
    doc: Percent of rows missing from your VCF
    inputBinding:
      position: 101
      prefix: --percent_missing_sites
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy for your VCF
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: population_mode
    type:
      - 'null'
      - string
    doc: "1 = single population (default), 2 = population C\n                    \
      \    splits into A and B at given time"
    inputBinding:
      position: 101
      prefix: --population_mode
  - id: replicates
    type:
      - 'null'
      - int
    doc: Amount of times for Simulator to run
    inputBinding:
      position: 101
      prefix: --replicates
  - id: sample_size
    type:
      - 'null'
      - string
    doc: Number of samples to simulate
    inputBinding:
      position: 101
      prefix: --sample_size
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sample names to simulate
    inputBinding:
      position: 101
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File containing sample names to simulate
    inputBinding:
      position: 101
      prefix: --samples_file
  - id: seed
    type: string
    doc: Random seed for VCFSim to use
    inputBinding:
      position: 101
      prefix: --seed
  - id: sequence_length
    type:
      - 'null'
      - int
    doc: Size of your site
    inputBinding:
      position: 101
      prefix: --sequence_length
  - id: time
    type:
      - 'null'
      - string
    doc: Time of split (only used if --population_mode is 2)
    inputBinding:
      position: 101
      prefix: --time
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Filename of outputed vcf, will automatically be\n                      \
      \  followed by seed"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfsim:1.0.27.alpha--pyhdc42f0e_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [simulator.py, metagenome]
label: nanosim_simulator_metagenome
doc: "Simulate ONT metagenome reads from a list of reference genomes with abundance values, using error profiles.\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs:
  - id: genome_list
    type: File
    doc: "Reference metagenome list, tsv file: first column species/strain name, second column the reference genome fasta/fastq file path."
    inputBinding:
      position: 1
      prefix: --genome_list
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Genome FASTA files named in the genome list; staged in the working directory so the names resolve."
  - id: abun
    type: File
    doc: "Abundance list, tsv file with header; the abundance of all species in each sample must sum up to 100."
    inputBinding:
      position: 1
      prefix: --abun
  - id: dna_type_list
    type:
      - 'null'
      - File
    doc: "DNA type list, tsv file: species/strain, chromosome name, DNA type (circular or linear)."
    inputBinding:
      position: 1
      prefix: --dna_type_list
  - id: model_prefix
    type:
      - 'null'
      - string
    doc: "Location and prefix of error profiles generated from characterization step (Default = training)."
    inputBinding:
      position: 1
      prefix: --model_prefix
  - id: model_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Error profile files written by read_analysis (training_*); staged in the working directory so the model prefix resolves."
  - id: output
    type:
      - 'null'
      - string
    doc: "Output location and prefix for simulated reads (Default = simulated)."
    inputBinding:
      position: 1
      prefix: --output
  - id: max_len
    type:
      - 'null'
      - int
    doc: "The maximum length for simulated reads (Default = Infinity)."
    inputBinding:
      position: 1
      prefix: --max_len
  - id: min_len
    type:
      - 'null'
      - int
    doc: "The minimum length for simulated reads (Default = 50)."
    inputBinding:
      position: 1
      prefix: --min_len
  - id: median_len
    type:
      - 'null'
      - float
    doc: "The median read length (Default = None). Not compatible with chimeric read simulation."
    inputBinding:
      position: 1
      prefix: --median_len
  - id: sd_len
    type:
      - 'null'
      - float
    doc: "The standard deviation of read length in log scale (Default = None). Not compatible with chimeric read simulation."
    inputBinding:
      position: 1
      prefix: --sd_len
  - id: seed
    type:
      - 'null'
      - int
    doc: "Manually seeds the pseudo-random number generator."
    inputBinding:
      position: 1
      prefix: --seed
  - id: strandness
    type:
      - 'null'
      - float
    doc: "Percentage of antisense sequences. Overrides the value profiled in the characterization stage. Between 0 and 1."
    inputBinding:
      position: 1
      prefix: --strandness
  - id: perfect
    type:
      - 'null'
      - boolean
    doc: "Ignore error profiles and simulate perfect reads."
    inputBinding:
      position: 1
      prefix: --perfect
  - id: abun_var
    type:
      - 'null'
      - type: array
        items: float
    doc: "Simulate random variation in abundance values, takes two values: relative_var_low relative_var_high."
    inputBinding:
      position: 1
      prefix: --abun_var
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Output fastq files instead of fasta files."
    inputBinding:
      position: 1
      prefix: --fastq
  - id: chimeric
    type:
      - 'null'
      - boolean
    doc: "Simulate chimeric reads."
    inputBinding:
      position: 1
      prefix: --chimeric
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads for simulation (Default = 1)."
    inputBinding:
      position: 1
      prefix: --num_threads
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Simulated reads and error lists written with the output prefix.
    outputBinding:
      glob: "$((inputs.output ? inputs.output : 'simulated') + '*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$((inputs.model_files || []).concat(inputs.genome_files || []))"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0

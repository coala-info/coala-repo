cwlVersion: v1.2
class: CommandLineTool
baseCommand: [simulator.py, transcriptome]
label: nanosim_simulator_transcriptome
doc: "Simulate ONT cDNA or direct RNA reads from a reference transcriptome using error profiles.\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs:
  - id: ref_t
    type: File
    doc: "Input reference transcriptome."
    inputBinding:
      position: 1
      prefix: --ref_t
  - id: ref_g
    type:
      - 'null'
      - File
    doc: "Input reference genome, required if intron retention simulation is on."
    inputBinding:
      position: 1
      prefix: --ref_g
  - id: exp
    type: File
    doc: "Expression profile in the specified format as described in the README."
    inputBinding:
      position: 1
      prefix: --exp
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
  - id: number
    type:
      - 'null'
      - int
    doc: "Number of reads to be simulated (Default = 20000)."
    inputBinding:
      position: 1
      prefix: --number
  - id: coverage
    type:
      - 'null'
      - float
    doc: "Coverage of the simulated reads. Coverage overrides the number of reads."
    inputBinding:
      position: 1
      prefix: --coverage
  - id: max_len
    type:
      - 'null'
      - int
    doc: "The maximum length for simulated unaligned reads (Default = Infinity)."
    inputBinding:
      position: 1
      prefix: --max_len
  - id: min_len
    type:
      - 'null'
      - int
    doc: "The minimum length for simulated unaligned reads (Default = 50)."
    inputBinding:
      position: 1
      prefix: --min_len
  - id: seed
    type:
      - 'null'
      - int
    doc: "Manually seeds the pseudo-random number generator."
    inputBinding:
      position: 1
      prefix: --seed
  - id: homopolymer
    type:
      - 'null'
      - boolean
    doc: "Simulate homopolymer lengths (Default = False)."
    inputBinding:
      position: 1
      prefix: --homopolymer
  - id: kmer_bias
    type:
      - 'null'
      - int
    doc: "Minimum homopolymer length to simulate homopolymer contraction and expansion events in, a typical k is 6."
    inputBinding:
      position: 1
      prefix: --KmerBias
  - id: basecaller
    type:
      - 'null'
      - string
    doc: "Simulate polyA tails with respect to the chosen basecaller: albacore or guppy."
    inputBinding:
      position: 1
      prefix: --basecaller
  - id: strandness
    type:
      - 'null'
      - float
    doc: "Proportion of sense sequences. Overrides the value profiled in the characterization stage. Between 0 and 1."
    inputBinding:
      position: 1
      prefix: --strandness
  - id: no_model_ir
    type:
      - 'null'
      - boolean
    doc: "Ignore simulating intron retention events."
    inputBinding:
      position: 1
      prefix: --no_model_ir
  - id: perfect
    type:
      - 'null'
      - boolean
    doc: "Ignore profiles and simulate perfect reads."
    inputBinding:
      position: 1
      prefix: --perfect
  - id: polya
    type:
      - 'null'
      - File
    doc: "Simulate polyA tails for the given list of transcripts."
    inputBinding:
      position: 1
      prefix: --polya
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Output fastq files instead of fasta files."
    inputBinding:
      position: 1
      prefix: --fastq
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads for simulation (Default = 1)."
    inputBinding:
      position: 1
      prefix: --num_threads
  - id: uracil
    type:
      - 'null'
      - boolean
    doc: "Converts the thymine (T) bases to uracil (U) in the output fasta format."
    inputBinding:
      position: 1
      prefix: --uracil
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
    listing: "$(inputs.model_files ? inputs.model_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0

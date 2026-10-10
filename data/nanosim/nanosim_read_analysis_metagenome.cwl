cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_analysis.py, metagenome]
label: nanosim_read_analysis_metagenome
doc: "Read characterization step in metagenome mode: given raw ONT reads and a list of reference genomes, learn read features and output error profiles.\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs:
  - id: read
    type: File
    doc: "Input read for training."
    inputBinding:
      position: 1
      prefix: --read
  - id: genome_list
    type: File
    doc: "Reference metagenome list, tsv file: species/strain name, reference genome fasta/fastq path, and optional expected abundance (sum up to 100)."
    inputBinding:
      position: 1
      prefix: --genome_list
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Genome FASTA files named in the genome list; staged in the working directory so the names resolve."
  - id: g_alnm
    type:
      - 'null'
      - File
    doc: "Genome alignment file in sam format, the header of each species should match the metagenome list (optional)."
    inputBinding:
      position: 1
      prefix: --g_alnm
  - id: output
    type:
      - 'null'
      - string
    doc: "The location and prefix of output profiles (Default = training)."
    inputBinding:
      position: 1
      prefix: --output
  - id: chimeric
    type:
      - 'null'
      - boolean
    doc: "Detect chimeric and split reads (Default = False)."
    inputBinding:
      position: 1
      prefix: --chimeric
  - id: quantification
    type:
      - 'null'
      - boolean
    doc: "Perform abundance quantification and compute the deviation between calculated abundance and expected values (Default = False)."
    inputBinding:
      position: 1
      prefix: --quantification
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Analyze base qualities (Default = False)."
    inputBinding:
      position: 1
      prefix: --fastq
  - id: no_model_fit
    type:
      - 'null'
      - boolean
    doc: "Disable model fitting step."
    inputBinding:
      position: 1
      prefix: --no_model_fit
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Default = 1)."
    inputBinding:
      position: 1
      prefix: --num_threads
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Error profile files written with the output prefix.
    outputBinding:
      glob: "$((inputs.output ? inputs.output : 'training') + '*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.genome_files ? inputs.genome_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0

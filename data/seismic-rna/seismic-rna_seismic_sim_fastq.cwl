cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - sim
  - fastq
label: seismic-rna_seismic_sim_fastq
doc: 'Simulate a FASTQ file.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step(s). It is copied into the working directory
      under the name given by the output directory option (default out, or sim for
      the sim commands).
  - id: input_path
    type:
      - 'null'
      - type: array
        items: string
    doc: Relate report files or directories inside the staged sim directory to simulate
      FASTQ files from
    inputBinding:
      position: 201
  - id: param_dir
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --param-dir
    doc: Simulate data using parameter files in this directory (path inside the staged
      sim directory; the option is given once per directory)
    inputBinding:
      position: 100
  - id: profile_name
    type:
      - 'null'
      - string
    doc: 'Give the simulated structure and parameters this profile name [default:
      simulated]'
    inputBinding:
      position: 100
      prefix: --profile-name
  - id: sample
    type:
      - 'null'
      - string
    doc: 'Give this name to the simulated sample [default: sim-sample]'
    inputBinding:
      position: 100
      prefix: --sample
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: 'Simulate paired-end or single-end reads [default: paired-end]'
    inputBinding:
      position: 100
      prefix: --paired-end
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: 'Simulate paired-end or single-end reads [default: paired-end]'
    inputBinding:
      position: 100
      prefix: --single-end
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'Simulate reads with this many base calls [default: 151]'
    inputBinding:
      position: 100
      prefix: --read-length
  - id: reverse_fraction
    type:
      - 'null'
      - float
    doc: 'Simulate this fraction of reverse-oriented reads [default: 0.5]'
    inputBinding:
      position: 100
      prefix: --reverse-fraction
  - id: min_mut_gap
    type:
      - 'null'
      - int
    doc: 'Mask reads with two mutations separated by fewer than this many bases [default:
      4]'
    inputBinding:
      position: 100
      prefix: --min-mut-gap
  - id: fq_gzip
    type:
      - 'null'
      - boolean
    doc: 'Simulate FASTQ files with gzip compression or as plain text [default: fq-gzip]'
    inputBinding:
      position: 100
      prefix: --fq-gzip
  - id: fq_text
    type:
      - 'null'
      - boolean
    doc: 'Simulate FASTQ files with gzip compression or as plain text [default: fq-gzip]'
    inputBinding:
      position: 100
      prefix: --fq-text
  - id: num_reads
    type:
      - 'null'
      - int
    doc: 'Simulate this many reads [default: 65536]'
    inputBinding:
      position: 100
      prefix: --num-reads
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Use up to this many CPUs simultaneously [default: 20]'
    inputBinding:
      position: 100
      prefix: --num-cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --no-force
outputs:
  - id: sim_dir_result
    type: Directory
    doc: Simulation directory with the input and the new files
    outputBinding:
      glob: sim
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: sim
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0

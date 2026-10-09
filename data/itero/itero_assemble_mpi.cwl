cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - itero
  - assemble
  - mpi
label: itero_assemble_mpi
doc: "Assemble reads using MPI for assembly.\n\nTool homepage: https://github.com/faircloth-lab/itero"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.config)
        entryname: conf/$(inputs.config.basename)
      - $(inputs.staged_files)
inputs:
  - id: config
    type: File
    doc: A configuration file containing reads to assemble. It is staged in the folder conf, so relative paths in it must start with .. (for example ../ref.fa and ../reads).
    inputBinding:
      prefix: --config
      valueFrom: conf/$(self.basename)
  - id: staged_files
    type:
      - type: array
        items:
          - File
          - Directory
    doc: Reference file and read directories named in the configuration file, staged in the working directory.
  - id: subfolder
    type: ['null', string]
    doc: A subdirectory, below the level of the group, containing the reads
    inputBinding:
      prefix: --subfolder
  - id: iterations
    type: ['null', int]
    doc: The number of iterations to run for each locus
    inputBinding:
      prefix: --iterations
  - id: local_cores
    type: ['null', int]
    doc: The number of cores to use on the main node
    inputBinding:
      prefix: --local-cores
  - id: clean
    type: ['null', boolean]
    doc: Cleanup all intermediate files
    inputBinding:
      prefix: --clean
  - id: only_single_locus
    type: ['null', boolean]
    doc: Assemble only to a single contig
    inputBinding:
      prefix: --only-single-locus
  - id: allow_multiple_contigs
    type: ['null', boolean]
    doc: Allow assembly stages to produce multiple contigs
    inputBinding:
      prefix: --allow-multiple-contigs
  - id: do_not_zip
    type: ['null', boolean]
    doc: Do not zip the iteration files, which is the default behavior.
    inputBinding:
      prefix: --do-not-zip
  - id: verbosity
    type:
      - 'null'
      - type: enum
        symbols:
          - INFO
          - WARN
          - CRITICAL
    doc: The logging level to use.
    inputBinding:
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: The path to a directory to hold logs.
    inputBinding:
      prefix: --log-path
  - id: output
    type: string
    doc: The directory in which to store the output
    inputBinding:
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the assembled loci
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itero:1.1.2--py27_0
stdout: itero_assemble_mpi.out

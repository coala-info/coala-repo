cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfs_create
label: sfs_create
doc: "Tools for working with site frequency spectra\n\nTool homepage: https://github.com/malthesr/sfs"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: "Input VCF/BCF.\n          \n          If no file is provided, stdin will
      be used. Input may be BGZF-compressed or uncompressed."
    inputBinding:
      position: 1
  - id: precision
    type:
      - 'null'
      - int
    doc: "Output precision.\n          \n          This option is only used when projecting,
      and otherwise set to zero since the output must be integer counts."
    inputBinding:
      position: 102
      prefix: --precision
  - id: project_individuals
    type:
      - 'null'
      - type: array
        items: string
    doc: "Projected individuals.\n          \n          By default, any site with
      missing and/or multiallelic genotypes in the applied sample subset will be skipped.
      Where this leads to too much missingness, the SFS can be projected to a lower
      number of individuals using hypergeometric sampling. By doing so, all sites
      with data for at least as this required shape will be used, and those with more
      data will be projected down. Use a comma-separated list of values giving the
      new shape of the SFS. For example, `--project-individuals 3,2` would project
      a two-dimensional SFS down to three individuals in the first dimension and two
      in the second."
    inputBinding:
      position: 102
      prefix: --project-individuals
  - id: project_shape
    type:
      - 'null'
      - type: array
        items: string
    doc: "Projected shape.\n          \n          Alternative to `--project-individuals`,
      see documentation for background. Using this argument, the projection can be
      specified by shape, rather than number of individuals. For example, `--project-shape
      7,5` would project a two-dimensional SFS down to three diploid individuals in
      the first dimension and two in the second."
    inputBinding:
      position: 102
      prefix: --project-shape
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: "Suppress log output.\n          \n          By default, information may
      be logged to stderr while running. Set this flag once to silence normal logging
      output, and set twice to silence warnings."
    inputBinding:
      position: 102
      prefix: --quiet
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample subset.\n          \n          By default, a one-dimensional SFS
      of all samples is created. Using this argument, the subset of samples can be
      restricted. Multiple, comma-separated values may be provided. To construct a
      multi-dimensional SFS, the samples may be provided as `sample=population` pairs.
      The ordering of populations in the resulting SFS corresponds to the order of
      appearance of input population names."
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: "Sample subset file.\n          \n          Alternative to `--samples`, see
      documentation for background. Using this argument, the sample subset can be
      provided as a file. Each line should contain the name of a sample. Optionally,
      the file may contain a second, tab-delimited column with population identifiers."
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: strict
    type:
      - 'null'
      - boolean
    doc: "Fail on missingness.\n          \n          By default, any site with missing
      and/or multiallelic genotypes in the applied sample subset are skipped and logged.
      Using this flag will cause an error if such genotypes are encountered."
    inputBinding:
      position: 102
      prefix: --strict
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads.\n          \n          Multi-threading currently only
      affects reading and parsing BGZF compressed input."
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: "Log output verbosity.\n          \n          Set this flag times to show
      debug information, and set twice to show trace information."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
stdout: sfs_create.out

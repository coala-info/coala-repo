cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar ibdne.04Sep15.e78.jar
label: ibdne
doc: "Calculates Identity By Descent (IBD) segments between individuals.\n\nTool homepage:
  https://github.com/hennlab/AS-IBDNe"
inputs:
  - id: input_ibd_files
    type:
      type: array
      items: File
    doc: A space-separated list of Beagle-format IBD files piped from stdin.
    inputBinding:
      position: 1
  - id: filter_samples
    type:
      - 'null'
      - boolean
    doc: Whether to filter samples
    default: true
    inputBinding:
      position: 102
      prefix: filtersamples
  - id: genetic_map
    type: File
    doc: PLINK-format genetic map with cM distances
    inputBinding:
      position: 102
      prefix: map
  - id: max_generations
    type:
      - 'null'
      - string
    doc: Max number of generations before present (default depends on minibd)
    inputBinding:
      position: 102
      prefix: gmax
  - id: min_ibd_length
    type:
      - 'null'
      - float
    doc: Minimum cM length of an IBD segment
    default: 4.0
    inputBinding:
      position: 102
      prefix: minibd
  - id: min_region_length
    type:
      - 'null'
      - float
    doc: Minimum cM length of a continuous region
    default: 50.0
    inputBinding:
      position: 102
      prefix: minregion
  - id: num_bootstrap_samples
    type:
      - 'null'
      - int
    doc: Number of bootstrap samples
    default: 80
    inputBinding:
      position: 102
      prefix: nboots
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations
    default: 50
    inputBinding:
      position: 102
      prefix: nits
  - id: num_random_starts
    type:
      - 'null'
      - int
    doc: Number of random starts
    default: 50
    inputBinding:
      position: 102
      prefix: nstarts
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of computational threads
    default: 1
    inputBinding:
      position: 102
      prefix: nthreads
  - id: output_prefix
    type: string
    doc: Output file prefix
    inputBinding:
      position: 102
      prefix: out
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    default: -99999
    inputBinding:
      position: 102
      prefix: seed
  - id: trim_ends
    type:
      - 'null'
      - float
    doc: cM to trim from ends of each region
    default: 0.2
    inputBinding:
      position: 102
      prefix: trim
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne.out

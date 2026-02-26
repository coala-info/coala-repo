cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacerextractor
  - run_cctyper
label: spacerextractor_run_cctyper
doc: "run CRISPR-Cas typer on a (set of) new genomes to identify new CRISPR repeats\n\
  \nTool homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
inputs:
  - id: bbtools_memory
    type:
      - 'null'
      - string
    doc: memory allocated to bbtools
    default: 20g
    inputBinding:
      position: 101
      prefix: --bbtools_memory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Run in a more verbose mode for debugging / troubleshooting purposes (warning:
      spacerextractor becomes quite chatty in this mode..)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: force_rerun
    type:
      - 'null'
      - boolean
    doc: If you want to force SpacerExtractor to recompute all the steps
    inputBinding:
      position: 101
      prefix: --force_rerun
  - id: genome_id_prefix
    type:
      - 'null'
      - string
    doc: If you want to add the genome id as a prefix to contig id (i.e. if your
      contig ids are not already unique).
    inputBinding:
      position: 101
      prefix: --genome_id_prefix
  - id: input_dir
    type: Directory
    doc: Path to the folder containing the input genome(s) (one fasta file per 
      genome/MAG)
    inputBinding:
      position: 101
      prefix: --input
  - id: n_threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 2
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in a very quiet mode, will only show error/critical messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: working_dir
    type: Directory
    doc: Output folder where CRISPRCas Typer results will be stored (will be 
      created if it does not exist)
    inputBinding:
      position: 101
      prefix: --wdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
stdout: spacerextractor_run_cctyper.out

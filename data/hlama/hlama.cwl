cwlVersion: v1.2
class: CommandLineTool
baseCommand: hlama
label: hlama
doc: "HLA-typing based HTS sample matching\n\nTool homepage: https://github.com/bihealth/hlama"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Optional explicit path to configuration file, by default ~/.hlama.cfg 
      is searched for
    inputBinding:
      position: 101
      prefix: --config
  - id: disable_checks
    type:
      - 'null'
      - boolean
    doc: Disable input checks
    inputBinding:
      position: 101
      prefix: --disable-checks
  - id: dont_run_snakemake
    type:
      - 'null'
      - boolean
    doc: Only create Snakefile but do not run Snakemake yet
    inputBinding:
      position: 101
      prefix: --dont-run-snakemake
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for read mapping, defaults to 1
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: pedigree
    type:
      - 'null'
      - File
    doc: Path to pedigree file, starts pedigree mode
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: reads_base_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Base directory for reads, give multiple times for multiple places to 
      search
    inputBinding:
      position: 101
      prefix: --reads-base-dir
  - id: tumor_normal
    type:
      - 'null'
      - File
    doc: Path to tumor/normal TSV file, starts tumor/normal mode
    inputBinding:
      position: 101
      prefix: --tumor-normal
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Directory to create the Snakefile in
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlama:3.0.1--py35_0
stdout: hlama.out

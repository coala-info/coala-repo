cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacerextractor
  - build_database
label: spacerextractor_build_database
doc: "add new repeats identified by CRISPR-Cas typer to the repeat database\n\nTool
  homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
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
  - id: input_from_contigs
    type: File
    doc: A table file listing additional CRISPR array obtained from contigs of 
      this dataset, in the format of CRISPR Cas Typer output crisprs_all.tab 
      (see https://github.com/Russel88/CRISPRCasTyper). This can be directly the
      crisprs_all.tab output of CRISPR Cas Typer, or the output of 
      SE_run_cctyper.py (specifically `all_refined_repeats.tab`), and will add 
      additional 'local' CRISPR arrays to a new or existing database.
    inputBinding:
      position: 101
      prefix: --input_from_contigs
  - id: n_threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 2
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: new_db_dir
    type: Directory
    doc: Path to the repeat database folder, will be created or overwritten 
      (with option fr)
    inputBinding:
      position: 101
      prefix: --new_db_dir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in a very quiet mode, will only show error/critical messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ref_db_dir
    type:
      - 'null'
      - Directory
    doc: Path to the original repeat database folder, to which we will be add 
      the new repeats. If not provided, then build_database will try to add to 
      the database path provided with --new_db_dir (if it already exists).
    inputBinding:
      position: 101
      prefix: --ref_db_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
stdout: spacerextractor_build_database.out

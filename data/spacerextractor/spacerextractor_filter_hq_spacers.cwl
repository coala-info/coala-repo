cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacerextractor
  - filter_hq_spacers
label: spacerextractor_filter_hq_spacers
doc: "filter results of 'extract_spacers' to only retain high-quality spacers\n\nTool homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
inputs:
  - id: repeat_db_dir
    type: Directory
    doc: "Path to the repeat database folder"
    inputBinding:
      position: 101
      prefix: --repeat_db_dir
  - id: wdir
    type: Directory
    doc: "Output directory from extract_spacers (needs to exist); staged writable, results are added to it"
    inputBinding:
      position: 101
      prefix: --wdir
      valueFrom: $(self.basename)
  - id: min_n_spacers
    type:
      - 'null'
      - int
    doc: "To change the default cutoff on minimum number of distinct spacers required for an array to be retained (default: 5) - Note: SpacerExtractor has mostly been tested with this default parameter of 5, so lowering this cutoff should be considered experimental !!"
    inputBinding:
      position: 101
      prefix: --min_n_spacers
  - id: denoising_strict
    type:
      - 'null'
      - boolean
    doc: "Run a more aggressive denoising, will remove more singletons linked to sequencing errors but also more rare spacers mistakenly considered as sequencing errors (set expected error rate at 0.005)"
    inputBinding:
      position: 101
      prefix: --denoising_strict
  - id: denoising_very_strict
    type:
      - 'null'
      - boolean
    doc: "Run an even more aggressive denoising, will remove more singletons linked to sequencing errors but also more rare spacers mistakenly considered as sequencing errors (set expected error rate at 0.01)"
    inputBinding:
      position: 101
      prefix: --denoising_very_strict
  - id: custom_err_rate
    type:
      - 'null'
      - float
    doc: "To change the default sequencing error rate, used in the denoising process of repeats and spacer. This error rate should be low (< 0.1)"
    inputBinding:
      position: 101
      prefix: --custom_err_rate
  - id: n_threads
    type:
      - 'null'
      - int
    doc: "number of threads to use [default: 2]"
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: bbtools_memory
    type:
      - 'null'
      - string
    doc: "memory allocated to bbtools [default: 20g]"
    inputBinding:
      position: 101
      prefix: --bbtools_memory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Run in a more verbose mode for debugging / troubleshooting purposes"
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Run in a very quiet mode, will only show error/critical messages"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: force_rerun
    type:
      - 'null'
      - boolean
    doc: "If you want to force SpacerExtractor to recompute all the steps"
    inputBinding:
      position: 101
      prefix: --force_rerun
outputs:
  - id: wdir_output
    type: Directory
    doc: "The extract_spacers output directory with the high-quality spacer files added"
    outputBinding:
      glob: $(inputs.wdir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.wdir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0

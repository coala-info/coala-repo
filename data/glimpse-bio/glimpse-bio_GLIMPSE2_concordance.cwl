cwlVersion: v1.2
class: CommandLineTool
baseCommand: GLIMPSE2_concordance
label: glimpse-bio_GLIMPSE2_concordance
doc: "Check concordance of imputed data\n\nTool homepage: https://github.com/odelaneau/GLIMPSE"
inputs:
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed of the random number generator"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
  - id: input
    type: File
    doc: "File with four columns listing in order: regions frequencies validation and imputed dataset. For genome-wide concordance, add more lines specifying different chromosomes."
    inputBinding:
      position: 101
      prefix: --input
  - id: samples
    type:
      - 'null'
      - File
    doc: "List of samples to process, one sample ID per line"
    inputBinding:
      position: 101
      prefix: --samples
  - id: gt_val
    type:
      - 'null'
      - boolean
    doc: "Uses hard called genotypes rather than phread-scaled likelihoods for the validation dataset, reading them from FORMAT/GT field."
    inputBinding:
      position: 101
      prefix: --gt-val
  - id: gt_tar
    type:
      - 'null'
      - boolean
    doc: "Uses FORMAT/GT field to determine the best-guess genotype rather than the FORMAT/GP (default). FORMAT/DS are FORMAT/GP fields are still required for calibration and rsquared calculations."
    inputBinding:
      position: 101
      prefix: --gt-tar
  - id: af_tag
    type:
      - 'null'
      - string
    doc: "Allele frequency INFO tag to use for binning. By default the allele frequency is estimated from the INFO/AF tag."
    inputBinding:
      position: 101
      prefix: --af-tag
  - id: use_alt_af
    type:
      - 'null'
      - boolean
    doc: "If specified, the metrics work on the ALT allele frequency (range [0,1]), rather than minor allele frequency (range [0,0.5])."
    inputBinding:
      position: 101
      prefix: --use-alt-af
  - id: bins
    type:
      - 'null'
      - float[]
    doc: "Allele frequency bins used for rsquared computations. By default they should as MAF bins [0-0.5], while they should take the full range [0-1] if --use-ref-alt is used."
    inputBinding:
      position: 101
      prefix: --bins
  - id: ac_bins
    type:
      - 'null'
      - int[]
    doc: "User-defined allele count bins used for rsquared computations."
    inputBinding:
      position: 101
      prefix: --ac-bins
  - id: allele_counts
    type:
      - 'null'
      - boolean
    doc: "Default allele count bins used for rsquared computations. AN field must be defined in the frequency file."
    inputBinding:
      position: 101
      prefix: --allele-counts
  - id: min_val_gl
    type:
      - 'null'
      - float
    doc: "Minimum genotype likelihood probability P(G|R) in validation data [set to zero to have no filter of if using --gt-validation]"
    inputBinding:
      position: 101
      prefix: --min-val-gl
  - id: min_val_dp
    type:
      - 'null'
      - int
    doc: "Minimum coverage in validation data. If FORMAT/DP is missing and --minDP > 0, the program exits with an error. [set to zero to have no filter of if using --gt-validation]"
    inputBinding:
      position: 101
      prefix: --min-val-dp
  - id: min_tar_gp
    type:
      - 'null'
      - float
    doc: "Minimum GP probabilities to be used as a filter. By default it looks at the GP field to specify the filter, but will try to use FORMAT/PL if gt-tar option is specified. Leave empty if no filter is used."
    inputBinding:
      position: 101
      prefix: --min-tar-gp
  - id: out_r2_per_site
    type:
      - 'null'
      - boolean
    doc: "Output r2 at each site."
    inputBinding:
      position: 101
      prefix: --out-r2-per-site
  - id: out_rej_sites
    type:
      - 'null'
      - boolean
    doc: "Output sites where that cannot be used for the concordance."
    inputBinding:
      position: 101
      prefix: --out-rej-sites
  - id: out_conc_sites
    type:
      - 'null'
      - boolean
    doc: "Output sites where all target genotypes are concordant with the truth."
    inputBinding:
      position: 101
      prefix: --out-conc-sites
  - id: out_disc_sites
    type:
      - 'null'
      - boolean
    doc: "Output sites where at least one target genotype is diconcordant with the truth."
    inputBinding:
      position: 101
      prefix: --out-disc-sites
  - id: groups
    type:
      - 'null'
      - File
    doc: "Alternative to frequency bins: group bins are user defined, provided in a file."
    inputBinding:
      position: 101
      prefix: --groups
  - id: output_path
    type: string
    doc: "Prefix of the output files (extensions are automatically added)"
    inputBinding:
      position: 102
      prefix: --output
  - id: log_path
    type:
      - 'null'
      - string
    doc: "Log file"
    inputBinding:
      position: 101
      prefix: --log
  - id: input_files
    type:
      type: array
      items: File
    doc: The region, frequency, validation and imputed files named in the --input list, staged in the working directory
    secondaryFiles:
      - pattern: '.csi'
        required: false
      - pattern: '.tbi'
        required: false
outputs:
  - id: output
    type: File[]
    doc: Concordance result files (prefix plus extensions)
    outputBinding:
      glob: $(inputs.output_path).*
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3

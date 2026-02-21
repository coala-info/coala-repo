cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - impute
label: harpy_impute
doc: "Impute variant genotypes from alignments. Provide the parameter file followed
  by the input VCF and the input alignment files/directories (.bam) at the end of
  the command.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: parameters
    type: File
    doc: Parameter file (generate with harpy template)
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 2
  - id: inputs
    type:
      type: array
      items: File
    doc: Input alignment files/directories (.bam)
    inputBinding:
      position: 3
  - id: container
    type:
      - 'null'
      - boolean
    doc: Use a container instead of conda
    inputBinding:
      position: 104
      prefix: --container
  - id: extra_params
    type:
      - 'null'
      - string
    doc: Additional STITCH parameters, in quotes
    inputBinding:
      position: 104
      prefix: --extra-params
  - id: grid_size
    type:
      - 'null'
      - int
    doc: Perform imputation in windows of a specific size, instead of per-SNP
    default: 1
    inputBinding:
      position: 104
      prefix: --grid-size
  - id: hpc
    type:
      - 'null'
      - File
    doc: HPC submission YAML configuration file
    inputBinding:
      position: 104
      prefix: --hpc
  - id: quiet
    type:
      - 'null'
      - int
    doc: 0 all output, 1 progress bar, 2 no output
    inputBinding:
      position: 104
      prefix: --quiet
  - id: region
    type:
      - 'null'
      - string
    doc: Specific region to impute (contig:start-end-buffer)
    inputBinding:
      position: 104
      prefix: --region
  - id: skip_reports
    type:
      - 'null'
      - boolean
    doc: Don't generate HTML reports
    inputBinding:
      position: 104
      prefix: --skip-reports
  - id: snakemake
    type:
      - 'null'
      - string
    doc: Additional Snakemake parameters, in quotes
    inputBinding:
      position: 104
      prefix: --snakemake
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 4
    inputBinding:
      position: 104
      prefix: --threads
  - id: vcf_samples
    type:
      - 'null'
      - boolean
    doc: Use samples present in vcf file for imputation rather than those found in
      the inputs
    inputBinding:
      position: 104
      prefix: --vcf-samples
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory name
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2

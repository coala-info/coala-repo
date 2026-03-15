cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - impute
label: harpy_impute
doc: Impute variant genotypes from alignments. Provide the parameter file 
  followed by the input VCF and the input alignment files/directories (.bam) at 
  the end of the command.
inputs:
  - id: parameters
    type: File
    doc: Parameter file
    inputBinding:
      position: 1
  - id: vcf
    type:
      - 'null'
      - File
    doc: Input VCF file
    inputBinding:
      position: 2
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input alignment files/directories (.bam)
    inputBinding:
      position: 3
  - id: extra_params
    type:
      - 'null'
      - string
    doc: Additional STITCH parameters, in quotes
    inputBinding:
      position: 104
      prefix: --extra-params
  - id: region
    type:
      - 'null'
      - string
    doc: Specific region to impute (contig:start-end-buffer)
    inputBinding:
      position: 104
      prefix: --region
  - id: grid_size
    type:
      - 'null'
      - int
    doc: Perform imputation in windows of a specific size, instead of per-SNP
    inputBinding:
      position: 104
      prefix: --grid-size
  - id: vcf_samples
    type:
      - 'null'
      - boolean
    doc: Use samples present in vcf file for imputation rather than those found 
      in the inputs
    inputBinding:
      position: 104
      prefix: --vcf-samples
  - id: output_dir
    type: string
    doc: Output directory name
    inputBinding:
      position: 104
      prefix: --output-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 104
      prefix: --threads
  - id: container
    type:
      - 'null'
      - boolean
    doc: Use a container instead of conda
    inputBinding:
      position: 104
      prefix: --container
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
outputs:
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory name
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/

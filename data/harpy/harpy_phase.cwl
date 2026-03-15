cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - phase
label: harpy_phase
doc: Phase SNPs into haplotypes. Provide the vcf file followed by the input 
  alignment (.bam) files and/or directories.
inputs:
  - id: vcf
    type: File
    doc: The vcf file to phase
    inputBinding:
      position: 1
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input alignment (.bam) files and/or directories
    inputBinding:
      position: 2
  - id: extra_params
    type:
      - 'null'
      - string
    doc: Additional HapCut2 parameters, in quotes
    inputBinding:
      position: 103
      prefix: --extra-params
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to reference genome if wanting to also extract reads spanning 
      indels
    inputBinding:
      position: 103
      prefix: --reference
  - id: min_map_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for phasing
    inputBinding:
      position: 103
      prefix: --min-map-quality
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality for phasing
    inputBinding:
      position: 103
      prefix: --min-base-quality
  - id: molecule_distance
    type:
      - 'null'
      - int
    doc: Distance cutoff to split molecules (bp)
    inputBinding:
      position: 103
      prefix: --molecule-distance
  - id: prune_threshold
    type:
      - 'null'
      - int
    doc: PHRED-scale threshold (%) for pruning low-confidence SNPs (larger 
      prunes more.)
    inputBinding:
      position: 103
      prefix: --prune-threshold
  - id: unlinked
    type:
      - 'null'
      - boolean
    doc: Treat input data as not linked reads
    inputBinding:
      position: 103
      prefix: --unlinked
  - id: vcf_samples
    type:
      - 'null'
      - boolean
    doc: Use samples present in vcf file for phasing rather than those found in 
      the inputs
    inputBinding:
      position: 103
      prefix: --vcf-samples
  - id: output_dir
    type: string
    doc: Output directory name
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: container
    type:
      - 'null'
      - boolean
    doc: Use a container instead of conda
    inputBinding:
      position: 103
      prefix: --container
  - id: contigs
    type:
      - 'null'
      - File
    doc: File or list of contigs to plot
    inputBinding:
      position: 103
      prefix: --contigs
  - id: hpc
    type:
      - 'null'
      - File
    doc: HPC submission YAML configuration file
    inputBinding:
      position: 103
      prefix: --hpc
  - id: quiet
    type:
      - 'null'
      - int
    doc: 0 all output, 1 progress bar, 2 no output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: skip_reports
    type:
      - 'null'
      - boolean
    doc: Don't generate HTML reports
    inputBinding:
      position: 103
      prefix: --skip-reports
  - id: snakemake
    type:
      - 'null'
      - string
    doc: Additional Snakemake parameters, in quotes
    inputBinding:
      position: 103
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

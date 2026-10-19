cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - run-chip-pipeline
label: pypgx_run-chip-pipeline
doc: "Run genotyping pipeline for chip data.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: gene
    type: string
    doc: Target gene.
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Output directory.
    inputBinding:
      position: 2
  - id: variants
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: true
    doc: Input VCF file must be already BGZF compressed (.gz) and indexed (.tbi)
      to allow random access. Statistical haplotype phasing will be skipped if 
      input VCF is already fully phased.
    inputBinding:
      position: 3
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    inputBinding:
      position: 104
      prefix: --assembly
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified samples.
    inputBinding:
      position: 104
      prefix: --exclude
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if it already exists.
    inputBinding:
      position: 104
      prefix: --force
  - id: impute
    type:
      - 'null'
      - boolean
    doc: Perform imputation of missing genotypes.
    inputBinding:
      position: 104
      prefix: --impute
  - id: panel
    type:
      - 'null'
      - File
    doc: VCF file corresponding to a reference haplotype panel (compressed or 
      uncompressed). By default, the 1KGP panel in the pypgx-bundle directory 
      will be used.
    inputBinding:
      position: 104
      prefix: --panel
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which samples should be included for analysis by providing a 
      text file (.txt, .tsv, .csv, or .list) containing one sample per line. 
      Alternatively, you can provide a list of samples.
    inputBinding:
      position: 104
      prefix: --samples
  - id: pypgx_bundle
    type:
      - 'null'
      - Directory
    doc: 'Path to the pypgx-bundle directory (git clone of the version matching PyPGx). It is passed to the tool in the PYPGX_BUNDLE environment variable, because the default home directory location does not exist in the container.'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: PYPGX_BUNDLE
        envValue: '$(inputs.pypgx_bundle ? inputs.pypgx_bundle.path : "/pypgx-bundle")'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_run-chip-pipeline.out

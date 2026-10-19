cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - estimate-phase-beagle
label: pypgx_estimate-phase-beagle
doc: "Estimate haplotype phase of observed variants with the Beagle program.\n\nTool
  homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: imported_variants
    type: File
    doc: Input archive file with the semantic type VcfFrame[Imported]. The 'chr'
      prefix in contig names (e.g. 'chr1' vs. '1') will be automatically added 
      or removed as necessary to match the reference VCF's contig names.
    inputBinding:
      position: 1
  - id: phased_variants
    type: string
    doc: Output archive file with the semantic type VcfFrame[Phased].
    inputBinding:
      position: 2
  - id: impute
    type:
      - 'null'
      - boolean
    doc: Perform imputation of missing genotypes.
    inputBinding:
      position: 102
      prefix: --impute
  - id: panel
    type:
      - 'null'
      - File
    doc: VCF file (compressed or uncompressed) corresponding to a reference 
      haplotype panel. By default, the 1KGP panel in the pypgx-bundle directory 
      will be used.
    inputBinding:
      position: 102
      prefix: --panel
  - id: pypgx_bundle
    type:
      - 'null'
      - Directory
    doc: 'Path to the pypgx-bundle directory (git clone of the version matching PyPGx). It is passed to the tool in the PYPGX_BUNDLE environment variable, because the default home directory location does not exist in the container.'
outputs:
  - id: out_phased_variants
    type: File
    doc: Output archive file with the semantic type VcfFrame[Phased].
    outputBinding:
      glob: '$(inputs.phased_variants)'
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: PYPGX_BUNDLE
        envValue: '$(inputs.pypgx_bundle ? inputs.pypgx_bundle.path : "/pypgx-bundle")'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0

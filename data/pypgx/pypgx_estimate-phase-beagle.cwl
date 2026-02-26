cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx estimate-phase-beagle
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
outputs:
  - id: phased_variants
    type: File
    doc: Output archive file with the semantic type VcfFrame[Phased].
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_modfreqs
label: phast_modfreqs
doc: "Calculates and displays allele frequency information for a given set of sites.\n\
  \nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: input_file
    type: File
    doc: Input file containing site information (e.g., a VCF file).
    inputBinding:
      position: 1
  - id: include_missing
    type:
      - 'null'
      - boolean
    doc: Include sites with missing data in the analysis.
    inputBinding:
      position: 102
      prefix: --include-missing
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Maximum coverage allowed at a site.
    inputBinding:
      position: 102
      prefix: --max-coverage
  - id: min_allele_count
    type:
      - 'null'
      - int
    doc: Minimum number of alleles required to calculate frequency.
    inputBinding:
      position: 102
      prefix: --min-allele-count
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage required at a site.
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: reference_allele
    type:
      - 'null'
      - string
    doc: Specify the reference allele.
    inputBinding:
      position: 102
      prefix: --reference-allele
  - id: sites
    type:
      - 'null'
      - string
    doc: Comma-separated list of site identifiers to include.
    inputBinding:
      position: 102
      prefix: --sites
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for the sliding window.
    inputBinding:
      position: 102
      prefix: --step-size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the sliding window for calculating frequencies.
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File to write the allele frequency information to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0

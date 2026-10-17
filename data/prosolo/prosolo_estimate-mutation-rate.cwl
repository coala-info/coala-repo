cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prosolo
  - estimate-mutation-rate
label: prosolo_estimate-mutation-rate
doc: "Estimate the effective mutation rate of a tumor sample from a VCF/BCF with candidate
  variants from STDIN.\n\nTool homepage: https://github.com/PROSIC/prosolo/tree/v0.2.0"
inputs:
  - id: candidates
    type: File
    doc: CSV file with a header line and one allele frequency per row (read from
      STDIN; the program parses it as CSV, despite the help text saying VCF/BCF).
  - id: fit_file
    type:
      - 'null'
      - string
    doc: Path to file that will contain observations and the parameters of the 
      fitted model as JSON.
    inputBinding:
      position: 101
      prefix: --fit
  - id: max_af
    type:
      - 'null'
      - float
    doc: Maximum allele frequency to consider
    inputBinding:
      position: 101
      prefix: --max-af
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum allele frequency to consider
    inputBinding:
      position: 101
      prefix: --min-af
outputs:
  - id: fit_file_out
    type:
      - 'null'
      - File
    doc: JSON file with the observations and the fitted model parameters.
    outputBinding:
      glob: $(inputs.fit_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
stdin: $(inputs.candidates.path)
stdout: prosolo_estimate-mutation-rate.out

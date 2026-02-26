cwlVersion: v1.2
class: CommandLineTool
baseCommand: calisp
label: calisp
doc: "Calisp.py. (C) Marc Strous, Xiaoli Dong and Manuel Kleiner, 2018, 2021\n\nTool
  homepage: https://github.com/kinestetika/Calisp"
inputs:
  - id: bin_delimiter
    type:
      - 'null'
      - string
    doc: For metagenomic data, the delimiter that separates the bin ID from the 
      protein ID [default "_"]. Use "--" to ignore bin ID entirely.
    default: _
    inputBinding:
      position: 101
      prefix: --bin_delimiter
  - id: compute_clumps
    type:
      - 'null'
      - boolean
    doc: To compute clumpiness of carbon assimilation. Only use when samples are
      labeled tosaturation. Estimation of clumpiness takes much additional time.
    inputBinding:
      position: 101
      prefix: --compute_clumps
  - id: isotope
    type:
      - 'null'
      - string
    doc: 'The target isotope. Default: 13C'
    default: 13C
    inputBinding:
      position: 101
      prefix: --isotope
  - id: isotope_abundance_matrix
    type:
      - 'null'
      - File
    doc: To use a custom isotope abundance matrix. This is useful when 
      estimating abundances of less abundant, non-C isotopes (e.g. H, O, N, S)
    inputBinding:
      position: 101
      prefix: --isotope_abundance_matrix
  - id: mass_accuracy
    type:
      - 'null'
      - float
    doc: The maximum mass difference between theoretical mass and experimental 
      mass of a peptide
    inputBinding:
      position: 101
      prefix: --mass_accuracy
  - id: peptide_file
    type: File
    doc: Search-engine-generated [.mzID] or [.target-peptide-spectrum-match] 
      file or folder with these files.
    inputBinding:
      position: 101
      prefix: --peptide_file
  - id: spectrum_file
    type: File
    doc: '[.mzML] file or folder with [.mzML] file(s).'
    inputBinding:
      position: 101
      prefix: --spectrum_file
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of (virtual) processors that calisp will use (default 4)
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - Directory
    doc: The name of the folder the output gets written to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calisp:3.1.4--pyhdfd78af_0

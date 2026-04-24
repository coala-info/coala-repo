cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - olivar
  - tiling
label: olivar_tiling
doc: "Primer design for tiling experiments.\n\nTool homepage: https://gitlab.com/treangenlab/olivar"
inputs:
  - id: olvr_path
    type: File
    doc: Path to the Olivar reference file (.olvr), or the directory of 
      reference files for multiple targets
    inputBinding:
      position: 1
  - id: check_var
    type:
      - 'null'
      - boolean
    doc: Filter out primer candidates with variations within 5nt of 3' end. NOT 
      recommended when a lot of variations are provided, since this would 
      significantly reduce the number of primer candidates.
    inputBinding:
      position: 102
      prefix: --check-var
  - id: deg
    type:
      - 'null'
      - boolean
    doc: Control whether use degenerate mode or not.
    inputBinding:
      position: 102
      prefix: --deg
  - id: dg_max
    type:
      - 'null'
      - float
    doc: Maximum free energy change of a primer in kcal/mol
    inputBinding:
      position: 102
      prefix: --dg-max
  - id: fp_prefix
    type:
      - 'null'
      - string
    doc: Prefix of forward primer.
    inputBinding:
      position: 102
      prefix: --fp-prefix
  - id: iter_mul
    type:
      - 'null'
      - int
    doc: Multiplier of iterations during PDR optimization.
    inputBinding:
      position: 102
      prefix: --iterMul
  - id: max_amp_len
    type:
      - 'null'
      - int
    doc: Maximum amplicon length
    inputBinding:
      position: 102
      prefix: --max-amp-len
  - id: max_gc
    type:
      - 'null'
      - float
    doc: Maximum GC content of a primer
    inputBinding:
      position: 102
      prefix: --max-gc
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of a primer
    inputBinding:
      position: 102
      prefix: --max-len
  - id: min_amp_len
    type:
      - 'null'
      - int
    doc: Minimum amplicon length. 0.9*{max-amp-len} if not provided. Minimum 
      120.
    inputBinding:
      position: 102
      prefix: --min-amp-len
  - id: min_complexity
    type:
      - 'null'
      - float
    doc: Minimum sequence complexity of a primer
    inputBinding:
      position: 102
      prefix: --min-complexity
  - id: min_gc
    type:
      - 'null'
      - float
    doc: Minimum GC content of a primer
    inputBinding:
      position: 102
      prefix: --min-gc
  - id: rp_prefix
    type:
      - 'null'
      - string
    doc: Prefix of reverse primer.
    inputBinding:
      position: 102
      prefix: --rp-prefix
  - id: salinity
    type:
      - 'null'
      - float
    doc: Concentration of monovalent ions in units of molar
    inputBinding:
      position: 102
      prefix: --salinity
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for optimizing primer design regions and primer dimer
    inputBinding:
      position: 102
      prefix: --seed
  - id: temperature
    type:
      - 'null'
      - float
    doc: PCR annealing temperature
    inputBinding:
      position: 102
      prefix: --temperature
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: title
    type:
      - 'null'
      - string
    doc: Name of design
    inputBinding:
      position: 102
      prefix: --title
  - id: w_combi
    type:
      - 'null'
      - float
    doc: Weight for combinations
    inputBinding:
      position: 102
      prefix: --w-combi
  - id: w_egc
    type:
      - 'null'
      - float
    doc: Weight for extreme GC content
    inputBinding:
      position: 102
      prefix: --w-egc
  - id: w_lc
    type:
      - 'null'
      - float
    doc: Weight for low sequence complexity
    inputBinding:
      position: 102
      prefix: --w-lc
  - id: w_ns
    type:
      - 'null'
      - float
    doc: Weight for non-specificity
    inputBinding:
      position: 102
      prefix: --w-ns
  - id: w_sensi
    type:
      - 'null'
      - float
    doc: Weight for sensitivity
    inputBinding:
      position: 102
      prefix: --w-sensi
  - id: w_var
    type:
      - 'null'
      - float
    doc: Weight for variations
    inputBinding:
      position: 102
      prefix: --w-var
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output path (output to current directory by default).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0

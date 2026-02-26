cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - easypqp
  - convertpsm
label: easypqp_convertpsm
doc: "Convert psm.tsv files for EasyPQP\n\nTool homepage: https://github.com/grosenberger/easypqp"
inputs:
  - id: decoy_prefix
    type: string
    doc: Database decoy prefix (required)
    default: rev_
    inputBinding:
      position: 101
      prefix: --decoy_prefix
  - id: enable_massdiff
    type:
      - 'null'
      - boolean
    doc: Enable mapping of mass differences reported by legacy search engines.
    inputBinding:
      position: 101
      prefix: --enable_massdiff
  - id: enable_specific_losses
    type:
      - 'null'
      - boolean
    doc: Enable specific fragment ion losses.
    inputBinding:
      position: 101
      prefix: --enable_specific_losses
  - id: enable_unannotated
    type:
      - 'null'
      - boolean
    doc: Enable mapping of unannotated delta masses.
    inputBinding:
      position: 101
      prefix: --enable_unannotated
  - id: enable_unspecific_losses
    type:
      - 'null'
      - boolean
    doc: Enable unspecific fragment ion losses.
    inputBinding:
      position: 101
      prefix: --enable_unspecific_losses
  - id: exclude_range
    type:
      - 'null'
      - string
    doc: massdiff in this range will not be mapped to UniMod.
    default: -1.5,3.5
    inputBinding:
      position: 101
      prefix: --exclude-range
  - id: fragment_charges
    type:
      - 'null'
      - string
    doc: Allowed fragment ion charges.
    default: '[1,2,3,4]'
    inputBinding:
      position: 101
      prefix: --fragment_charges
  - id: fragment_types
    type:
      - 'null'
      - string
    doc: Allowed fragment ion types (a,b,c,x,y,z).
    default: "['b','y']"
    inputBinding:
      position: 101
      prefix: --fragment_types
  - id: ignore_unannotated
    type:
      - 'null'
      - boolean
    doc: Remove PSMs with unannotated delta masses but proceed with all other 
      PSMs.
    inputBinding:
      position: 101
      prefix: --ignore_unannotated
  - id: labile_mods
    type:
      - 'null'
      - string
    doc: 'Adjust fragment masses of labile modifications. Supported options: oglyc,
      nglyc, nglyc+ (includes HexNAc remainder ions)'
    default: ''
    inputBinding:
      position: 101
      prefix: --labile_mods
  - id: max_delta_ppm
    type:
      - 'null'
      - float
    doc: Maximum delta mass (PPM) for annotation.
    default: 15
    inputBinding:
      position: 101
      prefix: --max_delta_ppm
  - id: max_delta_unimod
    type:
      - 'null'
      - float
    doc: Maximum delta mass (Dalton) for UniMod annotation.
    default: 0.02
    inputBinding:
      position: 101
      prefix: --max_delta_unimod
  - id: max_glycan_q
    type:
      - 'null'
      - float
    doc: Maximum glycan q-value to include a PSM in the library
    default: 1
    inputBinding:
      position: 101
      prefix: --max_glycan_q
  - id: max_psm_pep
    type:
      - 'null'
      - float
    doc: Maximum posterior error probability (PEP) for a PSM
    default: 1
    inputBinding:
      position: 101
      prefix: --max_psm_pep
  - id: no_enable_massdiff
    type:
      - 'null'
      - boolean
    doc: Enable mapping of mass differences reported by legacy search engines.
    inputBinding:
      position: 101
      prefix: --no-enable_massdiff
  - id: no_enable_specific_losses
    type:
      - 'null'
      - boolean
    doc: Enable specific fragment ion losses.
    inputBinding:
      position: 101
      prefix: --no-enable_specific_losses
  - id: no_enable_unannotated
    type:
      - 'null'
      - boolean
    doc: Enable mapping of unannotated delta masses.
    inputBinding:
      position: 101
      prefix: --no-enable_unannotated
  - id: no_enable_unspecific_losses
    type:
      - 'null'
      - boolean
    doc: Enable unspecific fragment ion losses.
    inputBinding:
      position: 101
      prefix: --no-enable_unspecific_losses
  - id: no_ignore_unannotated
    type:
      - 'null'
      - boolean
    doc: Remove PSMs with unannotated delta masses but proceed with all other 
      PSMs.
    inputBinding:
      position: 101
      prefix: --no-ignore_unannotated
  - id: precision_digits
    type:
      - 'null'
      - int
    doc: Precision (number of digits) for the product m/z reported by the 
      theoretical library generation step. This should match the precision of 
      the downstream consumer of the spectral library. Lowering this number will
      collapse (more) identical fragment ions of the same precursor to a single 
      value.
    default: 6
    inputBinding:
      position: 101
      prefix: --precision_digits
  - id: psm
    type:
      type: array
      items: File
    doc: The input psm.tsv file or a list of psm.tsv files.
    inputBinding:
      position: 101
      prefix: --psm
  - id: spectra
    type:
      type: array
      items: File
    doc: The input mzXML or MGF (timsTOF only) file.
    inputBinding:
      position: 101
      prefix: --spectra
  - id: unimod
    type:
      - 'null'
      - File
    doc: The input UniMod XML file.
    inputBinding:
      position: 101
      prefix: --unimod
outputs:
  - id: psms
    type:
      - 'null'
      - File
    doc: Output PSMs file.
    outputBinding:
      glob: $(inputs.psms)
  - id: peaks
    type:
      - 'null'
      - File
    doc: Output peaks file.
    outputBinding:
      glob: $(inputs.peaks)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - ptmprophet
label: philosopher_ptmprophet
doc: "PTM site localization\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: autodirect
    type:
      - 'null'
      - boolean
    doc: "use direct evidence when the lability is high, use in combination with LABILITY"
    inputBinding:
      position: 100
      prefix: --autodirect
  - id: cions
    type:
      - 'null'
      - string
    doc: "use specified C-term ions, separate multiple ions by commas (default: y for CID, z for ETD)"
    inputBinding:
      position: 100
      prefix: --cions
  - id: direct
    type:
      - 'null'
      - boolean
    doc: "use only direct evidence for evaluating PTM site probabilities"
    inputBinding:
      position: 100
      prefix: --direct
  - id: em
    type:
      - 'null'
      - int
    doc: "set EM models to 0 (no EM), 1 (Intensity EM Model Applied) or 2 (Intensity and Matched Peaks EM Models Applied)"
    inputBinding:
      position: 100
      prefix: --em
  - id: excludemassdiffmax
    type:
      - 'null'
      - float
    doc: "Maximun mass difference excluded for MASSDIFFFMODE analysis"
    inputBinding:
      position: 100
      prefix: --excludemassdiffmax
  - id: excludemassdiffmin
    type:
      - 'null'
      - float
    doc: "Minimum mass difference excluded for MASSDIFFFMODE analysis"
    inputBinding:
      position: 100
      prefix: --excludemassdiffmin
  - id: fragppmtol
    type:
      - 'null'
      - int
    doc: "when computing PSM-specific mass_offset and mass_tolerance, use specified default +/- MS2 mz tolerance on fragment ions"
    inputBinding:
      position: 100
      prefix: --fragppmtol
  - id: ifrags
    type:
      - 'null'
      - boolean
    doc: "use internal fragments for localization"
    inputBinding:
      position: 100
      prefix: --ifrags
  - id: keepold
    type:
      - 'null'
      - boolean
    doc: "retain old PTMProphet results in the pepXML file"
    inputBinding:
      position: 100
      prefix: --keepold
  - id: lability
    type:
      - 'null'
      - boolean
    doc: "compute Lability of PTMs"
    inputBinding:
      position: 100
      prefix: --lability
  - id: massdiffmode
    type:
      - 'null'
      - boolean
    doc: "use the mass difference and localize"
    inputBinding:
      position: 100
      prefix: --massdiffmode
  - id: massoffset
    type:
      - 'null'
      - int
    doc: "adjust the massdiff by offset <number>"
    inputBinding:
      position: 100
      prefix: --massoffset
  - id: maxfragz
    type:
      - 'null'
      - int
    doc: "limit maximum fragment charge (default: 0=precursor charge, negative values subtract from precursor charge)"
    inputBinding:
      position: 100
      prefix: --maxfragz
  - id: maxthreads
    type:
      - 'null'
      - int
    doc: "use specified number of threads for processing"
    inputBinding:
      position: 100
      prefix: --maxthreads
  - id: mino
    type:
      - 'null'
      - int
    doc: "use specified number of pseudo-counts when computing Oscore"
    inputBinding:
      position: 100
      prefix: --mino
  - id: minprob
    type:
      - 'null'
      - float
    doc: "use specified minimum probability to evaluate peptides"
    inputBinding:
      position: 100
      prefix: --minprob
  - id: mods
    type:
      - 'null'
      - string
    doc: "<amino acids, n, or c>:<mass_shift>:<neut_loss1>:...:<neut_lossN>,<amino acids, n, or c>:<mass_shift>:<neut_loss1>:...:<neut_lossN> (overrides the modifications from the interact.pep.xml file)"
    inputBinding:
      position: 100
      prefix: --mods
  - id: nions
    type:
      - 'null'
      - string
    doc: "use specified N-term ions, separate multiple ions by commas (default: a,b for CID, c for ETD)"
    inputBinding:
      position: 100
      prefix: --nions
  - id: nominofactor
    type:
      - 'null'
      - boolean
    doc: "disable MINO factor correction when MINO= is set greater than 0 (default: apply MINO factor correction)"
    inputBinding:
      position: 100
      prefix: --nominofactor
  - id: output
    type:
      - 'null'
      - string
    doc: "output name prefix"
    inputBinding:
      position: 100
      prefix: --output
  - id: ppmtol
    type:
      - 'null'
      - float
    doc: "use specified +/- MS1 ppm tolerance on peptides which may have a slight offset depending on search parameters"
    inputBinding:
      position: 100
      prefix: --ppmtol
  - id: static
    type:
      - 'null'
      - boolean
    doc: "use static fragppmtol for all PSMs instead of dynamically estimated offsets and tolerances"
    inputBinding:
      position: 100
      prefix: --static
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "produce Warnings to help troubleshoot potential PTM shuffling or mass difference issues"
    inputBinding:
      position: 100
      prefix: --verbose
  - id: pepxml
    type:
      type: array
      items: File
    doc: "PeptideProphet pepXML files"
    inputBinding:
      position: 200
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: ptm_pepxml
    type:
      - 'null'
      - type: array
        items: File
    doc: "pepXML files with PTM localization"
    outputBinding:
      glob: '*.pep.xml'
  - id: workspace_out
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (.meta folder) after this step; pass it to the next step"
    outputBinding:
      glob: .meta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .meta
        entry: $(inputs.workspace)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_ptmprophet.out

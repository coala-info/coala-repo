cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi_mass_analysis
label: mimi_mimi_mass_analysis
doc: "Molecular Isotope Mass Identifier: match peaks of mass spectra to theoretical masses and verify\
  \ isotope patterns.\n\nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs:
  - id: ppm
    type: double
    doc: Parts per million for the monoisotopic mass of the chemical formula.
    inputBinding:
      position: 101
      prefix: --ppm
  - id: vp_ppm
    type: double
    doc: Parts per million for verification of isotopes.
    inputBinding:
      position: 101
      prefix: -vp
  - id: iso_validation
    type:
      - 'null'
      - boolean
    doc: Include isotope validation counts in output (adds an iso_valid column).
    inputBinding:
      position: 101
      prefix: --iso-validation
  - id: cache
    type:
      type: array
      items: File
    doc: Binary DB input file(s) written by mimi_cache_create (.pkl). The tool adds the .pkl extension
      itself, so the CWL passes the paths without it.
    inputBinding:
      position: 101
      prefix: --cache
      valueFrom: $(self.map(function(f){return f.path.replace(/\.pkl$/, '');}))
  - id: sample
    type:
      type: array
      items: File
    doc: 'Input sample file(s): peak lists with m/z, intensity and resolution columns.'
    inputBinding:
      position: 101
      prefix: --sample
  - id: output
    type: string
    doc: Output file.
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: results
    type: File
    doc: Tab-delimited results.
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
    doc: Standard output.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
stdout: mimi_mimi_mass_analysis.out

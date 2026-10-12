cwlVersion: v1.2
class: CommandLineTool
baseCommand: msgf2pin
label: percolator_msgf2pin
doc: "Convert MS-GF+ MzIdentML results (target and decoy) to the Percolator tab-delimited input format (pin).\n\nTool homepage: https://github.com/percolator/percolator"
inputs:
  - id: target_file
    type: File
    doc: MzIdentML file of the MS-GF+ target search. A meta file listing several files, one path per line, is also accepted.
    inputBinding:
      position: 200
  - id: decoy_file
    type: File
    doc: MzIdentML file of the MS-GF+ decoy search. A meta file listing several files, one path per line, is also accepted.
    inputBinding:
      position: 201
  - id: aa_freq
    type:
      - 'null'
      - boolean
    doc: Calculate amino acid frequency features
    inputBinding:
      position: 101
      prefix: --aa-freq
  - id: cleavages
    type:
      - 'null'
      - int
    doc: Number of allowed miss cleavages used in the search engine (default 0)
      (only valid when using option --databases)
    inputBinding:
      position: 101
      prefix: --cleavages
  - id: databases
    type:
      - 'null'
      - type: array
        items: File
    doc: Fasta database(s) used in the search, target first and optionally decoy
      (adds the proteins to the generated pin file)
    inputBinding:
      position: 101
      prefix: --databases
      itemSeparator: ','
  - id: enzyme
    type:
      - 'null'
      - string
    doc: 'Type of enzyme: no_enzyme, elastase, pepsin, proteinasek, thermolysin,
      chymotrypsin, lys-n, lys-c, arg-c, asp-n, glu-c or trypsin (default trypsin)'
    inputBinding:
      position: 101
      prefix: --enzyme
  - id: id_with_exp_mass
    type:
      - 'null'
      - boolean
    doc: Include experimental mass in PSMid for easier correlation with search
      engine results (experimental feature)
    inputBinding:
      position: 101
      prefix: --id-with-exp-mass
  - id: isotope
    type:
      - 'null'
      - boolean
    doc: Mass difference calculated to closest isotope mass rather than to the
      average mass
    inputBinding:
      position: 101
      prefix: --isotope
  - id: matches
    type:
      - 'null'
      - int
    doc: Maximal number of matches to take in consideration per spectrum
    inputBinding:
      position: 101
      prefix: --matches
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum peptide length allowed used in the search engine (default 40)
      (only valid when using option --databases)
    inputBinding:
      position: 101
      prefix: --max-length
  - id: max_mass
    type:
      - 'null'
      - int
    doc: Maximum peptide mass allowed used in the search engine (default 6000)
      (only valid when using option --databases)
    inputBinding:
      position: 101
      prefix: --max-mass
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum peptide length allowed used in the search engine (default 6)
      (only valid when using option --databases)
    inputBinding:
      position: 101
      prefix: --min-length
  - id: min_mass
    type:
      - 'null'
      - int
    doc: Minimum peptide mass allowed used in the search engine (default 400)
      (only valid when using option --databases)
    inputBinding:
      position: 101
      prefix: --min-mass
  - id: ms2_file
    type:
      - 'null'
      - File
    doc: File containing spectra and retention time (mzXML, MS2 or compressed MS2)
    inputBinding:
      position: 101
      prefix: --ms2-file
  - id: output_xml_stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout in the (deprecated) pin-xml format
    inputBinding:
      position: 101
      prefix: --outputXMLstdout
  - id: pattern
    type:
      - 'null'
      - string
    doc: Pattern used to identify the decoy PSMs (default "random")
    inputBinding:
      position: 101
      prefix: --pattern
  - id: pngase_f
    type:
      - 'null'
      - boolean
    doc: Calculate feature based on N-linked glycosylation pattern resulting from
      a PNGaseF treatment (N[*].[ST])
    inputBinding:
      position: 101
      prefix: --PNGaseF
  - id: psm_annotation
    type:
      - 'null'
      - string
    doc: An annotation scheme used to convert the PSMs from the search, e.g.
      "*:21:#:28"
    inputBinding:
      position: 101
      prefix: --psm-annotation
  - id: ptm
    type:
      - 'null'
      - boolean
    doc: Calculate feature for number of post-translational modifications
    inputBinding:
      position: 101
      prefix: --PTM
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbosity of output: 0=no processing info, 5=all, default is 2'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_tab_path
    type:
      - 'null'
      - string
    doc: Save output in a tab delimited file
    inputBinding:
      position: 102
      prefix: --outputTab
  - id: output_xml_path
    type:
      - 'null'
      - string
    doc: Save output in the (deprecated) pin-xml format file
    inputBinding:
      position: 103
      prefix: --outputXML
outputs:
  - id: output_tab
    type:
      - 'null'
      - File
    doc: Tab delimited pin file
    outputBinding:
      glob: $(inputs.output_tab_path)
  - id: output_xml
    type:
      - 'null'
      - File
    doc: Pin-xml file
    outputBinding:
      glob: $(inputs.output_xml_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/percolator:3.7.1--h3b5f4bd_2
stdout: percolator_msgf2pin.out

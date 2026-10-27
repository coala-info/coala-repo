cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtandem
label: xtandem
doc: "X! TANDEM Vengeance (2015.12.15.2): searches peptide tandem mass spectra against
  a protein sequence database. All search settings, the spectrum file, the taxonomy
  list and the output path are set in the XML input file.\n\nTool homepage: https://github.com/bspratt/xtandem-g"
inputs:
  - id: filename
    type: File
    doc: any valid path to an XML input file
    inputBinding:
      position: 1
  - id: referenced_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the XML input file (spectrum files, taxonomy XML, FASTA
      databases, default parameter files). They are staged in the working
      directory, so the XML input file must refer to them by file name only.
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.referenced_files ? inputs.referenced_files : [])'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_files
    type:
      type: array
      items: File
    doc: Result files written by the search (the output path set in the XML input
      file).
    outputBinding:
      glob: '*'
      outputEval: |
        ${
          var skip = {};
          skip[inputs.filename.basename] = 1;
          skip["xtandem.out"] = 1;
          (inputs.referenced_files || []).forEach(function (f) { skip[f.basename] = 1; });
          return self.filter(function (f) { return f.class == "File" && !skip[f.basename]; });
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtandem:15.12.15.2--0
stdout: xtandem.out

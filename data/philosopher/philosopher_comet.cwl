cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - comet
label: philosopher_comet
doc: "Peptide spectrum matching with Comet\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: noindex
    type:
      - 'null'
      - boolean
    doc: "skip raw file indexing"
    inputBinding:
      position: 100
      prefix: --noindex
  - id: param
    type:
      - 'null'
      - File
    doc: "comet parameter file"
    inputBinding:
      position: 100
      prefix: --param
      valueFrom: $(self.basename)
  - id: print
    type:
      - 'null'
      - boolean
    doc: "print a comet.params file"
    inputBinding:
      position: 100
      prefix: --print
  - id: spectra
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input spectrum files (mzML, mzXML or raw) to search; they are staged in the working directory and the pepXML result is written beside them"
    inputBinding:
      position: 200
      valueFrom: '${ return self.map(function(f) { return f.basename; }); }'
  - id: database_file
    type:
      - 'null'
      - File
    doc: "Target-decoy FASTA database named in database_name of the parameter file; it is staged in the working directory, so write the bare file name in the parameter file"
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pepxml
    type:
      - 'null'
      - type: array
        items: File
    doc: "Search results in pepXML format"
    outputBinding:
      glob: '*.pep.xml'
  - id: params_file
    type:
      - 'null'
      - File
    doc: "Parameter file written by --print (comet.params)"
    outputBinding:
      glob: 'comet.params'
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
      - '${ return inputs.param ? [inputs.param] : []; }'
      - '${ return inputs.database_file ? [inputs.database_file] : []; }'
      - '${ return inputs.spectra ? inputs.spectra : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_comet.out

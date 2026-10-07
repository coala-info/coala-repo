cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - eval
label: deepac_eval
doc: "Evaluate deep-AC models.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: ens_config
    type:
      - 'null'
      - File
    loadContents: true
    doc: Simple ensemble evaluation.
    inputBinding:
      position: 101
      prefix: --ensemble
  - id: reads_config
    type:
      - 'null'
      - File
    loadContents: true
    doc: Read-wise evaluation.
    inputBinding:
      position: 101
      prefix: --reads
  - id: species_config
    type:
      - 'null'
      - File
    loadContents: true
    doc: Species-wise evaluation.
    inputBinding:
      position: 101
      prefix: --species
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Models, data, labels and predictions named in the config file; staged 
      in the working directory so the relative names in the config resolve.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results
    type:
      type: array
      items: File
    doc: Metrics (.csv), plots (.png) and predictions (.npy) written with the 
      RunName prefix of the config file
    outputBinding:
      glob: |-
        ${
          var c = inputs.reads_config || inputs.species_config || inputs.ens_config;
          var m = c.contents.match(/^\s*RunName\s*=\s*(\S+)/m);
          var p = m[1];
          return [p + "*-metrics.csv", p + "*.png", p + "-e*-predictions-*.npy", p + "-predictions-*.npy"];
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_eval.out

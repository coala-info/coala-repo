cwlVersion: v1.2
class: CommandLineTool
baseCommand: CurveCurator
label: curve-curator_CurveCurator
doc: "Complete analysis pipeline for dose-response curves including fitting, filtering,
  and visualization. FPB-2024\n\nTool homepage: https://github.com/kusterlab/curve_curator"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [inputs.parameter_file];
        if (inputs.data_files) { l = l.concat(inputs.data_files); }
        return l;
      }
inputs:
  - id: parameter_file
    type: File
    doc: The config.toml or batch.txt file to run the pipeline. Paths inside it
      are relative to this file, so input files named in it must be given in 
      data_files.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data files (and toml files of a batch) named in the parameter file; 
      staged beside it so its relative paths resolve.
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Run a batch process with a file containing all the parameter file 
      paths.
    inputBinding:
      position: 102
      prefix: --batch
  - id: fdr
    type:
      - 'null'
      - boolean
    doc: Estimate FDR based on target decoy approach. Estimating the FDR will 
      double the run time.
    inputBinding:
      position: 102
      prefix: --fdr
  - id: mad
    type:
      - 'null'
      - boolean
    doc: Perform the medium absolute deviation (MAD) analysis to detect outliers
    inputBinding:
      position: 102
      prefix: --mad
  - id: random
    type:
      - 'null'
      - int
    doc: Run the pipeline with <N> random values for H0 simulation.
    inputBinding:
      position: 102
      prefix: --random
outputs:
  - id: curves
    type:
      - 'null'
      - type: array
        items: File
    doc: Curve fit result tables (curves.txt, decoys.txt, fdr.txt, mad.txt or 
      the names set in the parameter file)
    outputBinding:
      glob:
        - curves*.txt
        - decoys*.txt
        - fdr*.txt
        - mad*.txt
  - id: dashboard
    type:
      - 'null'
      - type: array
        items: File
    doc: Interactive HTML dashboard(s)
    outputBinding:
      glob: '*.html'
  - id: log
    type:
      - 'null'
      - type: array
        items: File
    doc: CurveCurator log file
    outputBinding:
      glob: '*.log'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curve-curator:0.6.0--pyhdfd78af_0
stdout: curve-curator_CurveCurator.out

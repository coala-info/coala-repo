cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - relax
label: hyphy_relax
doc: "Available analysis command line options\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of threads to use (HyPhy CPU= argument).
    inputBinding:
      position: 100
      prefix: CPU=
      separate: false
  - id: alignment
    type:
      - 'null'
      - File
    doc: An in-frame codon alignment in one of the formats supported by HyPhy
    inputBinding:
      position: 101
      prefix: --alignment
  - id: code
    type:
      - 'null'
      - string
    doc: Which genetic code should be used
    inputBinding:
      position: 101
      prefix: --code
  - id: filelist
    type:
      - 'null'
      - File
    doc: A line list of file paths for the alignments to include in this 
      analysis
    inputBinding:
      position: 101
      prefix: --filelist
  - id: filelist_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Alignment files named in the filelist; staged in the working directory 
      so that the names in the filelist resolve.
  - id: grid_size
    type:
      - 'null'
      - int
    doc: The number of points in the initial distributional guess for likelihood
      fitting
    inputBinding:
      position: 101
      prefix: --grid-size
  - id: intermediate_fits
    type:
      - 'null'
      - string
    doc: Use/save parameter estimates from 'initial-guess' model fits to a JSON 
      file (default is not to save)
    inputBinding:
      position: 101
      prefix: --intermediate-fits
      valueFrom: "$(self.charAt(0) == '/' ? self : runtime.outdir + '/' + self)"
  - id: kill_zero_lengths
    type:
      - 'null'
      - string
    doc: Automatically delete internal zero-length branches for computational 
      efficiency (will not affect results otherwise)
    inputBinding:
      position: 101
      prefix: --kill-zero-lengths
  - id: mode
    type:
      - 'null'
      - string
    doc: Run mode
    inputBinding:
      position: 101
      prefix: --mode
  - id: models
    type:
      - 'null'
      - string
    doc: Which version of the test to run (All or Minimal)
    inputBinding:
      position: 101
      prefix: --models
  - id: multiple_files
    type:
      - 'null'
      - string
    doc: Use multiple files as input
    inputBinding:
      position: 101
      prefix: --multiple-files
  - id: multiple_hits
    type:
      - 'null'
      - string
    doc: Include support for multiple nucleotide substitutions
    inputBinding:
      position: 101
      prefix: --multiple-hits
  - id: rates
    type:
      - 'null'
      - int
    doc: The number omega rate classes to include in the model [2-10, default 3]
    inputBinding:
      position: 101
      prefix: --rates
  - id: reference
    type:
      - 'null'
      - string
    doc: Branches to use as the reference set
    inputBinding:
      position: 101
      prefix: --reference
  - id: reference_group
    type:
      - 'null'
      - string
    doc: Branches to use as the reference group
    inputBinding:
      position: 101
      prefix: --reference-group
  - id: save_fit
    type:
      - 'null'
      - string
    doc: Save RELAX alternative model fit to this file (default is not to save)
    inputBinding:
      position: 101
      prefix: --save-fit
      valueFrom: "$(self.charAt(0) == '/' ? self : runtime.outdir + '/' + self)"
  - id: srv
    type:
      - 'null'
      - string
    doc: Include synonymous rate variation
    inputBinding:
      position: 101
      prefix: --srv
  - id: starting_points
    type:
      - 'null'
      - int
    doc: The number of initial random guesses to seed rate values optimization
    inputBinding:
      position: 101
      prefix: --starting-points
  - id: syn_rates
    type:
      - 'null'
      - int
    doc: The number alpha rate classes to include in the model [1-10, default 3]
    inputBinding:
      position: 101
      prefix: --syn-rates
  - id: test
    type:
      - 'null'
      - string
    doc: Branches to use as the test set
    inputBinding:
      position: 101
      prefix: --test
  - id: tree
    type:
      - 'null'
      - File
    doc: A phylogenetic tree (optionally annotated with {})
    inputBinding:
      position: 101
      prefix: --tree
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write the resulting JSON to this file (default is to save to the same 
      path as the alignment file + 'RELAX.json')
    outputBinding:
      glob: $(inputs.output_path)
  - id: intermediate_fits_file
    type:
      - 'null'
      - File
    doc: Parameter estimates from the initial-guess model fits (written to the 
      --intermediate-fits path)
    outputBinding:
      glob: $(inputs.intermediate_fits)
  - id: save_fit_file
    type:
      - 'null'
      - File
    doc: Saved model fit (written to the --save-fit path)
    outputBinding:
      glob: $(inputs.save_fit)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.filelist_files ? inputs.filelist_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0

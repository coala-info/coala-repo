cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-run-gibbs
label: rsem_rsem-run-gibbs
doc: "Run RSEM's Gibbs sampler on the files made by rsem-run-em (run with
  --gibbs-out). It writes posterior mean estimates of expression and the count
  samples used for credibility intervals.\n\nFormat of the prior file: one
  isoform's prior per line; priors must be in the same order as in the .ti file;
  priors for to-be-omitted isoforms must be included as well; comments can be
  added after a prior, separated by space(s).\n\nTool homepage:
  https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_name
    type: string
    doc: Reference name (the prefix of the files made by rsem-prepare-reference).
    inputBinding:
      position: 1
  - id: imd_name
    type: string
    doc: Prefix of the intermediate files (made by rsem-parse-alignments and 
      rsem-run-em).
    inputBinding:
      position: 2
  - id: stat_name
    type: string
    doc: Prefix of the statistics files (made by rsem-parse-alignments and 
      rsem-run-em).
    inputBinding:
      position: 3
  - id: burnin
    type: int
    doc: Number of burn-in rounds (rsem-calculate-expression uses 200).
    inputBinding:
      position: 4
  - id: nsamples
    type: int
    doc: Number of samples to collect (rsem-calculate-expression uses 1000).
    inputBinding:
      position: 5
  - id: gap
    type: int
    doc: Gap between collected samples (rsem-calculate-expression uses 1).
    inputBinding:
      position: 6
  - id: reference_files
    type:
      type: array
      items: File
    doc: Reference files written by rsem-prepare-reference (all files starting 
      with the reference name). They are staged in the working directory.
  - id: imd_files
    type:
      type: array
      items: File
    doc: Intermediate files with the imd_name prefix (.dat, .omit, .ofg, 
      .mparams, .iso_res, .gene_res and the alignable read files).
  - id: stat_files
    type:
      type: array
      items: File
    doc: Statistics files with the stat_name prefix (.cnt, .model, .theta).
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. (default: 1)'
    inputBinding:
      position: 10
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed.
    inputBinding:
      position: 10
      prefix: --seed
  - id: pseudo_count
    type:
      - 'null'
      - float
    doc: Pseudo count added to every isoform.
    inputBinding:
      position: 10
      prefix: --pseudo-count
  - id: prior
    type:
      - 'null'
      - File
    doc: Prior file, one isoform's prior per line, in the order of the .ti file.
    inputBinding:
      position: 10
      prefix: --prior
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set it quiet.
    inputBinding:
      position: 10
      prefix: -q
outputs:
  - id: iso_res
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.imd_name).iso_res
    doc: Isoform level results (updated with the Gibbs estimates).
  - id: gene_res
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.imd_name).gene_res
    doc: Gene level results (updated with the Gibbs estimates).
  - id: sample_files
    type:
      type: array
      items: File
    outputBinding:
      glob: $(inputs.imd_name).countvectors*
    doc: Count vectors written for rsem-calculate-credibility-intervals.
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_files)
      - entry: $(inputs.imd_files)
        writable: true
      - entry: $(inputs.stat_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12

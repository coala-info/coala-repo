cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mpirun
label: phylobayes-mpi_readpb_mpi
doc: "Read a PhyloBayes chain (readpb_mpi, run under mpirun): posterior consensus tree and parameter estimates, site-specific rates, posterior predictive tests and other summaries.\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs:
  - id: np
    type: int
    doc: "number of parallel processes (mpirun -np; at least 2)"
    default: 2
    inputBinding:
      position: 1
      prefix: "-np"
  - id: extract
    type:
      - 'null'
      - type: array
        items: int
    doc: "burnin, and optionally every and until (default burnin = 1/5 of the chain)"
    inputBinding:
      position: 3
      prefix: "-x"
  - id: site_profiles
    type:
      - 'null'
      - boolean
    doc: "read site-specific profiles"
    inputBinding:
      position: 4
      prefix: "-ss"
  - id: site_rates
    type:
      - 'null'
      - boolean
    doc: "read site-specific rates"
    inputBinding:
      position: 4
      prefix: "-r"
  - id: site_loglikelihoods
    type:
      - 'null'
      - boolean
    doc: "compute site log-likelihoods"
    inputBinding:
      position: 4
      prefix: "-sitelogl"
  - id: cutoff
    type:
      - 'null'
      - float
    doc: "cutoff for the site log-likelihood output"
    inputBinding:
      position: 4
      prefix: "-cutoff"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 4
      prefix: "-v"
  - id: ppred_div
    type:
      - 'null'
      - boolean
    doc: "posterior predictive test on the diversity statistic"
    inputBinding:
      position: 4
      prefix: "-div"
  - id: ppred_comp
    type:
      - 'null'
      - boolean
    doc: "posterior predictive test on the compositional statistic"
    inputBinding:
      position: 4
      prefix: "-comp"
  - id: ppred
    type:
      - 'null'
      - boolean
    doc: "posterior predictive simulations (plain, outputs the simulated data)"
    inputBinding:
      position: 4
      prefix: "-ppred"
  - id: allppred
    type:
      - 'null'
      - boolean
    doc: "all posterior predictive statistics"
    inputBinding:
      position: 4
      prefix: "-allppred"
  - id: map
    type:
      - 'null'
      - boolean
    doc: "read the MAP substitution mapping"
    inputBinding:
      position: 4
      prefix: "-map"
  - id: anc
    type:
      - 'null'
      - boolean
    doc: "ancestral state posterior probabilities"
    inputBinding:
      position: 4
      prefix: "-anc"
  - id: posthyper
    type:
      - 'null'
      - boolean
    doc: "posterior of the hyperparameters"
    inputBinding:
      position: 4
      prefix: "-posthyper"
  - id: siteprofilesuffstat
    type:
      - 'null'
      - boolean
    doc: "site profile sufficient statistics"
    inputBinding:
      position: 4
      prefix: "-siteprofilesuffstat"
  - id: savetrees
    type:
      - 'null'
      - boolean
    doc: "save the trees of the posterior predictive simulations"
    inputBinding:
      position: 4
      prefix: "-savetrees"
  - id: chainname
    type: string
    doc: "name of the chain (prefix of the chain files)"
    inputBinding:
      position: 5
  - id: datafile
    type: File
    doc: "the data file (alignment) the chain was run on; it is staged in the working directory under its own name, where the chain files expect it"
  - id: chain_files
    type:
      type: array
      items: File
    doc: "files of the chain (chainname.*)"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: summary
    type: stderr
    doc: "Summary printed by readpb_mpi (posterior means and 95% credibility intervals of the parameters; the program writes it to standard error)"
  - id: read_output
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files written by the options (site profiles, site rates, site log-likelihoods, posterior predictive tests, ...)"
    outputBinding:
      glob:
        - "$(inputs.chainname).site*"
        - "$(inputs.chainname).*ppred*"
        - "$(inputs.chainname).*div*"
        - "$(inputs.chainname).*comp*"
        - "$(inputs.chainname).*cv*"
        - "$(inputs.chainname).*map*"
        - "$(inputs.chainname).anc*"
arguments:
  - position: 2
    valueFrom: readpb_mpi
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.datafile)
      - $(inputs.chain_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi_readpb_mpi.out
stderr: phylobayes-mpi_readpb_mpi.err

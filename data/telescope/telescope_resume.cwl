cwlVersion: v1.2
class: CommandLineTool
baseCommand: telescope resume
label: telescope_resume
doc: "Resume a previous telescope run\n\nTool homepage: https://github.com/mlbendall/telescope"
inputs:
  - id: checkpoint
    type: File
    doc: Path to checkpoint file.
    inputBinding:
      position: 1
  - id: conf_prob
    type:
      - 'null'
      - float
    doc: Minimum probability for high confidence assignment.
    inputBinding:
      position: 102
      prefix: --conf_prob
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug messages.
    inputBinding:
      position: 102
      prefix: --debug
  - id: em_epsilon
    type:
      - 'null'
      - float
    doc: EM Algorithm Epsilon cutoff
    inputBinding:
      position: 102
      prefix: --em_epsilon
  - id: exp_tag
    type:
      - 'null'
      - string
    doc: Experiment tag
    inputBinding:
      position: 102
      prefix: --exp_tag
  - id: logfile
    type:
      - 'null'
      - File
    doc: Log output to this file.
    inputBinding:
      position: 102
      prefix: --logfile
  - id: max_iter
    type:
      - 'null'
      - int
    doc: EM Algorithm maximum iterations
    inputBinding:
      position: 102
      prefix: --max_iter
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: pi_prior
    type:
      - 'null'
      - float
    doc: Prior on π. Equivalent to adding n unique reads.
    inputBinding:
      position: 102
      prefix: --pi_prior
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence (most) output.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reassign_mode
    type:
      - 'null'
      - string
    doc: "Reassignment mode. After EM is complete, each fragment\nis reassigned according
      to the expected value of its\nmembership weights. The reassignment method is
      the\nmethod for resolving the \"best\" reassignment for\nfragments that have
      multiple possible reassignments.\nAvailable modes are: \"exclude\" - fragments
      with\nmultiple best assignments are excluded from the final\ncounts; \"choose\"\
      \ - the best assignment is randomly\nchosen from among the set of best assignments;\n\
      \"average\" - the fragment is divided evenly among the\nbest assignments; \"\
      conf\" - only assignments that\nexceed a certain threshold (see --conf_prob)
      are\naccepted; \"unique\" - only uniquely aligned reads are\nincluded. NOTE:
      Results using all assignment modes are\nincluded in the Telescope report by
      default. This\nargument determines what mode will be used for the\n\"final counts\"\
      \ column."
    inputBinding:
      position: 102
      prefix: --reassign_mode
  - id: theta_prior
    type:
      - 'null'
      - float
    doc: "Prior on θ. Equivalent to adding n non-unique reads.\nNOTE: It is recommended
      to set this prior to a large\nvalue. This increases the penalty for non-unique
      reads\nand improves accuracy."
    inputBinding:
      position: 102
      prefix: --theta_prior
  - id: use_likelihood
    type:
      - 'null'
      - boolean
    doc: Use difference in log-likelihood as convergence criteria.
    inputBinding:
      position: 102
      prefix: --use_likelihood
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telescope:1.0.3--py36h14c3975_0
stdout: telescope_resume.out

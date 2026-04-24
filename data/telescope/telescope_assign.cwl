cwlVersion: v1.2
class: CommandLineTool
baseCommand: telescope assign
label: telescope_assign
doc: "Reassign ambiguous fragments that map to repetitive elements\n\nTool homepage:
  https://github.com/mlbendall/telescope"
inputs:
  - id: samfile
    type: File
    doc: Path to alignment file. Alignment file can be in SAM or BAM format. 
      File must be collated so that all alignments for a read pair appear 
      sequentially in the file.
    inputBinding:
      position: 1
  - id: gtffile
    type: File
    doc: Path to annotation file (GTF format)
    inputBinding:
      position: 2
  - id: annotation_class
    type:
      - 'null'
      - string
    doc: Annotation class to use for finding overlaps. Both htseq and 
      intervaltree appear to yield identical results. Performance differences 
      are TBD.
    inputBinding:
      position: 103
      prefix: --annotation_class
  - id: attribute
    type:
      - 'null'
      - string
    doc: GTF attribute that defines a transposable element locus. GTF features 
      that share the same value for --attribute will be considered as part of 
      the same locus.
    inputBinding:
      position: 103
      prefix: --attribute
  - id: conf_prob
    type:
      - 'null'
      - float
    doc: Minimum probability for high confidence assignment.
    inputBinding:
      position: 103
      prefix: --conf_prob
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug messages.
    inputBinding:
      position: 103
      prefix: --debug
  - id: em_epsilon
    type:
      - 'null'
      - float
    doc: EM Algorithm Epsilon cutoff
    inputBinding:
      position: 103
      prefix: --em_epsilon
  - id: exp_tag
    type:
      - 'null'
      - string
    doc: Experiment tag
    inputBinding:
      position: 103
      prefix: --exp_tag
  - id: logfile
    type:
      - 'null'
      - File
    doc: Log output to this file.
    inputBinding:
      position: 103
      prefix: --logfile
  - id: max_iter
    type:
      - 'null'
      - int
    doc: EM Algorithm maximum iterations
    inputBinding:
      position: 103
      prefix: --max_iter
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of cores to use. (Multiple cores not supported yet).
    inputBinding:
      position: 103
      prefix: --ncpu
  - id: no_feature_key
    type:
      - 'null'
      - string
    doc: Used internally to represent alignments. Must be different from all 
      other feature names.
    inputBinding:
      position: 103
      prefix: --no_feature_key
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 103
      prefix: --outdir
  - id: overlap_mode
    type:
      - 'null'
      - string
    doc: Overlap mode. The method used to determine whether a fragment overlaps 
      feature.
    inputBinding:
      position: 103
      prefix: --overlap_mode
  - id: overlap_threshold
    type:
      - 'null'
      - float
    doc: Fraction of fragment that must be contained within a feature to be 
      assigned to that locus. Ignored if --overlap_method is not "threshold".
    inputBinding:
      position: 103
      prefix: --overlap_threshold
  - id: pi_prior
    type:
      - 'null'
      - float
    doc: Prior on π. Equivalent to adding n unique reads.
    inputBinding:
      position: 103
      prefix: --pi_prior
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence (most) output.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: reassign_mode
    type:
      - 'null'
      - string
    doc: 'Reassignment mode. After EM is complete, each fragment is reassigned according
      to the expected value of its membership weights. The reassignment method is
      the method for resolving the "best" reassignment for fragments that have multiple
      possible reassignments. Available modes are: "exclude" - fragments with multiple
      best assignments are excluded from the final counts; "choose" - the best assignment
      is randomly chosen from among the set of best assignments; "average" - the fragment
      is divided evenly among the best assignments; "conf" - only assignments that
      exceed a certain threshold (see --conf_prob) are accepted; "unique" - only uniquely
      aligned reads are included. NOTE: Results using all assignment modes are included
      in the Telescope report by default. This argument determines what mode will
      be used for the "final counts" column.'
    inputBinding:
      position: 103
      prefix: --reassign_mode
  - id: skip_em
    type:
      - 'null'
      - boolean
    doc: Exits after loading alignment and saving checkpoint file.
    inputBinding:
      position: 103
      prefix: --skip_em
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Path to temporary directory. Temporary files will be stored here. 
      Default uses python tempfile package to create the temporary directory.
    inputBinding:
      position: 103
      prefix: --tempdir
  - id: theta_prior
    type:
      - 'null'
      - float
    doc: 'Prior on θ. Equivalent to adding n non-unique reads. NOTE: It is recommended
      to set this prior to a large value. This increases the penalty for non-unique
      reads and improves accuracy.'
    inputBinding:
      position: 103
      prefix: --theta_prior
  - id: updated_sam
    type:
      - 'null'
      - boolean
    doc: Generate an updated alignment file.
    inputBinding:
      position: 103
      prefix: --updated_sam
  - id: use_likelihood
    type:
      - 'null'
      - boolean
    doc: Use difference in log-likelihood as convergence criteria.
    inputBinding:
      position: 103
      prefix: --use_likelihood
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telescope:1.0.3--py36h14c3975_0
stdout: telescope_assign.out

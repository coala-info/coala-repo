# telescope CWL Generation Report

## telescope_assign

### Tool Description
Reassign ambiguous fragments that map to repetitive elements

### Metadata
- **Docker Image**: quay.io/biocontainers/telescope:1.0.3--py36h14c3975_0
- **Homepage**: https://github.com/mlbendall/telescope
- **Package**: https://anaconda.org/channels/bioconda/packages/telescope/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/telescope/overview
- **Total Downloads**: 13.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mlbendall/telescope
- **Stars**: N/A
### Original Help Text
```text
usage: telescope assign [-h] [--attribute ATTRIBUTE]
                        [--no_feature_key NO_FEATURE_KEY] [--ncpu NCPU]
                        [--tempdir TEMPDIR] [--quiet] [--debug]
                        [--logfile LOGFILE] [--outdir OUTDIR]
                        [--exp_tag EXP_TAG] [--updated_sam]
                        [--reassign_mode {exclude,choose,average,conf,unique}]
                        [--conf_prob CONF_PROB]
                        [--overlap_mode {threshold,intersection-strict,union}]
                        [--overlap_threshold OVERLAP_THRESHOLD]
                        [--annotation_class {intervaltree,htseq}]
                        [--pi_prior PI_PRIOR] [--theta_prior THETA_PRIOR]
                        [--em_epsilon EM_EPSILON] [--max_iter MAX_ITER]
                        [--use_likelihood] [--skip_em]
                        samfile gtffile

Reassign ambiguous fragments that map to repetitive elements

optional arguments:
  -h, --help            show this help message and exit

Input Options:

  samfile               Path to alignment file. Alignment file can be in SAM
                        or BAM format. File must be collated so that all
                        alignments for a read pair appear sequentially in the
                        file.
  gtffile               Path to annotation file (GTF format)
  --attribute ATTRIBUTE
                        GTF attribute that defines a transposable element
                        locus. GTF features that share the same value for
                        --attribute will be considered as part of the same
                        locus. (default: locus)
  --no_feature_key NO_FEATURE_KEY
                        Used internally to represent alignments. Must be
                        different from all other feature names. (default:
                        __no_feature)
  --ncpu NCPU           Number of cores to use. (Multiple cores not supported
                        yet). (default: 1)
  --tempdir TEMPDIR     Path to temporary directory. Temporary files will be
                        stored here. Default uses python tempfile package to
                        create the temporary directory. (default: None)

Reporting Options:

  --quiet               Silence (most) output. (default: False)
  --debug               Print debug messages. (default: False)
  --logfile LOGFILE     Log output to this file. (default: None)
  --outdir OUTDIR       Output directory. (default: .)
  --exp_tag EXP_TAG     Experiment tag (default: telescope)
  --updated_sam         Generate an updated alignment file. (default: False)

Run Modes:

  --reassign_mode {exclude,choose,average,conf,unique}
                        Reassignment mode. After EM is complete, each fragment
                        is reassigned according to the expected value of its
                        membership weights. The reassignment method is the
                        method for resolving the "best" reassignment for
                        fragments that have multiple possible reassignments.
                        Available modes are: "exclude" - fragments with
                        multiple best assignments are excluded from the final
                        counts; "choose" - the best assignment is randomly
                        chosen from among the set of best assignments;
                        "average" - the fragment is divided evenly among the
                        best assignments; "conf" - only assignments that
                        exceed a certain threshold (see --conf_prob) are
                        accepted; "unique" - only uniquely aligned reads are
                        included. NOTE: Results using all assignment modes are
                        included in the Telescope report by default. This
                        argument determines what mode will be used for the
                        "final counts" column. (default: exclude)
  --conf_prob CONF_PROB
                        Minimum probability for high confidence assignment.
                        (default: 0.9)
  --overlap_mode {threshold,intersection-strict,union}
                        Overlap mode. The method used to determine whether a
                        fragment overlaps feature. (default: threshold)
  --overlap_threshold OVERLAP_THRESHOLD
                        Fraction of fragment that must be contained within a
                        feature to be assigned to that locus. Ignored if
                        --overlap_method is not "threshold". (default: 0.2)
  --annotation_class {intervaltree,htseq}
                        Annotation class to use for finding overlaps. Both
                        htseq and intervaltree appear to yield identical
                        results. Performance differences are TBD. (default:
                        intervaltree)

Model Parameters:

  --pi_prior PI_PRIOR   Prior on π. Equivalent to adding n unique reads.
                        (default: 0)
  --theta_prior THETA_PRIOR
                        Prior on θ. Equivalent to adding n non-unique reads.
                        NOTE: It is recommended to set this prior to a large
                        value. This increases the penalty for non-unique reads
                        and improves accuracy. (default: 200000)
  --em_epsilon EM_EPSILON
                        EM Algorithm Epsilon cutoff (default: 1e-7)
  --max_iter MAX_ITER   EM Algorithm maximum iterations (default: 100)
  --use_likelihood      Use difference in log-likelihood as convergence
                        criteria. (default: False)
  --skip_em             Exits after loading alignment and saving checkpoint
                        file. (default: False)
```


## telescope_resume

### Tool Description
Resume a previous telescope run

### Metadata
- **Docker Image**: quay.io/biocontainers/telescope:1.0.3--py36h14c3975_0
- **Homepage**: https://github.com/mlbendall/telescope
- **Package**: https://anaconda.org/channels/bioconda/packages/telescope/overview
- **Validation**: PASS

### Original Help Text
```text
usage: telescope resume [-h] [--quiet] [--debug] [--logfile LOGFILE]
                        [--outdir OUTDIR] [--exp_tag EXP_TAG]
                        [--reassign_mode {exclude,choose,average,conf,unique}]
                        [--conf_prob CONF_PROB] [--pi_prior PI_PRIOR]
                        [--theta_prior THETA_PRIOR] [--em_epsilon EM_EPSILON]
                        [--max_iter MAX_ITER] [--use_likelihood]
                        checkpoint

Resume a previous telescope run

optional arguments:
  -h, --help            show this help message and exit

Input Options:

  checkpoint            Path to checkpoint file.

Reporting Options:

  --quiet               Silence (most) output. (default: False)
  --debug               Print debug messages. (default: False)
  --logfile LOGFILE     Log output to this file. (default: None)
  --outdir OUTDIR       Output directory. (default: .)
  --exp_tag EXP_TAG     Experiment tag (default: telescope)

Run Modes:

  --reassign_mode {exclude,choose,average,conf,unique}
                        Reassignment mode. After EM is complete, each fragment
                        is reassigned according to the expected value of its
                        membership weights. The reassignment method is the
                        method for resolving the "best" reassignment for
                        fragments that have multiple possible reassignments.
                        Available modes are: "exclude" - fragments with
                        multiple best assignments are excluded from the final
                        counts; "choose" - the best assignment is randomly
                        chosen from among the set of best assignments;
                        "average" - the fragment is divided evenly among the
                        best assignments; "conf" - only assignments that
                        exceed a certain threshold (see --conf_prob) are
                        accepted; "unique" - only uniquely aligned reads are
                        included. NOTE: Results using all assignment modes are
                        included in the Telescope report by default. This
                        argument determines what mode will be used for the
                        "final counts" column. (default: exclude)
  --conf_prob CONF_PROB
                        Minimum probability for high confidence assignment.
                        (default: 0.9)

Model Parameters:

  --pi_prior PI_PRIOR   Prior on π. Equivalent to adding n unique reads.
                        (default: 0)
  --theta_prior THETA_PRIOR
                        Prior on θ. Equivalent to adding n non-unique reads.
                        NOTE: It is recommended to set this prior to a large
                        value. This increases the penalty for non-unique reads
                        and improves accuracy. (default: 200000)
  --em_epsilon EM_EPSILON
                        EM Algorithm Epsilon cutoff (default: 1e-7)
  --max_iter MAX_ITER   EM Algorithm maximum iterations (default: 100)
  --use_likelihood      Use difference in log-likelihood as convergence
                        criteria. (default: False)
```


## telescope_test

### Tool Description
Assigns reads to genomic features.

### Metadata
- **Docker Image**: quay.io/biocontainers/telescope:1.0.3--py36h14c3975_0
- **Homepage**: https://github.com/mlbendall/telescope
- **Package**: https://anaconda.org/channels/bioconda/packages/telescope/overview
- **Validation**: PASS

### Original Help Text
```text
telescope assign /usr/local/lib/python3.6/site-packages/telescope/data/alignment.bam /usr/local/lib/python3.6/site-packages/telescope/data/annotation.gtf
```


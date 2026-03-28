### Navigation

* [index](../genindex/ "General Index")
* [next](../References/ "10. References") |
* [previous](../Algorithms/ "8. Mikado core algorithms") |
* [Mikado](../) »

# 9. Scoring files[¶](#scoring-files "Permalink to this headline")

Mikado employs user-defined configuration files to define the desirable features in genes. These files are in TOML, YAML or JSON format (default YAML) and are composed of five sections:

> 1. a *requirements* section, specifying the minimum requirements that a transcript must satisfy to be considered as valid. **Any transcript failing these requirements will be scored at 0 and purged.**
> 2. a *cds\_requirements* section, specifying minimal conditions for a transcript to retain its CDS. If a transcript fails this check, it will be stripped of its coding component. If this section is not provided, the default will be to copy the *requirements* section above (in practice disabling it).
> 3. a *not\_fragmentary* section, specifying the minimum requirements that the primary transcript of a locus has to satisfy in order for the locus **not** to be considered as a putative fragment.
> 4. an *as\_requirements* section, which specifies the minimum requirements for transcripts for them to be considered as possible valid alternative splicing events.
> 5. a *scoring* section, specifying which features Mikado should look for in transcripts, and how each of them will be weighted.

Conditions are specified using a strict set of [available operators](#operators) and the values they have to consider.

Important

Although at the moment Mikado does not offer any method to establish machine-learning based scoring configurations, it is a topic we plan to investigate in the future. Mikado already supports [Random Forest Regressors as scorers through Scikit-learn](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html), but we have yet to devise a proper way to create such regressors.

We provide a guide on how to write your own scoring files in a [separate tutorial](../Tutorial/Scoring_tutorial/#configure-scoring-tutorial).

## 9.1. Operators[¶](#operators "Permalink to this headline")

Mikado allows the following operators to express a relationship inside the scoring files:

* *eq*: equal to (\(=\)). Valid for comparisons with numbers, boolean values, and strings.
* *ne*: different from (\(\neq\)). Valid for comparisons with numbers, boolean values, and strings.
* *lt*: less than (\(<\)). Valid for comparisons with numbers.
* *gt*: greater than (\(>\)). Valid for comparisons with numbers.
* *le*: less or equal than (\(\le\)). Valid for comparisons with numbers.
* *ge*: greater or equal than (\(\ge\)). Valid for comparisons with numbers.
* *in*: member of (\(\in\)). Valid for comparisons with arrays or sets.
* *not in*: not member of (\(\notin\)). Valid for comparisons with arrays or sets.
* *within*: value comprised in the range of the two values, inclusive.
* *not within*: value *not* comprised in the range of the two values, inclusive.

Mikado will fail if an operator not present on this list is specified, or if the operator is assigned to compare against the wrong data type (eg. *eq* with an array).

### 9.1.1. The “requirements”, “cds\_requirements”, “as\_requirements” and “not\_fragmentary” sections[¶](#the-requirements-cds-requirements-as-requirements-and-not-fragmentary-sections "Permalink to this headline")

These sections specifies the minimum requirements for a transcript at various stages.

* A transcript failing to pass the *requirements* check will be discarded outright (if “purge” is selected) or given a
  score of 0 otherwise.
* After passing the *rquirements* section, if the transcript is coding, Mikado will check whether its CDS passes the
  requirements specified in *cds\_requirements*. If the check fails, the transcripts will be **stripped of its CDS**, and
  will only be considered further as a non-coding transcript. *This check can be used to properly consider transcripts
  that have a suspicious coding structure - e.g. a single coding exon in a transcript with five or more exons, or a low
  Coding Potential score coming from a third-party tool*.
* If a transcript has not been selected as the primary transcript of a locus, it has to pass the *as\_requirements* check
  to be considered as a valid alternative splicing event.
* Finally, after loci have been defined, the primary transcript of each locus will be checked against the
  *not\_fragmentary* expression. Any locus failing this check will be marked as a potential fragment and, if in the
  vicinity of other loci, might be purged out of the final output or clearly marked as a fragment (depending on whether
  the *purge* switch is set to true or false, respectively).

**It is strongly advised to use lenient parameters in the first requirements section**, as failing to do so might result
in discarding whole loci. Typically, transcripts filtered at this step should be obvious artefacts, eg monoexonic
transcripts produced by RNA-Seq with a total length lower than the *library* fragment length.

Each of these sections follows the same template, and they are composed by two parts:

* *parameters*: a list of the metrics to be considered. Each metric can be considered multiple times, by suffixing
  it with a “.<id>” construct (eg cdna\_length.\*mono\* vs. cdna\_length.\*multi\* to distinguish two uses of the cdna\_length
  metric - once for monoexonic and once for multiexonic transcripts). Any parameter which is not a [valid metric
  name](#metrics), after removal of the suffix, **will cause an error**. Parameters have to specify the following:

  > + a *value* that the metric has to be compared against
  > + an *operator* that specifies the target operation. See [the operators section](#operators).
* *expression*: a string *array* that will be compiled into a valid boolean expression. All the metrics present in the
  expression string **must be present in the parameters section**. If an unrecognized metric is present, Mikado will
  crash immediately, complaining that the scoring file is invalid. Apart from brackets, Mikado accepts only the
  following boolean operators to chain the metrics:

  > + *and*
  > + *or*
  > + *not*
  > + *xor*

Hint

if no *expression* is specified, Mikado will construct one by chaining all the provided parameters with and
*and* operator. Most of the time, this would result in an unexpected behaviour - ie Mikado assigning a score of 0 to
most transcripts. It is **strongly advised** to explicitly provide a valid expression.

As an example, the following snippet replicates a typical requirements section found in a scoring file:

```
requirements:
  expression: [((exon_num.multi and cdna_length.multi and max_intron_length and min_intron_length), or,
    (exon_num.mono and cdna_length.mono))]
  parameters:
    cdna_length.mono: {operator: gt, value: 50}
    cdna_length.multi: {operator: ge, value: 100}
    exon_num.mono: {operator: eq, value: 1}
    exon_num.multi: {operator: gt, value: 1}
    max_intron_length: {operator: le, value: 20000}
    min_intron_length: {operator: ge, value: 5}
```

In the parameters section, we ask for the following:

> * *exon\_num.mono*: monoexonic transcripts must have one exon (“eq”)
> * *exon\_num.multi*: multiexonic transcripts must have more than one exon (“gt”)
> * *cdna\_length.mono*: monoexonic transcripts must have a length greater than 50 bps (the “.mono” suffix is
>   arbitrary, as long as it is unique for all calls of *cdna\_length*)
> * *cdna\_length.multi*: multiexonic transcripts must have a length greater than or equal to 100 bps (the “.multi”
>   suffix is arbitrary, as long as it is unique for all calls of *cdna\_length*)
> * *max\_intron\_length*: multiexonic transcripts should not have any intron longer than 200,000 bps.
> * *min\_intron\_length*: multiexonic transcripts should not have any intron smaller than 5 bps.

The *expression* field will be compiled into the following expression:

```
(exon_num > 1 and cdna_length >= 100 and max_intron_length <= 200000 and min_intron_length >= 5) or (exon_num == 1 and cdna_length > 50)
```

Any transcript for which the expression evaluates to `false` will be assigned a score of 0 outright and discarded,
unless the user has chosen to disable the purging of such transcripts.

## 9.2. The scoring section[¶](#the-scoring-section "Permalink to this headline")

This section specifies which metrics will be used by Mikado to score the transcripts. Each metric to be used is
specified as a subsection of the configuration, and will have the following attributes:

* *rescaling*: the only compulsory attribute. It specifies the kind of scoring that will be applied to the metric, and
  it has to be one of “max”, “min”, or “target”. See [the explanation on the scoring algorithm](../Algorithms/#scoring-algorithm)
  for details.
* *value*: compulsory if the chosen rescaling algorithm is “target”. This should be either a number or a boolean value.
* *multiplier*: the weight assigned to the metric in terms of scoring. This parameter is optional; if absent, as it is
  in the majority of cases, Mikado will consider the multiplier to equal to 1. This is the \(w\_{m}\) element in the
  [equations above](../Algorithms/#scoring-algorithm).
* *filter*: It is possible to specify a filter which the metric has to fulfill to be considered for scoring, eg,
  “cdna\_length >= 200”. If the transcript fails to pass this filter, the score *for this metric only* will be set to 0.
  **The filter can apply to a different metric**, so it is possible to e.g. assign a score of 0 for, say, “combined\_cds”
  to any transcript whose “cdna\_length” is, say, below 150 bps.
  A “filter” subsection has to specify the following:

  > + *operator*: the operator to apply for the boolean expression. See the [relative section](#operators).
  > + *value*: value that will be used to assess the metric.
  > + *metric*: *optional*. The metric that this filter refers to. If omitted, this will be identical to the metric
  >   under examination.

Hint

the purpose of the *filter* section is to allow for fine-tuning of the scoring mechanism; ie it allows to
penalise transcripts with undesirable qualities (eg a possible retained intron) without discarding them
outright. As such, it is a less harsh version of the [requirements section](#requirements-section) and
it is the preferred way of specifying which transcript features Mikado should be wary of.

For example, this is a snippet of a scoring section:

```
scoring:
    blast_score: {rescaling: max}
    cds_not_maximal: {rescaling: min}
    combined_cds_fraction: {rescaling: target, value: 0.8, multiplier: 2}
    five_utr_length:
        filter: {operator: le, value: 2500}
        rescaling: target
        value: 100
    end_distance_from_junction:
        filter: {operator: lt, value: 55}
        rescaling: min
    non_verified_introns_num:
        rescaling: max
        multiplier: -10
        filter:
            operator: gt
            value: 1
            metric: exons_num
```

Using this snippet as a guide, Mikado will score transcripts in each locus as follows:

* Assign a full score (one point, as no multiplier is specified) to transcripts which have the greatest *blast\_score*
* Assign a full score (one point, as no multiplier is specified) to transcripts which have the lowest amount of CDS
  bases in secondary ORFs (*cds\_not\_maximal*)
* Assign a full score (**two points**, as a multiplier of 2 is specified) to transcripts that have a total amount of CDS
  bps approximating 80% of the transcript cDNA length (*combined\_cds\_fraction*)
* Assign a full score (one point, as no multiplier is specified) to transcripts that have a 5’ UTR whose length is
  nearest to 100 bps (*five\_utr\_length*); if the 5’ UTR is longer than 2,500 bps, this score will be 0
  (see the filter section)
* Assign a full score (one point, as no multiplier is specified) to transcripts which have the lowest distance between
  the CDS end and the most downstream exon-exon junction (*end\_distance\_from\_junction*). If such a distance is greater
  than 55 bps, assign a score of 0, as it is a probable target for NMD (see the filter section).
* Assign a maximum penalty (**minus 10 points**, as a **negative** multiplier is specified) to the transcript with the
  highest number of non-verified introns in the locus.
  + Again, we are using a “filter” section to define which transcripts will be exempted from this scoring
    (in this case, a penalty)
  + However, please note that we are using the keyword **metric** in this section. This tells Mikado to check a
    *different* metric for evaluating the filter. Nominally, in this case we are excluding from the penalty any
    *monoexonic* transcript. This makes sense as a monoexonic transcript will never have an intron to be confirmed to
    start with.

Note

The possibility of using different metrics for the “filter” section is present from Mikado 1.3 onwards.

## 9.3. Metrics[¶](#metrics "Permalink to this headline")

These are all the metrics available to quantify transcripts. The documentation for this section has been generated using
the [metrics utility](../Usage/Utilities/#metrics-command).

Metrics belong to one of the following categories:

* **Descriptive**: these metrics merely provide a description of the transcript (eg its ID) and are not used for scoring.
* **cDNA**: these metrics refer to basic features of any transcript such as its number of exons, its cDNA length, etc.
* **Intron**: these metrics refer to features related to the number of introns and their lengths.
* **CDS**: these metrics refer to features related to the CDS assigned to the transcript.
* **UTR**: these metrics refer to features related to the UTR of the transcript. In the case in which a transcript has
  been assigned multiple ORFs, unless otherwise stated the UTR metrics will be derived only considering the *selected*
  ORF, not the combination of all of them.
* **Locus**: these metrics refer to features of the transcript in relationship to all other transcripts in its locus, eg
  how many of the introns present in the locus are present in the transcript. These metrics are calculated by Mikado during the picking phase, and as such their value can vary during the different stages as the transcripts are shifted to different groups.
* **External**: these metrics are derived from accessory data that is recovered for the transcript during the run time.
  Examples include data regarding the number of introns confirmed by external programs such as Portcullis, or the BLAST
  score of the best hits.
* **Attributes**: these metrics are extracted at runtime from attributes present in the input files. An example of this
  could be the TPM or FPKM values assigned to transcripts by rna expression analysis software.

Hint

Starting from version 1 beta8, Mikado allows to use externally defined 
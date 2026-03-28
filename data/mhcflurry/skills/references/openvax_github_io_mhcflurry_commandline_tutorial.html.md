[MHCflurry](index.html)

2.0.0

* [Introduction and setup](intro.html)
* Command-line tutorial
  + [Downloading models](#downloading-models)
  + [Generating predictions](#generating-predictions)
  + [Using the older, allele-specific models](#using-the-older-allele-specific-models)
  + [Scanning protein sequences for predicted MHC I ligands](#scanning-protein-sequences-for-predicted-mhc-i-ligands)
  + [Fitting your own models](#fitting-your-own-models)
  + [Environment variables](#environment-variables)
* [Python library tutorial](python_tutorial.html)
* [Command-line reference](commandline_tools.html)
* [API Documentation](api.html)

[MHCflurry](index.html)

* »
* Command-line tutorial
* [View page source](_sources/commandline_tutorial.rst.txt)

---

# Command-line tutorial[¶](#command-line-tutorial "Permalink to this headline")

## Downloading models[¶](#downloading-models "Permalink to this headline")

Most users will use pre-trained MHCflurry models that we release. These models
are distributed separately from the pip package and may be downloaded with the
[mhcflurry-downloads](commandline_tools.html#mhcflurry-downloads) tool:

```
$ mhcflurry-downloads fetch models_class1_presentation
```

Files downloaded with [mhcflurry-downloads](commandline_tools.html#mhcflurry-downloads) are stored in a platform-specific
directory. To get the path to downloaded data, you can use:

```
$ mhcflurry-downloads path models_class1_presentation
/Users/tim/Library/Application Support/mhcflurry/4/2.0.0/models_class1_presentation/
```

We also release a number of other “downloads,” such as curated training data and some
experimental models. To see what’s available and what you have downloaded, run
`mhcflurry-downloads info`.

Most users will only need `models_class1_presentation`, however, as the
presentation predictor includes a peptide / MHC I binding affinity (BA) predictor
as well as an antigen processing (AP) predictor.

Note

The code we use for *generating* the downloads is in the
`downloads_generation` directory in the repository (<https://github.com/openvax/mhcflurry/tree/master/downloads-generation>)

## Generating predictions[¶](#generating-predictions "Permalink to this headline")

The [mhcflurry-predict](commandline_tools.html#mhcflurry-predict) command generates predictions for individual peptides
(see the next section for how to scan protein sequences for epitopes). By
default it will use the pre-trained models you downloaded above. Other
models can be used by specifying the `--models` argument.

Running:

```
$ mhcflurry-predict
    --alleles HLA-A0201 HLA-A0301
    --peptides SIINFEKL SIINFEKD SIINFEKQ
    --out /tmp/predictions.csv
Forcing tensorflow backend.
Predicting processing.
Predicting affinities.
Wrote: /tmp/predictions.csv
```

results in a file like this:

```
$ cat /tmp/predictions.csv
allele,peptide,mhcflurry_affinity,mhcflurry_affinity_percentile,mhcflurry_processing_score,mhcflurry_presentation_score,mhcflurry_presentation_percentile
HLA-A0201,SIINFEKL,11927.158941532069,6.296000000000002,0.26470961794257164,0.020690210604074,11.6303260869565
HLA-A0201,SIINFEKD,30039.79614570185,41.398,0.024963302072137594,0.0036743984764636087,99.28660326086957
HLA-A0201,SIINFEKQ,28026.90550690346,30.226250000000004,0.06154933862853795,0.00447008680074548,62.74467391304348
HLA-A0301,SIINFEKL,29871.585202288912,23.19225,0.26470961794257164,0.008586191856042273,27.617391304347805
HLA-A0301,SIINFEKD,33158.802891745494,62.27625,0.024963302072137594,0.0033393306217936363,99.28660326086957
HLA-A0301,SIINFEKQ,29705.412189610724,21.8915,0.06154933862853795,0.004225574919955567,62.74467391304348
```

The binding affinity predictions are given as affinities (KD) in nM in the
`mhcflurry_affinity` column. Lower values indicate stronger binders. A commonly-used
threshold for peptides with a reasonable chance of being immunogenic is 500 nM.

The `mhcflurry_affinity_percentile` gives the percentile of the affinity
prediction among a large number of random peptides tested on that allele (range
0 - 100). Lower is stronger. Two percent is a commonly-used threshold.

The last two columns give the antigen processing and presentation scores,
respectively. These range from 0 to 1 with higher values indicating more
favorable processing or presentation.

Note

The processing predictor is experimental. It models allele-independent
effects that influence whether a
peptide will be detected in a mass spec experiment. The presentation score is
a simple logistic regression model that combines the (log) binding affinity
prediction with the processing score to give a composite prediction. The resulting
prediction may be useful for prioritizing potential epitopes, but no
thresholds have been established for what constitutes a “high enough”
presentation score.

In most cases you’ll want to specify the input as a CSV file instead of passing
peptides and alleles as commandline arguments. If you’re relying on the
processing or presentation scores, you may also want to pass the upstream and
downstream sequences of the peptides from their source proteins for potentially more
accurate cleavage prediction. See the [mhcflurry-predict](commandline_tools.html#mhcflurry-predict) docs.

## Using the older, allele-specific models[¶](#using-the-older-allele-specific-models "Permalink to this headline")

Previous versions of MHCflurry (described in the 2018 paper) used models
trained on affinity measurements, one allele per model (i.e. allele-specific).
Mass spec datasets were incorporated in the model selection step.

These models are still available to use with the latest version of MHCflurry.
To download these predictors, run:

```
$ mhcflurry-downloads fetch models_class1
```

and specify `--models` when you call `mhcflurry-predict`:

```
$ mhcflurry-predict \
    --alleles HLA-A0201 HLA-A0301 \
    --peptides SIINFEKL SIINFEKD SIINFEKQ \
    --models "$(mhcflurry-downloads path models_class1)/models"
    --out /tmp/predictions.csv
```

## Scanning protein sequences for predicted MHC I ligands[¶](#scanning-protein-sequences-for-predicted-mhc-i-ligands "Permalink to this headline")

Starting in version 1.6.0, MHCflurry supports scanning proteins for MHC-binding
peptides using the `mhcflurry-predict-scan` command.

We’ll generate predictions across `example.fasta`, a FASTA file with two short
sequences:

```
>protein1
MSSSSTPVCPNGPGNCQV
>protein2
MVENKRLLEGMEMIFGQVIPGA
```

Here’s the `mhcflurry-predict-scan` invocation to scan the proteins for
binders to either of two MHC I genotypes (using a 100 nM threshold):

```
$ mhcflurry-predict-scan
    example.fasta
    --alleles
        HLA-A*02:01,HLA-A*03:01,HLA-B*57:01,HLA-B*45:01,HLA-C*02:02,HLA-C*07:02
        HLA-A*01:01,HLA-A*02:06,HLA-B*44:02,HLA-B*07:02,HLA-C*01:02,HLA-C*03:01
    --results-filtered affinity
    --threshold-affinity 100
Forcing tensorflow backend.
Guessed input file format: fasta
Read input fasta with 2 sequences
  sequence_id                sequence
0    protein1      MSSSSTPVCPNGPGNCQV
1    protein2  MVENKRLLEGMEMIFGQVIPGA
Predicting processing.
Predicting affinities.
sequence_name,pos,peptide,n_flank,c_flank,sample_name,affinity,best_allele,affinity_percentile,processing_score,presentation_score,presentation_percentile
protein2,5,RLLEGMEMI,MVENK,FGQVI,genotype_00,20.48976379349174,HLA-A*02:01,0.10225000000000008,0.6447581760585308,0.975528093093756,0.013097826086976738
protein2,5,RLLEGMEMI,MVENK,FGQVI,genotype_01,23.010403529711986,HLA-A*02:06,0.1372500000000001,0.6447581760585308,0.972681225756668,0.016576086956561653
protein2,12,MIFGQVIPGA,LEGME,,genotype_01,40.981431478935065,HLA-A*02:06,0.3232499999999999,0.8904485031962395,0.9810106587410801,0.0061684782608750766
protein2,4,KRLLEGMEM,MVEN,IFGQV,genotype_00,49.677106614054956,HLA-C*07:02,0.09350000000000007,0.12594258785247803,0.7006409502993601,0.43820652173911867
protein2,12,MIFGQVIPGA,LEGME,,genotype_00,62.967656603774884,HLA-A*02:01,0.4323749999999997,0.8904485031962395,0.9714322924052166,0.017663043478293616
protein2,10,MEMIFGQVI,RLLEG,PGA,genotype_00,82.40893767472276,HLA-B*45:01,0.18000000000000002,0.3939148336648941,0.7984213046411495,0.2809510869564775
protein1,8,CPNGPGNCQV,SSTPV,,genotype_01,87.84821064140868,HLA-B*07:02,0.297,0.057573866099119186,0.5088251513715745,0.8024184782607335
```

See the [mhcflurry-predict-scan](commandline_tools.html#mhcflurry-predict-scan) docs for more options.

## Fitting your own models[¶](#fitting-your-own-models "Permalink to this headline")

If you have your own data and want to fit your own MHCflurry models, you have
a few options. If you have data for only one or a few MHC I alleles, the best
approach is to use the
[mhcflurry-class1-train-allele-specific-models](commandline_tools.html#mhcflurry-class1-train-allele-specific-models) command to fit an
“allele-specific” predictor, in which separate neural networks are used for
each allele.

To call [mhcflurry-class1-train-allele-specific-models](commandline_tools.html#mhcflurry-class1-train-allele-specific-models) you’ll need some
training data. The data we use for our released predictors can be downloaded with
[mhcflurry-downloads](commandline_tools.html#mhcflurry-downloads):

```
$ mhcflurry-downloads fetch data_curated
```

It looks like this:

```
$ bzcat "$(mhcflurry-downloads path data_curated)/curated_training_data.csv.bz2" | head -n 3
allele,peptide,measurement_value,measurement_inequality,measurement_type,measurement_kind,measurement_source,original_allele
BoLA-1*21:01,AENDTLVVSV,7817.0,=,quantitative,affinity,Barlow - purified MHC/competitive/fluorescence,BoLA-1*02101
BoLA-1*21:01,NQFNGGCLLV,1086.0,=,quantitative,affinity,Barlow - purified MHC/direct/fluorescence,BoLA-1*02101
```

Here’s an example invocation to fit a predictor:

```
$ mhcflurry-class1-train-allele-specific-models \
    --data curated_training_data.csv.bz2 \
    --hyperparameters hyperparameters.yaml \
    --min-measurements-per-allele 75 \
    --out-models-dir models
```

The `hyperparameters.yaml` file gives the list of neural network architectures
to train models for. Here’s an example specifying a single architecture:

```
- activation: tanh
  dense_layer_l1_regularization: 0.0
  dropout_probability: 0.0
  early_stopping: true
  layer_sizes: [8]
  locally_connected_layers: []
  loss: custom:mse_with_inequalities
  max_epochs: 500
  minibatch_size: 128
  n_models: 4
  output_activation: sigmoid
  patience: 20
  peptide_amino_acid_encoding: BLOSUM62
  random_negative_affinity_max: 50000.0
  random_negative_affinity_min: 20000.0
  random_negative_constant: 25
  random_negative_rate: 0.0
  validation_split: 0.1
```

The available hyperparameters for binding predictors are defined in
[`Class1NeuralNetwork`](api.html#mhcflurry.Class1NeuralNetwork "mhcflurry.Class1NeuralNetwork"). To see exactly how
these are used you will need to read the source code.

Note

MHCflurry predictors are serialized to disk as many files in a directory. The
model training command above will write the models to the output directory specified by the
`--out-models-dir` argument. This directory has files like:

```
info.txt
manifest.csv
model_selection.csv.bz2
model_selection_data.csv.bz2
...
weights_PATR-B*24:01-6-da42511a2164a8fe.npz
weights_PATR-B*24:01-7-4e3f5ded9cc1d851.npz
weights_PATR-B*24:01-8-491d1b4d85da0dc4.npz
weights_PATR-B*24:01-9-8f295e814502ffa1.npz
```

The `manifest.csv` file gives metadata for all the models used in the predictor.
There will be a `weights_...` file for each model giving its weights
(the parameters for the neural network). The `percent_ranks.csv` stores a
histogram of model predictions for each allele over a large number of random
peptides. It is used for generating the percent ranks at prediction time.

To fit pan-allele models like the ones released with MHCflurry, you can use
a similar tool, [mhcflurry-class1-train-pan-allele-models](commandline_tools.html#mhcflurry-class1-train-pan-allele-models). You’ll probably
also want to take a look at the scripts used to generate the production models,
which are available in the *downloads-generation* directory in the MHCflurry
repository. See the scripts in the *models\_class1\_pan* subdirectory to see how the
fitting and model selection was done for models currently distributed with MHCflurry.

Note

The production MHCflurry models were fit using a cluster with several
dozen GPUs over a period of about two days. If you model select over fewer
architectures, however, it should be possible to fit a predictor using less
resources.

## Environment variables[¶](#environment-variables "Permalink to this headline")

MHCflurry behavior can be modified using these environment variables:

`MHCFLURRY_DEFAULT_CLASS1_MODELS`
:   Path to models directory. If you call `Class1AffinityPredictor.load()`
    with no arguments, the models specified in this environment variable will be
    used. If this environment variable is undefined, the downloaded models for
    the current MHCflurry release are used.

`MHCFLURRY_OPTIMIZATION_LEVEL`
:   The pan-allele models can be somewhat slow. As an optimization, when this
    variable is greater than 0 (default is 1), we “stitch” the pan-allele models in
    the ensemble into one large tensorflow graph. In our experiments
    it gives about a 30% speed improvement. It has no effect on allele-specific
    models. Set this variable to 0 to disable this behavior. This may be helpful
    if you are running out of memory using the pan-allele models.

`MHCFLURRY_DEFAULT_PREDICT_BATCH_SIZE`
:   For large prediction tasks, it can be helpful to increase the prediction batch
    size, which is set by this environment variable (default is 4096). This
    affects both allele-specific and pan-allele predictors. It can have large
    effects on performance. Alternatively, if you are running out of memory,
    you can try decreasing the batch size.

[Next](python_tutorial.html "Python library tutorial")
 [Previous](intro.html "Introduction and setup")

---

© Copyright Timothy O'Donnell
Last updated on Jul 13, 2020.

Built with [Sphinx](http://sphinx-doc.org/) using a
[theme](https://github.com/rtfd/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).
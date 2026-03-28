[ ]
[ ]

[Skip to content](#introducing-the-next-generation-of-instanovo-models)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

Introducing the next generation of InstaNovo models

Initializing search

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](../..)
* [Tutorials](../../tutorials/getting_started/)
* [How-to guides](../../how-to/predicting/)
* [Reference](../../reference/cli/)
* [Explanation](../../explanation/performance/)
* [Blog](../../blog/introducing-the-next-generation-of-instanovo-models/)
* [For developers](../../development/setup/)
* [How to cite](../../citation/)
* [License](../../license/)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")
InstaNovo

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](../..)
* [x]

  Tutorials

  Tutorials
  + [Quick overview](../../tutorials/getting_started/)
  + [Getting started with InstaNovo](../getting_started_with_instanovo/)
  + [ ]

    Introducing the next generation of InstaNovo models

    [Introducing the next generation of InstaNovo models](./)

    Table of contents
    - [Announcing InstaNovo v1.1](#announcing-instanovo-v11)
    - [Getting started](#getting-started)
    - [Training data](#training-data)
    - [Benchmarking IN v1.1](#benchmarking-in-v11)

      * [Recall](#recall)
      * [Mapping to proteome](#mapping-to-proteome)
    - [Expanded modification support, features and runtime](#expanded-modification-support-features-and-runtime)
  + [Introducing InstaNovo-P, a de novo sequencing model for phosphoproteomics](../InstaNovo-P/)
* [ ]

  How-to guides

  How-to guides
  + [Predicting](../../how-to/predicting/)
  + [Using Custom Datasets](../../how-to/using_custom_datasets/)
  + [Training](../../how-to/training/)
* [ ]

  Reference

  Reference
  + [CLI](../../reference/cli/)
  + [Models](../../reference/models/)
  + [Supported Modifications](../../reference/modifications/)
  + [Prediction Output](../../reference/prediction_output/)
  + [API](../../API/summary/)
* [ ]

  Explanation

  Explanation
  + [Performance](../../explanation/performance/)
  + [SpectrumDataFrame](../../explanation/spectrum_data_frame/)
* [ ]

  Blog

  Blog
  + [Introducing the next generation of InstaNovo models](../../blog/introducing-the-next-generation-of-instanovo-models/)
  + [Introducing InstaNovo-P](../../blog/introducing-instanovo-p-a-de-novo-sequencing-model-for-phosphoproteomics/)
  + [Winnow: calibrated confidence and FDR control for de novo sequencing](../../blog/calibrated-confidence-and-fdr-control-for-de-novo-sequencing/)
* [ ]

  For developers

  For developers
  + [Set up a development environment](../../development/setup/)
  + [Test Coverage](../../development/coverage/)
  + [Test Report](../../development/allure/)
* [How to cite](../../citation/)
* [License](../../license/)

# Introducing the next generation of InstaNovo models[¶](#introducing-the-next-generation-of-instanovo-models)

## Announcing InstaNovo v1.1[¶](#announcing-instanovo-v11)

Since our [InstaNovo paper](https://www.nature.com/articles/s42256-025-01019-5) is now published, we’d like to share an update on what we’ve been working on while our manuscript was under review. With the release of our preprint over a year ago, we were overwhelmed by the incredible response from the community and the applications of our models. We are actively collaborating with leading experts and continue to explore the potential of powerful solutions for de novo peptide sequencing. Our ongoing efforts focus on developing more accurate models, expanding the de novo sequencing ecosystem for analysis and data reporting, fine-tuning our models, and designing tailored, application-specific workflows.

While much of this work is still in progress, we have just released an improved version of our base model, InstaNovo v1.1. This model boasts higher recall, greater identification certainty, expanded support for modifications, and enhanced data processing and reporting features. We believe these advancements are worth communicating with this post instead of an article, and we are excited to show you how this model compares to the earlier model in our paper.

## Getting started[¶](#getting-started)

Our new model is available in the [main InstaNovo branch](https://github.com/instadeepai/InstaNovo/tree/main) with detailed documentation on installation, local execution, and running it in training or testing mode with your data. If you prefer a hosted solution, InstaDeep provides access to the model via our website, where you can upload your files and analyse up to 100,000 spectra per day on our servers (free for academic use). To reproduce the analysis in this blog post or to run this analysis on your own dataset, you can use this Jupyter notebook.

## Training data[¶](#training-data)

InstaNovo v1.1 (IN v1.1) has been trained on the [ProteomeTools](https://www.proteometools.org/), [MassiveKB](https://massive.ucsd.edu/ProteoSAFe/static/massive-kb-libraries.jsp), and kind dataset contributions from several other projects processed by the [CompOmics](https://www.compomics.com/) group at Ghent University. We are grateful for the huge community effort to generate, process, and curate the datasets that have enabled the development of our models. We are excited to contribute with the release of this combined dataset in the near future.

## Benchmarking IN v1.1[¶](#benchmarking-in-v11)

[IN v1.1](https://github.com/instadeepai/InstaNovo/releases/tag/1.1.0) is a substantial improvement over [IN v0.1](https://github.com/instadeepai/InstaNovo/releases/tag/0.1.4), the original model from our paper. To benchmark these models, we used a standard HeLa proteome run, a widely used reference sample in proteomics facilities for quality control and one of the validation datasets in our study.

In [ ]:

Copied!

```
import re
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib_venn import venn2
import matplotlib.patches as mpatches

sns.set_theme('paper', 'ticks', 'colorblind', font_scale=1.5)
```

import re
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib\_venn import venn2
import matplotlib.patches as mpatches
sns.set\_theme('paper', 'ticks', 'colorblind', font\_scale=1.5)

In [ ]:

Copied!

```
import warnings

# Suppress only FutureWarnings
warnings.simplefilter(action='ignore', category=FutureWarning)
```

import warnings
# Suppress only FutureWarnings
warnings.simplefilter(action='ignore', category=FutureWarning)

In [ ]:

Copied!

```
color_dict = {'old_knapsack': '#E2DBBE', 'new_knapsack': '#188FA7', 'new_greedy': '#9DBBAE', 'database': '#769FB6'}
```

color\_dict = {'old\_knapsack': '#E2DBBE', 'new\_knapsack': '#188FA7', 'new\_greedy': '#9DBBAE', 'database': '#769FB6'}

In [ ]:

Copied!

```
!mkdir ./data
```

!mkdir ./data

In [ ]:

Copied!

```
!python ../instanovo/scripts/get_zenodo_record.py --zenodo-url https://zenodo.org/api/records/15174703/files-archive --zip-path 15174703.zip --extract-path ./data
```

!python ../instanovo/scripts/get\_zenodo\_record.py --zenodo-url https://zenodo.org/api/records/15174703/files-archive --zip-path 15174703.zip --extract-path ./data

In [ ]:

Copied!

```
final = pd.read_csv('./data/hela_preds.csv')
targets = pd.read_csv('./data/hela_targets.csv')
```

final = pd.read\_csv('./data/hela\_preds.csv')
targets = pd.read\_csv('./data/hela\_targets.csv')

In [ ]:

Copied!

```
# merge final and target on scan_number
final = final.merge(targets, on='scan_number', how='left', suffixes=('_final', '_target'))
```

# merge final and target on scan\_number
final = final.merge(targets, on='scan\_number', how='left', suffixes=('\_final', '\_target'))

In [ ]:

Copied!

```
final.sample(5)
```

final.sample(5)

In [ ]:

Copied!

```
def normalise(string):
    string = string.replace("UNIMOD", "").replace("I", "L")
    return ''.join(re.findall(r'[A-Z]', string))

# get proteins from dataframe
def get_proteins(df, column):
    proteins = set()
    for ind in df.index:
        try:
            proteins.add(df.loc[ind, column].split(';')[0].split('|')[1])
        except:
            print(df.loc[ind, column], ind)
            pass
    return proteins
```

def normalise(string):
string = string.replace("UNIMOD", "").replace("I", "L")
return ''.join(re.findall(r'[A-Z]', string))
# get proteins from dataframe
def get\_proteins(df, column):
proteins = set()
for ind in df.index:
try:
proteins.add(df.loc[ind, column].split(';')[0].split('|')[1])
except:
print(df.loc[ind, column], ind)
pass
return proteins

In [ ]:

Copied!

```
final['preds'] = final['preds'].replace(np.nan, '')
final['preds_new_knapsack'] = final['preds_new_knapsack'].replace(np.nan, '')
final['preds_new_greedy'] = final['preds_new_greedy'].replace(np.nan, '')
final['Sequence'] = final['Sequence'].replace(np.nan, '')
final['sequence'] = final['sequence'].replace(np.nan, '')
```

final['preds'] = final['preds'].replace(np.nan, '')
final['preds\_new\_knapsack'] = final['preds\_new\_knapsack'].replace(np.nan, '')
final['preds\_new\_greedy'] = final['preds\_new\_greedy'].replace(np.nan, '')
final['Sequence'] = final['Sequence'].replace(np.nan, '')
final['sequence'] = final['sequence'].replace(np.nan, '')

In [ ]:

Copied!

```
final['stripped_preds_old_knapsack'] = final['preds'].apply(normalise)
final['stripped_preds_new_knapsack'] = final['preds_new_knapsack'].apply(normalise)
final['stripped_preds_new_greedy'] = final['preds_new_greedy'].apply(normalise)
final['stripped_sequence'] = final['Sequence'].apply(normalise)
final['stripped_target'] = final['sequence'].apply(normalise)
```

final['stripped\_preds\_old\_knapsack'] = final['preds'].apply(normalise)
final['stripped\_preds\_new\_knapsack'] = final['preds\_new\_knapsack'].apply(normalise)
final['stripped\_preds\_new\_greedy'] = final['preds\_new\_greedy'].apply(normalise)
final['stripped\_sequence'] = final['Sequence'].apply(normalise)
final['stripped\_target'] = final['sequence'].apply(normalise)

In [ ]:

Copied!

```
final.sample(5)
```

final.sample(5)

We use peptide-level metrics and especially recall to assess our models, the most direct evaluation of prediction performance. This is because bottom up proteomics is a peptide centric methodology; if the peptide is wrong, it does not matter what percentage of amino acids is wrong. Crucially, we evaluate whether the full prediction is correct.

The distribution of model confidence, defined as the product of our residue log probabilities raised in its natural exponent, indicates that the new model is sharper in its prediction certainty. We observe more high confidence predictions being correct, while lower confidence predictions are more densely clustered in the lower confidence range.

In [ ]:

Copied!

```
# let's start by plotting the confidence range as a kernel density plot for old and new knapsack
plt.figure(figsize=(10, 5))
sns.kdeplot(final['confidence_old_knapsack'], color=color_dict['old_knapsack'], label='Old Knapsack')
sns.kdeplot(final['confidence_new_knapsack'], color=color_dict['new_knapsack'], label='New Knapsack')
plt.xlabel('Confidence')
plt.ylabel('Density')
plt.legend(['IN v0.1 knapsack', 'IN v1.1 knapsack'], loc='upper right')
plt.title('Model confidence range')
sns.despine()
plt.show()
```

# let's start by plotting the confidence range as a kernel density plot for old and new knapsack
plt.figure(figsize=(10, 5))
sns.kdeplot(final['confidence\_old\_knapsack'], color=color\_dict['old\_knapsack'], label='Old Knapsack')
sns.kdeplot(final['confidence\_new\_knapsack'], color=color\_dict['new\_knapsack'], label='New Knapsack')
plt.xlabel('Confidence')
plt.ylabel('Density')
plt.legend(['IN v0.1 knapsack', 'IN v1.1 knapsack'], loc='upper right')
plt.title('Model confidence range')
sns.despine()
plt.show()

In [ ]:

Copied!

```
# let's do a stacked bar plot instead
plt.figure(figsize=(10, 5))
sns.histplot(final[['confidence_old_knapsack', 'confidence_new_knapsack']], bins=20, kde=False, multiple='stack', palette=[color_dict['old_knapsack'], color_dict['new_knapsack']])
plt.xlabel('Confidence')
plt.ylabel('Density')
plt.legend(['IN v0 knapsack', 'IN v1.1 knapsack', 'IN 1.1 greedy'])
plt.title('Model confidence range')
plt.show()
```

# let's do a stacked bar plot instead
plt.figure(figsize=(10, 5))
sns.histplot(final[['confidence\_old\_knapsack', 'confidence\_new\_knapsack']], bins=20, kde=False, multiple='stack', palette=[color\_dict['old\_knapsack'], color\_dict['new\_knapsack']])
plt.xlabel('Confidence')
plt.ylabel('Density')
plt.legend(['IN v0 knapsack', 'IN v1.1 knapsack', 'IN 1.1 greedy'])
plt.title('Model confidence range')
plt.show()

In [ ]:

Copied!

```
# let's do overlaid histograms instead
plt.figure(figsize=(10, 5))
sns.histplot(final['confidence_old_knapsack'], bins=20, kde=False, color=color_dict['old_knapsack'], alpha=0.5, label='Old Knapsack')
sns.histplot(final['confidence_new_knapsack'], bins=20, kde=False, color=color_dict['new_knapsack'], alpha=0.5, label='New Knapsack')
plt.xlabel('Confidence')
plt.ylabel('Density')
plt.legend(['IN v0 knapsack', 'IN v1.1 knapsack', 'IN 1.1 greedy'])
plt.title('Model confidence range')
plt.show()
```

# let's do overlaid histograms instead
plt.figure(figsize=(10, 5))
sns.histplot(final['confidence\_old\_knapsack'], bins=20, kde=False, color=color\_dict['old\_knapsack'], alpha=0.5, label='Old Knapsack')
sns.histplot(final['confidence\_new\_knapsack'], bins=20, kde=False, color=color\_dict['new\_knapsack'], alpha=0.5, label='New Knapsack')
plt.xlabel('Confidence')
plt.ylabel('Density')
plt.legend(['IN v0 knapsack', 'IN v1.1 knapsack', 'IN 1.1 greedy'])
plt.title('Model confidence range')
plt.show()

In [ ]:

Copied!

```
# let's do all three now with kde
plt.figure(figsize=(10, 5))
sns.kdeplot(final['confidence_old_knapsack'], color=color_dict['old_knapsack'], label='Old Knapsack', alpha=0.5)
sns.kdeplot(final['confidence_new_knapsack'], color=color_dict['new_knapsack'], label='New Knapsack', alpha=0.5)
sns.kdeplot(final['confidence_new_greedy'], color=color_dict['new_greedy'], label='New Greedy', alpha=0.5, linestyle='--', linewidth=3)
plt.xlabel('Confidence')
plt.ylabel('Density')
plt.legend()
plt.title('Model confidence range, density plot')
plt.legend(['IN v0.1 knapsack', 'IN v1.1 knapsack', 'IN 1.1 greedy'])
sns.despine()
plt.show()
```

# let's do all three now with kde
plt.figure(figsize=(10, 5))
sns.kdeplot(final['confidence\_old\_knapsack'], color=color\_dict['old\_knapsack'], label='Old Knapsack', alpha=0.5)
sns.kdeplot(final['confidence\_new\_knapsack'], color=color\_dict['new\_knapsack'], label='New Knapsack', alpha=0.5)
sns.kdeplot(final['confidence\_new\_greedy'], color=color\_dict['new\_greedy'], label='New Greedy', alpha=0.5, linestyle='--', linewidth=3)
plt.xlabel('Confidence')
plt.ylabel('Density'
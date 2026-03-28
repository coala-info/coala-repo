[ ]
[ ]

[Skip to content](#introducing-instanovo-p-a-de-novo-sequencing-model-for-phosphoproteomics)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

Introducing InstaNovo-P, a de novo sequencing model for phosphoproteomics

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
  + [Introducing the next generation of InstaNovo models](../introducing_the_next_generation_of_InstaNovo_models/)
  + [ ]

    Introducing InstaNovo-P, a de novo sequencing model for phosphoproteomics

    [Introducing InstaNovo-P, a de novo sequencing model for phosphoproteomics](./)

    Table of contents
    - [Announcing InstaNovo-P](#announcing-instanovo-p)
    - [Loading the InstaNovo-P model](#loading-the-instanovo-p-model)
    - [Loading the InstaNovo-P dataset](#loading-the-instanovo-p-dataset)
    - [Decoding](#decoding)

      * [Greedy Search and Beam Search](#greedy-search-and-beam-search)
      * [Knapsack Beam Search](#knapsack-beam-search)
    - [Inference time 🚀](#inference-time)

      * [Confidence probabilities](#confidence-probabilities)
      * [Evaluation](#evaluation)
      * [Evaluation metrics](#evaluation-metrics)
      * [We can find a threshold to ensure a desired FDR:](#we-can-find-a-threshold-to-ensure-a-desired-fdr)
      * [Saving the predictions...](#saving-the-predictions)
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

# Introducing InstaNovo-P, a de novo sequencing model for phosphoproteomics[¶](#introducing-instanovo-p-a-de-novo-sequencing-model-for-phosphoproteomics)

## Announcing InstaNovo-P[¶](#announcing-instanovo-p)

We are happy to share our newest model in the InstaNovo family, InstaNovo-P. [link to bioArxiv preprint]

InstaNovo-P is a fine-tuned version of our base model, InstaNovo v1.0.0, specifically tailored towards application in phosphoproteomics mass spectrometry experiments. InstaNovo-P was further trained on approx. 2.8 million PSMs from 75 thousand phosphorylated peptides. InstaNovo-P was extended to recognize the residues phospho-tyrosine, -serine and -threonine, achieving high accuracy in detecting phosphorylated peptides while retaining its performance in unmodified peptides.

## Loading the InstaNovo-P model[¶](#loading-the-instanovo-p-model)

We first install the latest version of `instanovo` from [PyPi](https://pypi.org/project/instanovo/) to be able to load the InstaNovo-P checkpoint.

In [ ]:

Copied!

```
import os
import sys
if 'google.colab' in sys.modules or 'KAGGLE_KERNEL_RUN_TYPE' in os.environ:
    # Suppress TensorFlow warnings
    os.environ['TF_CPP_MIN_LOG_LEVEL'] = '1'
    # Install torchvision when running on Google Colab to prevent errors
    !uv pip install --system "instanovo[cu124]>=1.1.2" pyopenms-viz torchvision tf-nightly
else:
    !uv pip install "instanovo[cu124]>=1.1.2" pyopenms-viz
```

import os
import sys
if 'google.colab' in sys.modules or 'KAGGLE\_KERNEL\_RUN\_TYPE' in os.environ:
# Suppress TensorFlow warnings
os.environ['TF\_CPP\_MIN\_LOG\_LEVEL'] = '1'
# Install torchvision when running on Google Colab to prevent errors
!uv pip install --system "instanovo[cu124]>=1.1.2" pyopenms-viz torchvision tf-nightly
else:
!uv pip install "instanovo[cu124]>=1.1.2" pyopenms-viz

We can use `instanovo version` to check the version of InstaNovo (the transformer-based model).

In [ ]:

Copied!

```
!instanovo version
```

!instanovo version

InstaNovo-P is a finetune of InstaNovo, so we import the transformer-based InstaNovo model.

In [ ]:

Copied!

```
from instanovo.transformer.model import InstaNovo
```

from instanovo.transformer.model import InstaNovo

Set the device to GPU if available (recommended), otherwise use CPU.

In [ ]:

Copied!

```
import torch

device = "cuda" if torch.cuda.is_available() else "cpu"
device
```

import torch
device = "cuda" if torch.cuda.is\_available() else "cpu"
device

InstaNovo supports automatic model downloads. You can see the IDs of the pretrained models that are available.

In [ ]:

Copied!

```
InstaNovo.get_pretrained()
```

InstaNovo.get\_pretrained()

We are now ready to download the InstaNovo-P checkpoint.

In [ ]:

Copied!

```
model, config = InstaNovo.from_pretrained('instanovo-phospho-v1.0.0')
model = model.to(device).eval()
```

model, config = InstaNovo.from\_pretrained('instanovo-phospho-v1.0.0')
model = model.to(device).eval()

## Loading the InstaNovo-P dataset[¶](#loading-the-instanovo-p-dataset)

Download the [test fold of the InstaNovo-P dataset](https://huggingface.co/datasets/InstaDeepAI/InstaNovo-P) dataset from HuggingFace.

Normally, we would use the InstaNovo SpectrumDataFrame class to download a dataset from Hugging Face directly like this:

```
from instanovo.utils import SpectrumDataFrame

sdf = SpectrumDataFrame.from_huggingface(
    "InstaDeepAI/InstaNovo-P",
    is_annotated=True,
    shuffle=False,
    split="test",
)
```

But this downloads the whole dataset and the train partition alone is more then 6 GB, so this would take a while. So we use `load_dataset` to only download the `test` partition.

In [ ]:

Copied!

```
from datasets import load_dataset

data_files = {"test": "dataset-phospho-test-0000-0001.parquet"}
dataset = load_dataset("InstaDeepAI/InstaNovo-P", data_files=data_files, split="test[:10%]")
dataset
```

from datasets import load\_dataset
data\_files = {"test": "dataset-phospho-test-0000-0001.parquet"}
dataset = load\_dataset("InstaDeepAI/InstaNovo-P", data\_files=data\_files, split="test[:10%]")
dataset

In [ ]:

Copied!

```
import pandas as pd
df = pd.DataFrame(dataset)
df
```

import pandas as pd
df = pd.DataFrame(dataset)
df

In [ ]:

Copied!

```
from instanovo.utils import SpectrumDataFrame
sdf = SpectrumDataFrame.from_pandas(df)
```

from instanovo.utils import SpectrumDataFrame
sdf = SpectrumDataFrame.from\_pandas(df)

In [ ]:

Copied!

```
import pandas as pd

pd.options.plotting.backend = "ms_matplotlib"
row = sdf[0]
row_df = pd.DataFrame({"mz": row["mz_array"], "intensity": row["intensity_array"]})
row_df.plot(
    kind="spectrum",
    x="mz",
    y="intensity",
    annotate_mz=True,
    bin_method="none",
    annotate_top_n_peaks=5,
    aggregate_duplicates=True,
    title=f"Mass spectrum of {row['sequence']}",
);
```

import pandas as pd
pd.options.plotting.backend = "ms\_matplotlib"
row = sdf[0]
row\_df = pd.DataFrame({"mz": row["mz\_array"], "intensity": row["intensity\_array"]})
row\_df.plot(
kind="spectrum",
x="mz",
y="intensity",
annotate\_mz=True,
bin\_method="none",
annotate\_top\_n\_peaks=5,
aggregate\_duplicates=True,
title=f"Mass spectrum of {row['sequence']}",
);

In [ ]:

Copied!

```
from instanovo.transformer.dataset import SpectrumDataset, collate_batch

ds = SpectrumDataset(
    sdf,
    model.residue_set,
    config.get("n_peaks", 200),
    return_str=True,
    annotated=True,
)
```

from instanovo.transformer.dataset import SpectrumDataset, collate\_batch
ds = SpectrumDataset(
sdf,
model.residue\_set,
config.get("n\_peaks", 200),
return\_str=True,
annotated=True,
)

In [ ]:

Copied!

```
from torch.utils.data import DataLoader

# When using SpectrumDataFrame, workers and shuffle is handled internally.
dl = DataLoader(ds, batch_size=64, shuffle=False, num_workers=0, collate_fn=collate_batch)
```

from torch.utils.data import DataLoader
# When using SpectrumDataFrame, workers and shuffle is handled internally.
dl = DataLoader(ds, batch\_size=64, shuffle=False, num\_workers=0, collate\_fn=collate\_batch)

In [ ]:

Copied!

```
batch = next(iter(dl))

spectra, precursors, spectra_mask, peptides, _ = batch
spectra = spectra.to(device)
precursors = precursors.to(device)
```

batch = next(iter(dl))
spectra, precursors, spectra\_mask, peptides, \_ = batch
spectra = spectra.to(device)
precursors = precursors.to(device)

## Decoding[¶](#decoding)

We have three options for decoding:

* Greedy Search
* Beam Search
* Knapsack Beam Search

For the best results and highest peptide recall, use **Knapsack Beam Search**.
For fastest results (over 10x speedup), use **Greedy Search**.

We generally use a beam size of 5 for Beam Search and Knapsack Beam Search, a higher beam size should increase recall at the cost of performance and vice versa.

*Note: in our findings, greedy search has similar performance as knapsack beam search at 5% FDR. I.e. if you plan to filter at 5% FDR anyway, use greedy search for optimal performance.*

### Greedy Search and Beam Search[¶](#greedy-search-and-beam-search)

Greedy search is used when `num_beams=1`, and beam search is used when `num_beams>1`

In [ ]:

Copied!

```
from instanovo.inference import BeamSearchDecoder, GreedyDecoder

num_beams = 1  # Change this, defaults are 1 or 5

if num_beams > 1:
    decoder = BeamSearchDecoder(model=model)
else:
    decoder = GreedyDecoder(model=model)
```

from instanovo.inference import BeamSearchDecoder, GreedyDecoder
num\_beams = 1 # Change this, defaults are 1 or 5
if num\_beams > 1:
decoder = BeamSearchDecoder(model=model)
else:
decoder = GreedyDecoder(model=model)

### Knapsack Beam Search[¶](#knapsack-beam-search)

Setup knapsack beam search decoder. This may take a few minutes.

In [ ]:

Copied!

```
from pathlib import Path
from instanovo.constants import MASS_SCALE
from instanovo.inference.knapsack import Knapsack
from instanovo.inference.knapsack_beam_search import KnapsackBeamSearchDecoder

num_beams = 5

def _setup_knapsack(model: InstaNovo) -> Knapsack:
    # Cannot allow negative masses in knapsack graph
    if "(-17.03)" in model.residue_set.residue_masses:
        model.residue_set.residue_masses["(-17.03)"] = 1e3
    if "[UNIMOD:385]" in model.residue_set.residue_masses:
        model.residue_set.residue_masses["[UNIMOD:385]"] = 1e3

    residue_masses = dict(model.residue_set.residue_masses.copy())
    if any(x < 0 for x in residue_masses.values()):
        raise NotImplementedError(
            "Negative mass found in residues, this will break the knapsack graph. "
            "Either disable knapsack or use strictly positive masses"
        )
    for special_residue in list(model.residue_set.residue_to_index.keys())[:3]:
        residue_masses[special_residue] = 0
    residue_indices = model.residue_set.residue_to_index
    return Knapsack.construct_knapsack(
        residue_masses=residue_masses,
        residue_indices=residue_indices,
        max_mass=4000.00,
        mass_scale=MASS_SCALE,
    )

knapsack_path = Path("./checkpoints/knapsack/phospho")

if not knapsack_path.exists():
    print("Knapsack path missing or not specified, generating...")
    knapsack = _setup_knapsack(model)
    decoder = KnapsackBeamSearchDecoder(model, knapsack)
    print(f"Saving knapsack to {knapsack_path}")
    knapsack_path.parent.mkdir(parents=True, exist_ok=True)
    knapsack.save(knapsack_path)
else:
    print("Knapsack path found. Loading...")
    decoder = KnapsackBeamSearchDecoder.from_file(model=model, path=knapsack_path)
```

from pathlib import Path
from instanovo.constants import MASS\_SCALE
from instanovo.inference.knapsack import Knapsack
from instanovo.inference.knapsack\_beam\_search import KnapsackBeamSearchDecoder
num\_beams = 5
def \_setup\_knapsack(model: InstaNovo) -> Knapsack:
# Cannot allow negative masses in knapsack graph
if "(-17.03)" in model.residue\_set.residue\_masses:
model.residue\_set.residue\_masses["(-17.03)"] = 1e3
if "[UNIMOD:385]" in model.residue\_set.residue\_masses:
model.residue\_set.residue\_masses["[UNIMOD:385]"] = 1e3
residue\_masses = dict(model.residue\_set.residue\_masses.copy())
if any(x < 0 for x in residue\_masses.values()):
raise NotImplementedError(
"Negative mass found in residues, this will break the knapsack graph. "
"Either disable knapsack or use strictly positive masses"
)
for special\_residue in list(model.residue\_set.residue\_to\_index.keys())[:3]:
residue\_masses[special\_residue] = 0
residue\_indices = model.residue\_set.residue\_to\_index
return Knapsack.construct\_knapsack(
residue\_masses=residue\_masses,
residue\_indices=residue\_indices,
max\_mass=4000.00,
mass\_scale=MASS\_SCALE,
)
knapsack\_path = Path("./checkpoints/knapsack/phospho")
if not knapsack\_path.exists():
print("Knapsack path missing or not specified, generating...")
knapsack = \_setup\_knapsack(model)
decoder = KnapsackBeamSearchDecoder(model, knapsack)
print(f"Saving knapsack to {knapsack\_path}")
knapsack\_path.parent.mkdir(parents=True, exist\_ok=True)
knapsack.save(knapsack\_path)
else:
print("Knapsack path found. Loading...")
decoder = KnapsackBeamSearchDecoder.from\_file(model=model, path=knapsack\_path)

## Inference time 🚀[¶](#inference-time)

Evaluating a single batch...

In [ ]:

Copied!

```
from instanovo.inference import ScoredSequence

with torch.no_grad():
    p = decoder.decode(
        spectra=spectra,
        precursors=precursors,
        beam_size=num_beams,
        max_length=config["max_length"],
    )

preds = [x.sequence if isinstance(x, ScoredSequence) else [] for x in p]
probs = [x.sequence_log_probability if isinstance(x, ScoredSequence) else -
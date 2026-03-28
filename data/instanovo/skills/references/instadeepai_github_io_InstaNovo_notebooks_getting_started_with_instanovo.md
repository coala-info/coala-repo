[ ]
[ ]

[Skip to content](#getting-started-with-instanovo)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

Getting started with InstaNovo

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
  + [ ]

    Getting started with InstaNovo

    [Getting started with InstaNovo](./)

    Table of contents
    - [Loading the InstaNovo model](#loading-the-instanovo-model)
    - [Loading the nine-species dataset](#loading-the-nine-species-dataset)
    - [Decoding](#decoding)

      * [Greedy Search and Beam Search](#greedy-search-and-beam-search)
      * [Knapsack Beam Search](#knapsack-beam-search)
    - [Inference time 🚀](#inference-time)

      * [Confidence probabilities](#confidence-probabilities)
      * [Evaluation](#evaluation)
      * [Evaluation metrics](#evaluation-metrics)
      * [We can find a threshold to ensure a desired FDR:](#we-can-find-a-threshold-to-ensure-a-desired-fdr)
      * [Saving the predictions...](#saving-the-predictions)
    - [InstaNovo+: Iterative Refinement with a Diffusion Model](#instanovo-iterative-refinement-with-a-diffusion-model)
  + [Introducing the next generation of InstaNovo models](../introducing_the_next_generation_of_InstaNovo_models/)
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

# Getting started with InstaNovo[¶](#getting-started-with-instanovo)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/instadeepai/InstaNovo/blob/main/notebooks/getting_started_with_instanovo.ipynb)

In this notebook, we demo InstaNovo, a transformer neural network with the ability to translate fragment ion peaks into the sequence of amino acids that make up the studied peptide(s). We evaluate the model on the yeast test fold of nine-species dataset.

![](https://raw.githubusercontent.com/instadeepai/InstaNovo/main/docs/assets/graphical_abstract.jpeg)

**Links:**

* Nature Machine Intelligence Paper: [**InstaNovo enables diffusion-powered de novo peptide sequencing in large-scale proteomics experiments**](https://www.nature.com/articles/s42256-025-01019-5)
  Kevin Eloff, Konstantinos Kalogeropoulos, Amandla Mabona, Oliver Morell, Rachel Catzel, Esperanza Rivera-de-Torre, Jakob Berg Jespersen, Wesley Williams, Sam P. B. van Beljouw, Marcin J. Skwark, Andreas Hougaard Laustsen, Stan J. J. Brouns, Anne Ljungars, Erwin M. Schoof, Jeroen Van Goey, Ulrich auf dem Keller, Karim Beguir, Nicolas Lopez Carranza, Timothy P. Jenkins
* Code: [GitHub](https://github.com/instadeepai/InstaNovo)

**Important:**

It is highly recommended to run this notebook in an environment with access to a GPU. If you are running this notebook in Google Colab:

* In the menu, go to `Runtime > Change Runtime Type > T4 GPU`

## Loading the InstaNovo model[¶](#loading-the-instanovo-model)

We first install the latest instanovo from PyPi

In [ ]:

Copied!

```
try:
  import instanovo
except ImportError:
  !uv pip install "instanovo[cu126]>=1.2.2" pyopenms-viz
  print('Installation complete. Restarting runtime to apply changes...')
  import os
  os.kill(os.getpid(), 9)
```

try:
import instanovo
except ImportError:
!uv pip install "instanovo[cu126]>=1.2.2" pyopenms-viz
print('Installation complete. Restarting runtime to apply changes...')
import os
os.kill(os.getpid(), 9)

In [ ]:

Copied!

```
# Filter warnings and set logging level
import warnings
import logging

warnings.filterwarnings("ignore", module="matplotlib")
warnings.filterwarnings("ignore", module="torch")
logging.getLogger("matplotlib").setLevel(logging.WARNING)
logging.getLogger("rdkit").setLevel(logging.WARNING)
```

# Filter warnings and set logging level
import warnings
import logging
warnings.filterwarnings("ignore", module="matplotlib")
warnings.filterwarnings("ignore", module="torch")
logging.getLogger("matplotlib").setLevel(logging.WARNING)
logging.getLogger("rdkit").setLevel(logging.WARNING)

We can use `instanovo version` to check the version of InstaNovo (the transformer-based model), InstaNovo+ (the diffusion-based model) and some of their dependencies.

In [ ]:

Copied!

```
!instanovo version
```

!instanovo version

Import the transformer-based InstaNovo model.

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

And download the model checkpoint given the ID.

In [ ]:

Copied!

```
model, config = InstaNovo.from_pretrained("instanovo-v1.2.0")
model = model.to(device).eval()
```

model, config = InstaNovo.from\_pretrained("instanovo-v1.2.0")
model = model.to(device).eval()

Alternatively, you can also download the model checkpoint directly from the [InstaNovo releases](https://github.com/instadeepai/InstaNovo/releases) page.

## Loading the nine-species dataset[¶](#loading-the-nine-species-dataset)

Download the [yeast test fold of the nine-species dataset](https://huggingface.co/datasets/InstaDeepAI/instanovo_ninespecies_exclude_yeast) dataset from HuggingFace.

We can use our SpectrumDataFrame to download this directly. SpectrumDataFrame is a special data class used by InstaNovo to read and write from multiple formats, including mgf, mzml, mzxml, pandas, polars, HuggingFace, etc.

In [ ]:

Copied!

```
from instanovo.utils.data_handler import SpectrumDataFrame

sdf = SpectrumDataFrame.from_huggingface(
    "InstaDeepAI/ms_ninespecies_benchmark",
    is_annotated=True,
    shuffle=False,
    split="test[:1%]",  # Let's only use a tiny subset of the test data for faster inference in this notebook
)
```

from instanovo.utils.data\_handler import SpectrumDataFrame
sdf = SpectrumDataFrame.from\_huggingface(
"InstaDeepAI/ms\_ninespecies\_benchmark",
is\_annotated=True,
shuffle=False,
split="test[:1%]", # Let's only use a tiny subset of the test data for faster inference in this notebook
)

In [ ]:

Copied!

```
sdf.to_pandas().head(5)
```

sdf.to\_pandas().head(5)

Let's quickly plot the spectrum in the first row

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

We include a residue remapping to ensure our input dataset can be mapped to the format the model vocabulary expects.

In [ ]:

Copied!

```
model.residue_set.update_remapping(
    {
        "M(ox)": "M[UNIMOD:35]",
        "M(+15.99)": "M[UNIMOD:35]",
        "S(p)": "S[UNIMOD:21]",  # Phosphorylation
        "T(p)": "T[UNIMOD:21]",
        "Y(p)": "Y[UNIMOD:21]",
        "S(+79.97)": "S[UNIMOD:21]",
        "T(+79.97)": "T[UNIMOD:21]",
        "Y(+79.97)": "Y[UNIMOD:21]",
        "Q(+0.98)": "Q[UNIMOD:7]",  # Deamidation
        "N(+0.98)": "N[UNIMOD:7]",
        "Q(+.98)": "Q[UNIMOD:7]",
        "N(+.98)": "N[UNIMOD:7]",
        "C(+57.02)": "C[UNIMOD:4]",  # Carboxyamidomethylation
        "(+42.01)": "[UNIMOD:1]",  # Acetylation
        "(+43.01)": "[UNIMOD:5]",  # Carbamylation
        "(-17.03)": "[UNIMOD:385]",
    }
)
```

model.residue\_set.update\_remapping(
{
"M(ox)": "M[UNIMOD:35]",
"M(+15.99)": "M[UNIMOD:35]",
"S(p)": "S[UNIMOD:21]", # Phosphorylation
"T(p)": "T[UNIMOD:21]",
"Y(p)": "Y[UNIMOD:21]",
"S(+79.97)": "S[UNIMOD:21]",
"T(+79.97)": "T[UNIMOD:21]",
"Y(+79.97)": "Y[UNIMOD:21]",
"Q(+0.98)": "Q[UNIMOD:7]", # Deamidation
"N(+0.98)": "N[UNIMOD:7]",
"Q(+.98)": "Q[UNIMOD:7]",
"N(+.98)": "N[UNIMOD:7]",
"C(+57.02)": "C[UNIMOD:4]", # Carboxyamidomethylation
"(+42.01)": "[UNIMOD:1]", # Acetylation
"(+43.01)": "[UNIMOD:5]", # Carbamylation
"(-17.03)": "[UNIMOD:385]",
}
)

In [ ]:

Copied!

```
from instanovo.transformer.data import TransformerDataProcessor

# HuggingFace dataset
ds = sdf.to_dataset(in_memory=True)

processor = TransformerDataProcessor(
    model.residue_set,
    reverse_peptide=False,
    return_str=True,
)

ds = processor.process_dataset(ds)
```

from instanovo.transformer.data import TransformerDataProcessor
# HuggingFace dataset
ds = sdf.to\_dataset(in\_memory=True)
processor = TransformerDataProcessor(
model.residue\_set,
reverse\_peptide=False,
return\_str=True,
)
ds = processor.process\_dataset(ds)

In [ ]:

Copied!

```
from torch.utils.data import DataLoader

# When using SpectrumDataFrame, workers and shuffle is handled internally.
dl = DataLoader(ds, batch_size=64, shuffle=False, collate_fn=processor.collate_fn)
```

from torch.utils.data import DataLoader
# When using SpectrumDataFrame, workers and shuffle is handled internally.
dl = DataLoader(ds, batch\_size=64, shuffle=False, collate\_fn=processor.collate\_fn)

In [ ]:

Copied!

```
batch = next(iter(dl))

batch = {k: v.to(device) if isinstance(v, torch.Tensor) else v for k, v in batch.items()}

peptides = batch["peptides"]
batch.keys()
```

batch = next(iter(dl))
batch = {k: v.to(device) if isinstance(v, torch.Tensor) else v for k, v in batch.items()}
peptides = batch["peptides"]
batch.keys()

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

num_beams = 5  # Change this, defaults are 1 or 5

if num_beams > 1:
    decoder = BeamSearchDecoder(model=model)
else:
    decoder = GreedyDecoder(model=model)
```

from instanovo.inference import BeamSearchDecoder, GreedyDecoder
num\_beams = 5 # Change this, defaults are 1 or 5
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

def _setup_knapsack(model: InstaNovo, max_isotope: int = 2) -> Knapsack:
    residue_masses = dict(model.residue_set.residue_masses.copy())
    for special_residue in list(model.residue_set.residue_to_index.keys())[:3]:
        residue_masses[special_residue] = 0
    residue_indices = model.residue_set.residue_to_index
    return Knapsack.construct_knapsack(
        residue_masses=residue_masses,
        residue_indices=residue_indices,
        max_mass=4000.0,
        mass_scale=MASS_SCALE,
        max_isotope=max_isotope,
    )

knapsack_path = Path("./checkpoints/knapsack/")

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
def \_setup\_knapsack(model: InstaNovo, max\_isotope: int = 2) -> Knapsack:
residue\_masses = dict(model.residue\_set.residue\_masses.copy())
for special\_residue in list(model.residue\_set.residue\_to\_index.keys())[:3]:
residue\_masses[speci
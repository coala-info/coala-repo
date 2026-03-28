[ ]
[ ]

[Skip to content](#for-developers)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

Set up a development environment

Initializing search

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](../..)
* [Tutorials](../../tutorials/getting_started/)
* [How-to guides](../../how-to/predicting/)
* [Reference](../../reference/cli/)
* [Explanation](../../explanation/performance/)
* [Blog](../../blog/introducing-the-next-generation-of-instanovo-models/)
* [For developers](./)
* [How to cite](../../citation/)
* [License](../../license/)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")
InstaNovo

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](../..)
* [ ]

  Tutorials

  Tutorials
  + [Quick overview](../../tutorials/getting_started/)
  + [Getting started with InstaNovo](../../notebooks/getting_started_with_instanovo/)
  + [Introducing the next generation of InstaNovo models](../../notebooks/introducing_the_next_generation_of_InstaNovo_models/)
  + [Introducing InstaNovo-P, a de novo sequencing model for phosphoproteomics](../../notebooks/InstaNovo-P/)
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
* [x]

  For developers

  For developers
  + [ ]

    Set up a development environment

    [Set up a development environment](./)

    Table of contents
    - [Setting up with uv](#setting-up-with-uv)

      * [Metal Performance Shaders](#metal-performance-shaders)
    - [Development workflows](#development-workflows)

      * [Testing](#testing)
      * [Linting](#linting)
      * [Building the documentation](#building-the-documentation)
  + [Test Coverage](../coverage/)
  + [Test Report](../allure/)
* [How to cite](../../citation/)
* [License](../../license/)

# For Developers

This guide is for developers who want to contribute to InstaNovo or set up a development environment.

InstaNovo is built for Python >=3.10, <3.14 and tested on Linux, Windows and macOS.

## Setting up with `uv`

This project uses [uv](https://docs.astral.sh/uv/) to manage Python dependencies.

1. **Install `uv`**: If you don't have `uv` installed, follow the [official installation instructions](https://docs.astral.sh/uv/getting-started/installation/).
2. **Fork and clone the repository**:

   ```
   git clone https://github.com/YOUR-USERNAME/InstaNovo.git
   cd InstaNovo
   ```
3. **Install dependencies**:

   If you have an NVIDIA GPU:

   ```
   uv sync --extra cu126
   uv run pre-commit install
   ```

   If you are on a CPU-only, or macOS machine:

   ```
   uv sync --extra cpu
   uv run pre-commit install
   ```

   To also install the documentation dependencies:

   ```
   uv sync --extra cu126 --group docs
   ```
4. **Activate the virtual environment**:

   ```
   source .venv/bin/activate
   ```

### Metal Performance Shaders

InstaNovo now has support for [Metal Performance Shaders](https://developer.apple.com/documentation/metalperformanceshaders) (MPS) for Apple silicon devices. If you would like to use InstaNovo with MPS, please set `mps` to True in the configuration files ([`instanovo/configs/`](https://github.com/instadeepai/InstaNovo/tree/main/instanovo/configs)) and set the environment variable:

```
PYTORCH_ENABLE_MPS_FALLBACK=1
```

This allows the CPU to be used for functionality not yet supported on MPS.

## Development workflows

### Testing

InstaNovo uses `pytest` for testing.

1. **Download test data**:

   ```
   uv run instanovo/scripts/get_zenodo_record.py
   ```
2. **Run tests**:

   ```
   python -m pytest --cov-report=html --cov --random-order --verbose .
   ```
3. **View coverage report**:

   ```
   python -m coverage report -m
   ```

### Linting

We use `pre-commit` hooks to maintain code quality. To run the linters on all files:

```
pre-commit run --all-files
```

### Building the documentation

To build and serve the documentation locally:

```
uv sync --extra cu126 --group docs
git config --global --add safe.directory "$(dirname "$(pwd)")"
rm -rf docs/API
python ./docs/gen_ref_nav.py
mkdocs build --verbose --site-dir docs_public
mkdocs serve
```

Back to top

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
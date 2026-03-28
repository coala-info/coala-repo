### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index")
* [next](config.html "Configuration")
* [previous](index.html "YMP - a Flexible Omics Pipeline")
* [YMP Extensible Omics Pipeline 0.2.1 documentation](index.html) »
* Installing and Updating YMP

# Installing and Updating YMP[¶](#installing-and-updating-ymp "Permalink to this headline")

## Working with the Github Development Version[¶](#working-with-the-github-development-version "Permalink to this headline")

### Installing from GitHub[¶](#installing-from-github "Permalink to this headline")

1. Clone the repository:

   ```
   git clone  --recurse-submodules https://github.com/epruesse/ymp.git
   ```

   Or, if your have github ssh keys set up:

   ```
   git clone --recurse-submodules git@github.com:epruesse/ymp.git
   ```
2. Create and activate conda environment:

   ```
   conda env create -n ymp --file environment.yaml
   source activate ymp
   ```
3. Install YMP into conda environment:

   ```
   pip install -e .
   ```
4. Verify that YMP works:

   ```
   source activate ymp
   ymp --help
   ```

### Updating Development Version[¶](#updating-development-version "Permalink to this headline")

Usually, all you need to do is a pull:

```
git pull
git submodule update --recursive --remote
```

If environments where updated, you may want to regenerate the local
installations and clean out environments no longer used to save disk
space:

```
source activate ymp
ymp env update
ymp env clean
# alternatively, you can just delete existing envs and let YMP
# reinstall as needed:
# rm -rf ~/.ymp/conda*
conda clean -a
```

If you see errors before jobs are executed, the core requirements may
have changed. To update the YMP conda environment, enter the folder
where you installed YMP and run the following:

```
source activate ymp
conda env update --file environment.yaml
```

If something changed in `setup.py`, a re-install may be necessary:

```
source activate ymp
pip install -U -e .
```

### Quick search

### [Table of Contents](contents.html)

* [Front Page](index.html)
* Installing and Updating YMP
  + [Working with the Github Development Version](#working-with-the-github-development-version)
    - [Installing from GitHub](#installing-from-github)
    - [Updating Development Version](#updating-development-version)
* [Configuration](config.html)
* [Command Line](commandline.html)
* [Stages](stages.html)
* [API](modules.html)

«
hide menu

menu
sidebar
»

### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index")
* [next](config.html "Configuration")
* [previous](index.html "YMP - a Flexible Omics Pipeline")
* [YMP Extensible Omics Pipeline 0.2.1 documentation](index.html) »
* Installing and Updating YMP

© Copyright 2017-2018, Elmar Pruesse.
Created using [Sphinx](https://www.sphinx-doc.org/) 3.2.1.
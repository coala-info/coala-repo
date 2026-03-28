[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

PANORAMA just released!

[![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)
![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)

PANORAMA](../index.html)

* [User Documentation](../user/user_guide.html)
* [Modeler Documentation](modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* More
  + [PANORAMA](https://github.com/labgem/PANORAMA)
  + [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
  + [LABGeM](https://labgem.genoscope.cns.fr/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Search
`Ctrl`+`K`

* [User Documentation](../user/user_guide.html)
* [Modeler Documentation](modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* [PANORAMA](https://github.com/labgem/PANORAMA)
* [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
* [LABGeM](https://labgem.genoscope.cns.fr/)

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Section Navigation

Get Started:

* [PANORAMA Models Overview 🔭](overview.html)
* [PANORAMA System Modeling](modeling.html)
* PANORAMA – Model Translation Guide

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [Modeler Documentation](modeler_guide.html)
* PANORAMA – Model Translation Guide

# PANORAMA – Model Translation Guide[#](#panorama-model-translation-guide "Link to this heading")

The model translation module in PANORAMA allows you to convert system detection models from other tools into the
PANORAMA format.
Also, it will prepare all required input files, so they can be used directly for annotation and analysis in PANORAMA.

**Supported Sources**

* PADLOC (e.g., antiviral defense systems),
* MacSyFinder-based tools like:

  + DefenseFinder (e.g., restriction-modification, retrons, etc.),
  + CASFINDER ()
  + CONJScan (conjugative systems),
  + TXSScan (type secretion systems),
  + TFFScan (type IV pili),

## When should you use it?[#](#when-should-you-use-it "Link to this heading")

Important

Translated and updated versions of models are already available [here](https://github.com/PANORAMA-models).

1. When a new version exists, and it’s not yet available on [PANORAMA models](https://github.com/PANORAMA-models),
2. When you want to use a specif version, not available on [PANORAMA models](https://github.com/PANORAMA-models)
3. When you have your own version of models that use the same grammar as supported sources.

## What do you need?[#](#what-do-you-need "Link to this heading")

You should have:

| Tool/Source | HMM profiles | models | metadata |
| --- | --- | --- | --- |
| PADLOC | Hidden Markov Model profiles (.hmm) | Models in YAML format (.yaml) | File containing HMM information (.txt) |
| MacSyModel (or like) | Hidden Markov Model profiles (.hmm) | Models in XML format (.xml) |  |

## How to run it?[#](#how-to-run-it "Link to this heading")

Use the command line interface (CLI):

```
panorama utils \
--translate /path/to/models_directory \
--source name_of_the_source \
--output /path/to/output_directory \
--binary \
--hmm_coverage 0.6 \
--target_coverage 0.8
```

### Key options[#](#key-options "Link to this heading")

| Parameter | Type | Description |
| --- | --- | --- |
| `--translate` | Required | The folder with PADLOC, DefenseFinder or MacSyFinder models. |
| `--source` | Required | One of the following: padloc, defense-finder, CONJScan, TXSScan, TFFscan. |
| `--output` | Required | Where you want PANORAMA to save its output. |
| `--binary` | Optional | Use this to speed up annotations (recommended). |
| `--hmm_coverage` | Optional | Thresholds for alignment coverage on HMM |
| `--target_coverage` | Optional | Thresholds for alignment coverage on target. |

Tip

Defense Finder and PADLOC use different threshold for the HMM and the target coverage.
Defense Finder use 0.4 for HMM and 0 for target for all profiles.
PADLOC define in the metadata a specific threshold for each profile.
This default behavior is tunable with the `--hmm_coverage` and `--target_coverage` options
that will affect a threshold for all profiles.

## What files are created?[#](#what-files-are-created "Link to this heading")

After translation, you’ll get:

* **models/**: All models in PANORAMA .json format,
* **models\_list.tsv**: A list of all translated models,
* **hmm/**: All HMM profile compatible with the hmm\_list TSV file, binary or not,
* **hmm\_list.tsv**: A list of all hmm with the metadata needed for the annotation.

These files can be used directly in PANORAMA commands.

## Example[#](#example "Link to this heading")

### Translate PADLOC[#](#translate-padloc "Link to this heading")

```
git clone https://github.com/padlocbio/padloc-db.git
mkdir padloc_translate
panorama utils \
--translate padloc-db/ \
--source padloc \
--output padloc_translate/ \
--binary
```

Tip

PANORAMA automatically find all required files on its own, as the structure is already known.

### Translate DefenseFinder[#](#translate-defensefinder "Link to this heading")

```
git clone https://github.com/mdmparis/defense-finder-models.git
mkdir dfinder_translate
panorama utils \
--translate defense-finder-models/ \
--source defense-finder \
--output dfinder_translate/ \
--binary
```

Note

Defense Finder team as the tendency to reorganize the repository.
If you’re trying to translate a new version this could not work.
In this case report an issue [here](https://github.com/PANORAMA-models/Defense-Finder)

[previous

PANORAMA System Modeling](modeling.html "previous page")
[next

Developer documentation](../developer/developer_guide.html "next page")

On this page

* [When should you use it?](#when-should-you-use-it)
* [What do you need?](#what-do-you-need)
* [How to run it?](#how-to-run-it)
  + [Key options](#key-options)
* [What files are created?](#what-files-are-created)
* [Example](#example)
  + [Translate PADLOC](#translate-padloc)
  + [Translate DefenseFinder](#translate-defensefinder)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/modeler/translate.md)

### This Page

* [Show Source](../_sources/modeler/translate.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.
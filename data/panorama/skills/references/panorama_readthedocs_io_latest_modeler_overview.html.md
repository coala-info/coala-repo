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

* PANORAMA Models Overview 🔭
* [PANORAMA System Modeling](modeling.html)
* [PANORAMA – Model Translation Guide](translate.html)

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [Modeler Documentation](modeler_guide.html)
* PANORAMA Models Overview 🔭

# PANORAMA Models Overview 🔭[#](#panorama-models-overview "Link to this heading")

PANORAMA detects macromolecular systems in pangenomes using user-defined models. These models are an exhaustive and
specific representation of a system. They describe the presence/absence rules of protein families constituting a
system, how they are organized in genomes, and what genomic constraints govern their presence.

System models are written in JSON and provide a flexible, hierarchical structure that captures both essential and
optional elements of complex systems.

---

## Definition and Purpose 🧭[#](#definition-and-purpose "Link to this heading")

A **system model** in PANORAMA serves two main purposes:

1. **Represent the system in a unique way**
   Models specify which protein families are required, optional, or excluded for a given system.
2. **Guide the detection process**
   The model governs how PANORAMA searches for gene co-occurrence and proximity in the pangenome context graph.

Models allow users to capture:

* Core and variable components of a system,
* Modular architecture (via *Functional Units*),
* Flexible quorum rules,
* Genome organization constraints (e.g., clustering, strand consistency),
* Inhibitory or exchangeable elements.

---

## Structure (Brief)[#](#structure-brief "Link to this heading")

Each model file is a single JSON object composed of:

* **`name`**: The system’s identifier.
* **`parameters`**: Detection parameters at the model level (e.g., quorum, transitivity).
* **`func_units`**: A list of *Functional Units* (modules), each of which groups multiple **protein families**.

The structure is hierarchical:

```
Model
├── FunctionalUnit
│ ├── Family
│ └── ...
├── FunctionalUnit
│ ├── Family
│ └── ...
```

Each **Functional Unit** and **Family** has a `presence` type (`mandatory`, `accessory`, `neutral`, `forbidden`) that
governs how it contributes to system detection.

Detection rules are defined at **both the model level** and the **functional unit level**, using parameters such as:

* `min_mandatory`
* `min_total`
* `transitivity`
* `same_strand`

For full details, see:

* [Model structure](modeling.html#-model-structure)
* [Presence Types](modeling.html#presence-types-explained)
* [Detection rules](modeling.html#-detection-parameters)

---

## PANORAMA models gallery 🎨[#](#panorama-models-gallery "Link to this heading")

All existing PANORAMA models are available on the [PANORAMA models repository](https://github.com/PANORAMA-models).

Most of them are directly translated from different sources, such as [PADLOC](https://github.com/padlocbio/padloc) or
[MacSyFinder](https://github.com/gem-pasteur/macsyfinder).

We welcome contributions and would like to provide PANORAMA users with a variety of models for a multitude of analyses.
You can contribute to the creation of new models by following the guide
[here](contribute.html#how-to-contribute-to-panorama-models).

## Translate models[#](#translate-models "Link to this heading")

PANORAMA can translate several sources (see [PANORAMA models repository](https://github.com/PANORAMA-models)).

We ary trying to keep our models updated. But in case we miss it,
you can translate the model yourself with `panorama utils --translate` command.
Look here for more information: [PANORAMA – Model Translation Guide](translate.html)

[previous

Modeler Documentation](modeler_guide.html "previous page")
[next

PANORAMA System Modeling](modeling.html "next page")

On this page

* [Definition and Purpose 🧭](#definition-and-purpose)
* [Structure (Brief)](#structure-brief)
* [PANORAMA models gallery 🎨](#panorama-models-gallery)
* [Translate models](#translate-models)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/modeler/overview.md)

### This Page

* [Show Source](../_sources/modeler/overview.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.
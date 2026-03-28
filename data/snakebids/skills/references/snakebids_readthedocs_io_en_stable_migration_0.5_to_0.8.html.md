Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[Snakebids 0.15.0 documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[Snakebids 0.15.0 documentation](../index.html)

User Guide

* [Why use snakebids?](../general/why_snakebids.html)
* [Tutorial](../tutorial/tutorial.html)
* [Bids Function](../bids_function/overview.html)
* [Bids Apps](../bids_app/overview.html)[ ]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](index.html)[x]

Reference

* [API](../api/main.html)[ ]
* [Internals](../api/internals.html)
* [Plugins](../api/plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/migration/0.5_to_0.8.md?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/migration/0.5_to_0.8.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# 0.5 to 0.8+[¶](#to-0-8 "Link to this heading")

Note

Be sure to also [migrate](0.11_to_0.12.html) your `run.py` file to the new snakebids 0.12 syntax!

Starting in version 0.8, [`snakebids.generate_inputs()`](../api/creation.html#snakebids.generate_inputs "snakebids.generate_inputs") returns a [`BidsInputs`](../api/structures.html#snakebids.BidsDataset "snakebids.BidsDataset") object instead of a [`dict`](../api/structures.html#snakebids.BidsDatasetDict "snakebids.BidsDatasetDict"). This requires a change in the way info is accessed. The previous [`dict`](../api/structures.html#snakebids.BidsDatasetDict "snakebids.BidsDatasetDict") had top-level keys such as `"input_lists"`. After selecting such a key, you would pass the name of a component to get the information sought:

```
1config.update(snakebids.generate_inputs(
2    bids_dir=config['bids_dir'],
3    pybids_inputs=config['pybids_inputs'],
4    use_bids_inputs=False,
5))
6
7config["input_lists"]["t1w"]
```

Now, the components are top level keys, and the type of property being requested is accessed using an attribute:

```
1inputs = snakebids.generate_inputs(
2    bids_dir=config['bids_dir'],
3    pybids_inputs=config['pybids_inputs'],
4)
5
6inputs["t1w"].entities
```

Note that the old behaviour can still be achieved by setting `use_bids_inputs=False`, as shown in the above example. However, we encourage all users to upgrade to take advantage of all the new features Snakebids has to offer.

## 1. Assign [`generate_inputs()`](../api/creation.html#snakebids.generate_inputs "snakebids.generate_inputs") to a variable called `inputs`[¶](#assign-generate-inputs-to-a-variable-called-inputs "Link to this heading")

Because [`generate_inputs()`](../api/creation.html#snakebids.generate_inputs "snakebids.generate_inputs") no longer returns a dict, you cannot use it to update `config`, as was previously recommended. The new best practice is to assign its return to a variable called `inputs`:

```
1inputs = snakebids.generate_inputs(
2    bids_dir=config['bids_dir'],
3    pybids_inputs=config['pybids_inputs'],
4)
```

## 2. Change references to `config`[¶](#change-references-to-config "Link to this heading")

All references to `config['<attr>']['<comp>']`, where `<attr>` is one of `'input_path'`, `'input_zip_lists'`, `'input_lists'`, or `'input_wildcards'`, must be updated to `input['<comp>'].<attr>`. The following regexes may be helpful for search and replace:

```
# match
config\[([\x22\x27])(input_path|input_zip_lists|input_lists|input_wildcards)\1\]\[([\x22\x27])(\w+)\3\]

# replace
inputs["\4"].\2
```

In addition, all references to `config['<attr>']` where `<attr>` is one of `'sessions'`, `'subjects'`, or `'subj_wildcards'` must be updated to `input.<attr>`. The following regexes may be helpful:

```
# match
config\[([\x22\x27])(sessions|subjects|subj_wildcards)\1\]

# replace
inputs.\2
```

## 3. Update attribute names into modern forms[¶](#update-attribute-names-into-modern-forms "Link to this heading")

Although the previous attribute names are being kept around as aliases, we recommend you update to the more modern, sleeker equivalents. Replacements should be made according to the following table:

* `input_path` -> [`path`](../api/structures.html#snakebids.BidsComponent.path "snakebids.BidsComponent.path")
* `input_lists` -> [`entities`](../api/structures.html#snakebids.BidsComponent.entities "snakebids.BidsComponent.entities")
* `input_zip_lists` -> [`zip_lists`](../api/structures.html#snakebids.BidsComponent.zip_lists "snakebids.BidsComponent.zip_lists")
* `input_wildcards` -> [`wildcards`](../api/structures.html#snakebids.BidsComponent.wildcards "snakebids.BidsComponent.wildcards")

## 4. Switch to [`expand()`](../api/structures.html#snakebids.BidsComponent.expand "snakebids.BidsComponent.expand") method[¶](#switch-to-expand-method "Link to this heading")

Calls to snakemake’s [`expand()`](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#snakefiles-expand "Snakemake 9.13.7") should be replaced with the new [`expand()`](../api/structures.html#snakebids.BidsComponent.expand "snakebids.BidsComponent.expand") method available on [`BidsComponent`](../api/structures.html#snakebids.BidsComponent "snakebids.BidsComponent"). See [the section](0.7_to_0.8.html#migration-expand-func) in 0.7-0.8 migration guide for more details.

[Next

0.7 to 0.8+](0.7_to_0.8.html)
[Previous

Migrations](index.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* 0.5 to 0.8+
  + [1. Assign `generate_inputs()` to a variable called `inputs`](#assign-generate-inputs-to-a-variable-called-inputs)
  + [2. Change references to `config`](#change-references-to-config)
  + [3. Update attribute names into modern forms](#update-attribute-names-into-modern-forms)
  + [4. Switch to `expand()` method](#switch-to-expand-method)
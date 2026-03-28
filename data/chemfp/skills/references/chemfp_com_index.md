# [chemfp](https://chemfp.com/index.html)

* [Features](https://chemfp.com/features/)
* [Download](https://chemfp.com/download/)
* [Datasets](https://chemfp.com/datasets/)
* [License](https://chemfp.com/license/)
* [News](https://chemfp.com/news/)
* [Contact](https://chemfp.com/contact/)

* [High Performance Search](/performance/)
* [FPS Format](/fps_format/)
* [FPB Format](/fpb_format/)
* [FPC Format](/fpc_format/)
* [• Datasets](/datasets/)
* [Multiple Toolkit Support](/toolkits/)
* [Documentation:](/docs/)
* [• Command-line Tools](/docs/tools.html)
* [• Python API](/docs/chemfp_api.html)
* [• Example Programs](https://hg.sr.ht/~dalke/chemfp_examples)

## A fast and comprehensive Python package for cheminformatics fingerprints.

chemfp is the package you’ve been looking for, if you work with binary
cheminformatics fingerprints in Python.

**NEW!** Chemfp 5.0b1 was released on 20 February 2026. See [the
documentation](/docs/whats_new_in_51.html) for the full list of
notable changes. To try the beta release for Linux:

```
python -m pip install chemfp==5.1b1 -i https://chemfp.com/packages/
```

Chemfp 5.0 was released on 24 September 2025. See [the
documentation](/docs/whats_new_in_50.html) or go to the [download page](/download/). To install 5.0 for Linux:

```
python -m pip install chemfp -i https://chemfp.com/packages/
```

Chemfp is perhaps best known for its high-performance
[fingerprint similarity search](/docs/tools.html#simsearch-knearest-search).
Its
[Taylor/Butina clustering](/docs/tools.html#chemfp-butina-intro),
[MaxMin diversity selection](/docs/tools.html#chemfp-maxmin-intro), and
[sphere exclusion](/docs/tools.html#chemfp-spherex-intro), (including
[directed sphere exclusion](/docs/tools.html#chemfp-spherex-dise-intro))
are equally world-class, and in some cases more than an order of
magnitude faster than its competitors. Or, if you simply need a 100K
by 100K distance array to pass into scikit-learn, chemfp’s
[simarray](docs/tools.html#chemfp-simarray-intro)
can generate that in less than a minute.

All of that functionality is available using
[command-line tools](/docs/tool_help.html#tool-help) or,
for those who need more customization, through a
[comprehensive Python API](/docs/chemfp_toplevel.html).
Research scientists and IT developers will both enjoy chemfp’s
extensive integration with NumPy, SciPy, and Pandas.

Do you want to evaluate the effectiveness of different fingerprint
types? No other system has built-in support for
[RDKit](/docs/tools.html#chemfp-rdkit2fps-intro),
[OEChem/OEGraphSim](/docs/tools.html#chemfp-oe2fps-intro)
[CDK](/docs/tools.html#chemfp-cdk2fps-intro),
[Open Babel](/docs/tools.html#chemfp-ob2fps-intro), and
[jCompoundMapper](/docs/whats_new_in_42.html#whats-new-jcompoundmapper) fingerprints,
or you can import your own fingerprints using the text-based
[FPS format](/fps_format/).
Chemfp even includes tools to extract fingerprints from
[SDF tag data](/docs/tools.html#pubchem-fingerprints)
extract or process fields from
[CSV columns](/docs/tools.html#chemfp-csv2fps-intro).

If you have sparse count fingerprints in [FPC
format](/fpc_format/) and convert them to binary fingerprints using
one of [several methods](/docs/count_tools.html#chemfp-fpc2fps-intro),
or you can [use RDKit to generate sparse
fingerprints](/docs/rdkit2fps_command.html).

Do you want to develop your own analysis methods? Let chemfp handle
fingerprint generation and
[file I/O](/docs/getting_started_api.html#load-fingerprints-intro)
and give you a
[NumPy view of the fingerprint
data](/docs/chemfp_arena.html#chemfp.arena.FingerprintArena.to_numpy_array).
You can also build on chemfp’s own components,
including its
[cross-toolkit wrapper API](/docs/toolkit.html)
for molecule I/O and its
[text toolkit](docs/text_toolkit.html#text-toolkit-chapter)
for processing SDF and SMILES files directly as text records. There
are also functions for
[sampling](/docs/chemfp_arena.html#chemfp.arena.FingerprintArena.sample),
[histogram generation](/docs/getting_started_api.html#direct-histogram-generation),
and more.

At its heart, chemfp is a Python library, designed to be a component
in a larger system. Do you need to add similarity search to a Django
component? Create a Jupyter widget? Write a desktop application GUI
with PyQt? If you can “import chemfp” then all those are possible.

Its market-leading performance and comprehensive API make it easy for
you to add fast similarity search and fingerprint analysis components
anywhere you use Python.

### Licensed for long-term integration

The chemfp source license gives you the assurance that you can embed
chemfp in your systems and workflows while minimizing long-term risk.
We all know stories about how a license key expired unexpectedly
causing the software to stop working, or about vendors changing their
pricing model to extract more revenue, because they know that changing
vendors would be more expensive.

With chemfp, if you purchase the unlimited source code license, you
get the full source code (except for the license manager) plus a year
of support, which includes no-cost updates for any new releases during
that time. Most customers opt to renew support, but even if you do
not, you may continue to use chemfp, and even modify and maintain it
on your own.

Time-limited and binary-only licensing are also available, which may
be a better fit for a small research group or for short-term
projects.

### If that sounds interesting

You can get started by downloading the pre-compiled Linux version of
chemfp using the following:

```
python -m pip install chemfp -i https://chemfp.com/packages/
```

A few features are either limited or disabled. Visit the
[licensing](/license/) page to see the licensing terms, to
request an evaluation key to unlock those features, and learn about
some of the available licensing options.

You do not need to request a license key for Tanimoto searches of the
licensed FPB files available from the [datasets](/datasets/) page, so
long as you follow the terms of the
[Chemfp Base License Agreement](/BaseLicense.txt).

### More information

Chemfp includes
[extensive documentation](/docs/).
For a more scholarly description, see: Dalke,
A. [The chemfp project](https://jcheminf.biomedcentral.com/articles/10.1186/s13321-019-0398-8). J.
Cheminformatics 11, 76 (2019). [doi: 10.1186/s13321-019-0398-8](https://doi.org/10.1186/s13321-019-0398-8)

### Open source reference baseline for benchmarking

Chemfp 1.6.1 is the latest version of the no-cost/open source chemfp
development track. It only supports Python 2.7. It is being maintained
in order to provide a good reference baseline to evaluate similarity
search performance, and to support the dwindling number of legacy
users who haven't moved to Python 3. See the
[download page](/download/#chemfp-1x) for download details.

Copyright © 2012-2025 Andrew Dalke Scientific AB
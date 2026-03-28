[fuc](index.html)

latest

Contents:

* [README](readme.html)
* [Glossary](glossary.html)
* [CLI](cli.html)
* [API](api.html)
* Tutorials
  + [Visualization of structural variation with VCF](#visualization-of-structural-variation-with-vcf)
  + [Create customized oncoplots](#create-customized-oncoplots)
  + [Control plot colors](#control-plot-colors)
* [Changelog](changelog.html)

[fuc](index.html)

* Tutorials
* [Edit on GitHub](https://github.com/sbslee/fuc/blob/main/docs/tutorials.rst)

---

# Tutorials[](#tutorials "Permalink to this heading")

## Visualization of structural variation with VCF[](#visualization-of-structural-variation-with-vcf "Permalink to this heading")

It is possible to visualize structural variation (SV) using VCF data ([`vcf_sv.py`](_downloads/b8b73dd5e544621ff9dc717cf79e952a/vcf_sv.py)):

![https://raw.githubusercontent.com/sbslee/fuc-data/main/images/vcf_sv.png](https://raw.githubusercontent.com/sbslee/fuc-data/main/images/vcf_sv.png)

## Create customized oncoplots[](#create-customized-oncoplots "Permalink to this heading")

We can use either the **maf\_oncoplt** command or the `pymaf.plot_oncoplot()` method to create a “standard” oncoplot like the one shown below.

![https://raw.githubusercontent.com/sbslee/fuc-data/main/images/oncoplot.png](https://raw.githubusercontent.com/sbslee/fuc-data/main/images/oncoplot.png)

While the plot is pleasing to the eye, one may wish to customize it to add, for example, various annotation data for the samples like this:

![https://raw.githubusercontent.com/sbslee/fuc-data/main/images/customized_oncoplot_1.png](https://raw.githubusercontent.com/sbslee/fuc-data/main/images/customized_oncoplot_1.png)

We can (relatively) easily achieve above thanks to the LEGO block-like plotting methods in the `pymaf` submodule ([`customized_oncoplot_1.py`](_downloads/190ef599ae4ffb09218e22953f63458f/customized_oncoplot_1.py)).

We can go one step further and sort the samples by one or more annotations ([`customized_oncoplot_2.py`](_downloads/fce9af4ab57976ec36350cef4617772b/customized_oncoplot_2.py)):

![https://raw.githubusercontent.com/sbslee/fuc-data/main/images/customized_oncoplot_2.png](https://raw.githubusercontent.com/sbslee/fuc-data/main/images/customized_oncoplot_2.png)

Finally, we can also subset the samples with annotation data ([`customized_oncoplot_3.py`](_downloads/af86cf5eb0c6860edf0e70d706829890/customized_oncoplot_3.py)):

![https://raw.githubusercontent.com/sbslee/fuc-data/main/images/customized_oncoplot_3.png](https://raw.githubusercontent.com/sbslee/fuc-data/main/images/customized_oncoplot_3.png)

## Control plot colors[](#control-plot-colors "Permalink to this heading")

Let us consider the [`fuc.api.pymaf.MafFrame.plot_snvclsc()`](api.html#fuc.api.pymaf.MafFrame.plot_snvclsc "fuc.api.pymaf.MafFrame.plot_snvclsc") method as an example. The method internally uses `seaborn.barplot()` to draw bar plots.

```
from fuc import common, pymaf
common.load_dataset('tcga-laml')
maf_file = '~/fuc-data/tcga-laml/tcga_laml.maf.gz'
mf = pymaf.MafFrame.from_file(maf_file)
mf.plot_snvclsc()
```

![_images/tutorials-1.png](_images/tutorials-1.png)

In order to change the colors according to one of the [seaborn palettes](https://seaborn.pydata.org/generated/seaborn.color_palette.html#seaborn.color_palette) (e.g. ‘deep’, ‘muted’, ‘pastel’), we can use the `palette` option:

```
import seaborn as sns
mf.plot_snvclsc(palette='pastel')
```

![_images/tutorials-2.png](_images/tutorials-2.png)

To choose one of the [colormaps available in maplotlib](https://matplotlib.org/stable/tutorials/colors/colormaps.html) (e.g. ‘tab10’, ‘Dark2’, ‘Pastel1’), we can use the `palette` option with `seaborn.color_palette()`:

```
mf.plot_snvclsc(palette=sns.color_palette('Pastel1'))
```

![_images/tutorials-3.png](_images/tutorials-3.png)

Some plotting methods use maplotlib instead of seaborn for coloring, like the [`fuc.api.pymaf.MafFrame.plot_snvclss()`](api.html#fuc.api.pymaf.MafFrame.plot_snvclss "fuc.api.pymaf.MafFrame.plot_snvclss") method:

```
ax = mf.plot_snvclss(width=1)
ax.legend(loc='upper right')
```

![_images/tutorials-4.png](_images/tutorials-4.png)

To choose a colormap from maplotlib:

```
import matplotlib.pyplot as plt
ax = mf.plot_snvclss(width=1, color=plt.get_cmap('Pastel1').colors)
ax.legend(loc='upper right')
```

![_images/tutorials-5.png](_images/tutorials-5.png)

To choose a palette from seaborn:

```
ax = mf.plot_snvclss(width=1, color=sns.color_palette('pastel'))
ax.legend(loc='upper right')
```

![_images/tutorials-6.png](_images/tutorials-6.png)

[Previous](api.html "API")
[Next](changelog.html "Changelog")

---

© Copyright 2021, Seung-been "Steven" Lee.
Revision `7b0fbfbd`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).
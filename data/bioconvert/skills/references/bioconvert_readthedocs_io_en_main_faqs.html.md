[bioconvert
![Logo](_static/logo.png)](index.html)

* [1. Installation](installation.html)
* [2. User Guide](user_guide.html)
* [3. Tutorial](tutorial.html)
* [4. Developer guide](developer_guide.html)
* [5. Benchmarking](benchmarking.html)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
* [8. Formats](formats.html)
* [9. Glossary](glossary.html)
* 10. Faqs
  + [10.1. Installation](#installation)
    - [10.1.1. Plink](#plink)
  + [10.2. Libraries](#libraries)
    - [10.2.1. Graphviz related](#graphviz-related)
* [11. Bibliography](bibliography.html)

[bioconvert](index.html)

* 10. Faqs
* [View page source](_sources/faqs.rst.txt)

---

# 10. Faqs[](#faqs "Link to this heading")

## 10.1. Installation[](#installation "Link to this heading")

On **ubuntu**, you need libz-dev and python3-dev libraries which are not necessarily present by default:

```
sudo apt-get install libz-dev python3-dev
```

### 10.1.1. Plink[](#plink "Link to this heading")

If you have installed plink1.9 but **bioconvert** still can not use plink. It is maybe because
**bioconvert** try to call the programme by the name “plink” so you have to make a symbolic link.
First, you have to go in the repository where is plink, then use the command which:

```
which plink1.9
```

go into the repository then:

```
ln -s plink1.9 plink
```

after this bioconvert will be able to call plink

## 10.2. Libraries[](#libraries "Link to this heading")

### 10.2.1. Graphviz related[](#graphviz-related "Link to this heading")

When you install the requirements for developer mode, you may have problems with pygraphviz (missing lib).
Try to install these libraries manually

```
sudo apt-get install libcgraph6 libgraphviz-dev
```

and then you can try again to install pygraphviz using

```
pip install pygraphviz
```

[Previous](glossary.html "9. Glossary")
[Next](bibliography.html "11. Bibliography")

---

© Copyright .
Last updated on Mar 09, 2026.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).
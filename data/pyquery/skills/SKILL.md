---
name: pyquery
description: PyQuery provides a Pythonic way to interact with XML and HTML documents by mimicking the jQuery API. Use when user asks to parse HTML or XML documents, select elements using CSS selectors, extract text or attributes, and modify DOM structures.
homepage: https://github.com/gawel/pyquery
metadata:
  docker_image: "quay.io/biocontainers/pyquery:1.2.9--py27_0"
---

# pyquery

## Overview
PyQuery provides a Pythonic way to interact with XML and HTML documents by mimicking the popular jQuery API. Built on top of the high-performance `lxml` library, it allows for efficient document traversal and modification using familiar CSS selectors and specialized pseudo-classes. It is particularly useful for developers who are already comfortable with JavaScript-based DOM manipulation and want to apply those patterns to Python scraping or data processing workflows.

## Core Implementation

### Initialization
Load documents from various sources using the `PyQuery` class, typically aliased as `pq`:

```python
from pyquery import PyQuery as pq

# From a string
d = pq("<html><div id='hello'>Hello World</div></html>")

# From a URL
d = pq(url='http://example.com')

# From a local file
d = pq(filename='path/to/document.html')
```

### Selection and Filtering
PyQuery supports standard CSS selectors and extended jQuery pseudo-classes that are not standard in CSS:

- **Basic Selectors**: `d('#id')`, `d('.class')`, `d('tag')`
- **Positional Pseudo-classes**: Use `:first`, `:last`, `:even`, `:odd`, `:eq(index)`, `:gt(index)`, and `:lt(index)`.
- **Form Selectors**: Use `:checked`, `:selected`, and `:file` to target specific input states.

### Data Extraction
- **Text Content**: `d('p').text()` extracts the text content of the selected elements.
- **HTML Content**: `d('div').html()` retrieves the inner HTML of the first matched element.
- **Attributes**: `d('a').attr('href')` gets the value of a specific attribute.

## Best Practices and Expert Tips

- **Performance**: PyQuery uses `lxml` for fast manipulation. Ensure `lxml` is correctly installed in your environment to maintain high-speed parsing of large XML/HTML documents.
- **Method Chaining**: Like its jQuery inspiration, PyQuery supports method chaining. You can select, modify, and extract in a single line: `d('div').add_class('active').find('p').text()`.
- **Iteration**: To iterate over multiple matches and maintain PyQuery functionality on each item, use the `.items()` generator:
  ```python
  for item in d('li').items():
      print(item.text())
  ```
- **Custom Network Requests**: If you need to handle specific headers or authentication when loading a URL, provide a custom opener:
  ```python
  d = pq(url=your_url, opener=lambda url, **kw: urlopen(url).read())
  ```
- **Modifying the DOM**: You can change content directly using `.html("new content")` or `.text("new text")`. These methods return the PyQuery object, allowing for further operations on the modified selection.

## Installation
Install the package via Conda or Pip:

```bash
# Conda (Bioconda channel)
conda install bioconda::pyquery

# Pip
pip install pyquery
```

## Reference documentation
- [pyquery - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pyquery_overview.md)
- [gawel/pyquery GitHub Repository](./references/github_com_gawel_pyquery.md)
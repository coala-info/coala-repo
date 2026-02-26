---
name: xmltramp2
description: xmltramp2 simplifies XML parsing by mapping XML structures to Python objects, allowing navigation via dot notation and function calls. Use when user asks to parse an XML string, navigate XML elements, get or set XML attributes, work with namespaced XML elements, modify XML element content, or access multiple XML elements of the same name.
homepage: https://github.com/tBaxter/xmltramp2
---


# xmltramp2

## Overview
xmltramp2 is a modern Python 3 refactoring of the original xmltramp library, designed to make XML parsing as simple as navigating a Python object. It maps XML structures to Pythonic patterns, allowing you to access elements via dot notation, attributes via function calls, and repeated elements via slicing. It is best used for "normal" XML documents where you want to avoid the verbosity of standard XML APIs like ElementTree or the complexity of BeautifulSoup.

## Installation and Setup
Install the package via pip:
```bash
pip install xmltramp2
```

Import the library in your Python script:
```python
from xmltramp2 import xmltramp
```

## Core Usage Patterns

### Parsing XML
You can parse an XML string directly into a navigable object:
```python
doc = xmltramp.parse(xml_string)
```

### Navigating Elements
- **Direct Access**: Access the first child element of a specific tag using dot notation: `doc.author`.
- **Index Access**: Access children by their position: `doc[0]`.
- **Text Content**: Wrap an element in `str()` to retrieve its inner text: `str(doc.author.name)`.
- **Metadata**: Use `._name` to get a tuple of the (namespace, tagname) and `._dir` to list all child elements.

### Working with Attributes
- **Get Attribute**: Call the element as a function with the attribute name: `doc('version')`.
- **Set Attribute**: Call the element with a keyword argument: `doc(version='2.0')`.

### Handling Namespaces
To work with namespaced elements, define a Namespace object:
```python
dc = xmltramp.Namespace("http://purl.org/dc/elements/1.1/")

# Access the first element in that namespace
creator = doc[dc.creator]

# Access all elements of that tag in that namespace using a slice
all_creators = doc[dc.creator:]
```

### Modifying Content
You can update the text content of an element by direct assignment:
```python
doc[dc.creator] = "New Author Name"
```

## Expert Tips
- **Slicing for Multiples**: Always use the slice syntax `doc.tagname[:]` or `doc[namespace.tag:]` when you expect multiple elements of the same name. Using dot notation only returns the first instance.
- **Lightweight Alternative**: Use xmltramp2 specifically when you are writing scripts that need to be easily readable and maintainable, as the syntax closely mirrors the structure of the XML itself.
- **Namespace Prefixes**: When dealing with complex XML like RSS or Atom, define all your namespaces at the top of your script to keep the extraction logic clean.

## Reference documentation
- [xmltramp2 README](./references/github_com_tBaxter_xmltramp2.md)
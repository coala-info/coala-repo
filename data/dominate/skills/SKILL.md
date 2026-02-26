---
name: dominate
description: "Dominate provides a Pythonic API to programmatically generate HTML structures using classes and context managers. Use when user asks to create HTML documents in Python, generate dynamic markup without templates, or build DOM trees using Python logic."
homepage: https://github.com/Knio/dominate
---


# dominate

## Overview
The `dominate` library provides a Pythonic way to create HTML structures using an elegant DOM API. Instead of using string templates or concatenation, you use Python classes and context managers to represent HTML elements. This approach allows you to leverage Python's logic (loops, conditionals, functions) directly within your HTML structure, ensuring that the resulting markup is well-formed and easily maintainable.

## Core Usage Patterns

### Basic Document Structure
Use `dominate.document()` to initialize a full HTML document. Use `with` statements to nest elements inside the `head` or `body`.

```python
import dominate
from dominate.tags import *

doc = dominate.document(title='My Page')

with doc.head:
    link(rel='stylesheet', href='style.css')
    script(type='text/javascript', src='app.js')

with doc:
    with div(id='header'):
        h1('Welcome to Dominate')
    with div(cls='content'):
        p('This is a programmatically generated paragraph.')

print(doc.render())
```

### Handling Attributes
Since `class` and `for` are reserved keywords in Python, `dominate` provides aliases.
- Use `cls`, `_class`, or `className` for the HTML `class` attribute.
- Use `fr`, `_for`, or `htmlFor` for the HTML `for` attribute.
- Use underscores for data attributes: `data_user_id='123'` becomes `data-user-id="123"`.

### Dynamic Content Generation
Leverage Python's iteration to build lists or tables efficiently.

```python
items = ['Home', 'About', 'Contact']
with ul() as menu:
    for item in items:
        li(a(item, href=f'/{item.lower()}.html'))
```

### Adding Elements Manually
If you are not using a context manager, you can add elements using the `+=` operator or the `.add()` method.
- `.add()` returns the child (or a tuple of children), allowing for immediate reference.
- `+=` is useful for appending to an existing tree.

```python
container = div()
container += p('Appended text')
title = container.add(h2('Section Title'))
```

## Expert Tips

### Preventing Escaping
By default, `dominate` escapes special characters to prevent XSS. To include raw HTML or scripts that should not be escaped, use the `raw()` function.

```python
from dominate.util import raw
div(raw('<span>This will not be escaped</span>'))
```

### Comments and Conditionals
Create standard HTML comments or IE-specific conditional comments using the `comment` tag.

```python
comment('Standard HTML Comment')
comment(p('Only for old IE'), condition='lt IE 9')
```

### Customizing Output
The `.render()` method supports several parameters to control the output:
- `pretty`: Set to `False` to disable indentation (useful for minification).
- `indent`: Change the indentation string (default is two spaces).
- `xhtml`: Set to `True` to output XHTML compatible tags.

## Reference documentation
- [Dominate README](./references/github_com_Knio_dominate.md)
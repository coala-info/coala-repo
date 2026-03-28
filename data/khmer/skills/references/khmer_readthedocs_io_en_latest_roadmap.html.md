### Navigation

* [index](genindex.html "General Index")
* [next](LICENSE.html "License") |
* [previous](dev/binary-file-formats.html "khmer/Oxli Binary File Formats") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](index.html) »

## Contents

* Roadmap to v3.0, v4.0, v5.0
  + [Background](#background)
  + [Remainder of v2.x series](#remainder-of-v2-x-series)
  + [v3.x series](#v3-x-series)
  + [v4.0 and project renaming](#v4-0-and-project-renaming)
  + [v5.0](#v5-0)
  + [Python API wishlist](#python-api-wishlist)

#### Previous topic

[khmer/Oxli Binary File Formats](dev/binary-file-formats.html "previous chapter")

#### Next topic

[License](LICENSE.html "next chapter")

### This Page

* [Show Source](_sources/roadmap.rst.txt)

1. [Docs](index.html)
2. Roadmap to v3.0, v4.0, v5.0

# Roadmap to v3.0, v4.0, v5.0[¶](#roadmap-to-v3-0-v4-0-v5-0 "Permalink to this headline")

## Background[¶](#background "Permalink to this headline")

To make the khmer project easier to use and easier to build upon several
fundamental changes need to happen. This document outlines our plan to do so
while minimizing the impact of these changes on our existing users. The
version numbers are approximate; there may be additional major number
releases to support needed changes to the API along the way. This document has
been updated for v2.0 onwards from the [original roadmap](http://khmer.readthedocs.io/en/v1.2/roadmap.html).

The discussion that lead to this document can be read at
<https://github.com/dib-lab/khmer/issues/389>

## Remainder of v2.x series[¶](#remainder-of-v2-x-series "Permalink to this headline")

Continue transition to a single entrypoint named [oxli](https://github.com/dib-lab/khmer/blob/master/oxli/__init__.py#L38) . This
will be exempt from the project’s semantic versioning and will not be
advertised as it is experimental and unstable. (For the 2.0 version we removed
the `oxli` script just prior to release and restored it afterwards to the
development tree.)

The Python script functionality will continue to migrate to a Python module
named [oxli](https://github.com/dib-lab/khmer/tree/master/oxli). As the code
moves over there will be no change to external script functionality or their
command line interfaces (except for new features).

## v3.x series[¶](#v3-x-series "Permalink to this headline")

The `oxli` command is now under semantic versioning. Scripts are still the
advertised and preferred entry point for users. Developers and workflow systems
can start to trial `oxli` but need not switch until 4.0. New functionality is
added to both the scripts and the `oxli` command.

## v4.0 and project renaming[¶](#v4-0-and-project-renaming "Permalink to this headline")

Project renamed to ‘oxli’; all references to ‘khmer’ removed from the code and
documentation except for a single note in the docs. All scripts dropped as
their functionality has been moved to the `oxli` command. Websites that we
maintain that have ‘khmer’ in the URL will have redirects installed.

Refinement of the Python API continues, however it is not part of the semantic
versioning of the project.

## v5.0[¶](#v5-0 "Permalink to this headline")

The semantic versioning now extends to the Python API.

## Python API wishlist[¶](#python-api-wishlist "Permalink to this headline")

API for multiple container types and implementation of the same.

Cleanup of Python/C++ class hierarchy to cut down on boilerplate glue code.

Switch to new-style Python objects (see LabelHash & Hashbits)

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[khmer/Oxli Binary File Formats](dev/binary-file-formats.html "previous chapter (use the left arrow)")

[License](LICENSE.html "next chapter (use the right arrow)")

### Navigation

* [index](genindex.html "General Index")
* [next](LICENSE.html "License") |
* [previous](dev/binary-file-formats.html "khmer/Oxli Binary File Formats") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](index.html) »

© Copyright 2010-2014 the authors.. Created using [Sphinx](http://sphinx.pocoo.org/).
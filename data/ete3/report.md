# ete3 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ete3_annotate | Failed | image problem: the ete3 command crashes at start with ImportError cannot import name TextFace (Qt dependency missing) |
| ete3_expand | Failed | image problem: the ete3 command crashes at start with ImportError cannot import name TextFace (Qt dependency missing) |
| ete3_ncbiquery | Failed | image problem: the ete3 command crashes at start with ImportError cannot import name TextFace (Qt dependency missing) |

## ete3_expand

### Tool Description
Expand a tree with new sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/ete3:3.1.2
- **Homepage**: http://etetoolkit.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/ete3/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/ete3", line 6, in <module>
    from ete3.tools.ete import main
  File "/usr/local/lib/python3.7/site-packages/ete3/tools/ete.py", line 55, in <module>
    from . import (ete_split, ete_expand, ete_annotate, ete_ncbiquery, ete_view,
  File "/usr/local/lib/python3.7/site-packages/ete3/tools/ete_view.py", line 48, in <module>
    from .. import (Tree, PhyloTree, TextFace, RectFace, faces, TreeStyle, CircleFace, AttrFace,
ImportError: cannot import name 'TextFace' from 'ete3' (/usr/local/lib/python3.7/site-packages/ete3/__init__.py)
```

## ete3_annotate

### Tool Description
Annotates a tree with information from external files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ete3:3.1.2
- **Homepage**: http://etetoolkit.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/ete3/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/ete3", line 6, in <module>
    from ete3.tools.ete import main
  File "/usr/local/lib/python3.7/site-packages/ete3/tools/ete.py", line 55, in <module>
    from . import (ete_split, ete_expand, ete_annotate, ete_ncbiquery, ete_view,
  File "/usr/local/lib/python3.7/site-packages/ete3/tools/ete_view.py", line 48, in <module>
    from .. import (Tree, PhyloTree, TextFace, RectFace, faces, TreeStyle, CircleFace, AttrFace,
ImportError: cannot import name 'TextFace' from 'ete3' (/usr/local/lib/python3.7/site-packages/ete3/__init__.py)
```

## ete3_ncbiquery

### Tool Description
Query NCBI databases for sequences and retrieve them in Newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ete3:3.1.2
- **Homepage**: http://etetoolkit.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/ete3/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/ete3", line 6, in <module>
    from ete3.tools.ete import main
  File "/usr/local/lib/python3.7/site-packages/ete3/tools/ete.py", line 55, in <module>
    from . import (ete_split, ete_expand, ete_annotate, ete_ncbiquery, ete_view,
  File "/usr/local/lib/python3.7/site-packages/ete3/tools/ete_view.py", line 48, in <module>
    from .. import (Tree, PhyloTree, TextFace, RectFace, faces, TreeStyle, CircleFace, AttrFace,
ImportError: cannot import name 'TextFace' from 'ete3' (/usr/local/lib/python3.7/site-packages/ete3/__init__.py)
```

## Metadata
- **Skill**: generated

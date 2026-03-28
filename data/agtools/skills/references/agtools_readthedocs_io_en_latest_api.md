[agtools](..)

Home

* [Introduction](..)

Getting Started

* [Installation](../install/)
* [Quick Start](../quickstart/)

Guides

* CLI Examples
  + [Obtaining stats](../examples/stats/)
  + [Renaming elements](../examples/rename/)
  + [Concatenating multiple graphs](../examples/concat/)
  + [Filtering segments](../examples/filter/)
  + [Cleaning a graph file](../examples/clean/)
  + [Get component of a segment](../examples/component/)
  + [Format conversion](../examples/formatconv/)
* [API Tutorial](../tutorial/)
* [Assembler examples](../assemblerexamples/)
* [More examples](../moreexamples/)
* [Applications](../exampleapplications/)

Reference

* [CLI Commands](../cli/)
* API Documentation
  + [UnitigGraph](#agtools.core.unitig_graph.UnitigGraph)
    - [calculate\_average\_node\_degree](#agtools.core.unitig_graph.UnitigGraph.calculate_average_node_degree)
    - [calculate\_average\_segment\_length](#agtools.core.unitig_graph.UnitigGraph.calculate_average_segment_length)
    - [calculate\_n50\_l50](#agtools.core.unitig_graph.UnitigGraph.calculate_n50_l50)
    - [calculate\_total\_length](#agtools.core.unitig_graph.UnitigGraph.calculate_total_length)
    - [from\_gfa](#agtools.core.unitig_graph.UnitigGraph.from_gfa)
    - [get\_adjacency\_matrix](#agtools.core.unitig_graph.UnitigGraph.get_adjacency_matrix)
    - [get\_connected\_components](#agtools.core.unitig_graph.UnitigGraph.get_connected_components)
    - [get\_gc\_content](#agtools.core.unitig_graph.UnitigGraph.get_gc_content)
    - [get\_neighbors](#agtools.core.unitig_graph.UnitigGraph.get_neighbors)
    - [get\_path](#agtools.core.unitig_graph.UnitigGraph.get_path)
    - [get\_segment\_sequence](#agtools.core.unitig_graph.UnitigGraph.get_segment_sequence)
    - [is\_connected](#agtools.core.unitig_graph.UnitigGraph.is_connected)
  + [ContigGraph](#agtools.core.contig_graph.ContigGraph)
    - [calculate\_average\_contig\_length](#agtools.core.contig_graph.ContigGraph.calculate_average_contig_length)
    - [calculate\_average\_node\_degree](#agtools.core.contig_graph.ContigGraph.calculate_average_node_degree)
    - [calculate\_n50\_l50](#agtools.core.contig_graph.ContigGraph.calculate_n50_l50)
    - [calculate\_total\_length](#agtools.core.contig_graph.ContigGraph.calculate_total_length)
    - [get\_adjacency\_matrix](#agtools.core.contig_graph.ContigGraph.get_adjacency_matrix)
    - [get\_connected\_components](#agtools.core.contig_graph.ContigGraph.get_connected_components)
    - [get\_contig\_sequence](#agtools.core.contig_graph.ContigGraph.get_contig_sequence)
    - [get\_gc\_content](#agtools.core.contig_graph.ContigGraph.get_gc_content)
    - [get\_neighbors](#agtools.core.contig_graph.ContigGraph.get_neighbors)
    - [is\_connected](#agtools.core.contig_graph.ContigGraph.is_connected)
  + [FastaParser](#agtools.core.fasta_parser.FastaParser)
    - [get\_index](#agtools.core.fasta_parser.FastaParser.get_index)
    - [get\_sequence](#agtools.core.fasta_parser.FastaParser.get_sequence)
* [File Formats](../fileformats/)

Support

* [FAQ](../faq/)
* [Changelog](../changelog/)

[agtools](..)

* Reference
* API Documentation
* [Edit on GitHub](https://github.com/Vini2/agtools/edit/master/docs/api.md)

---

# agtools API Reference

## `UnitigGraph`

Represents a unitig-level assembly graph parsed from a GFA file.

|  |  |
| --- | --- |
| Attributes: | * **`graph`**   (`Graph`)   – The undirected graph representing the unitig-level assembly graph. * **`vcount`**   (`int`)   – The number of vertices (segments) in the graph. * **`lcount`**   (`int`)   – The number of links (lines starting with tag "L") in the GFA file. * **`ecount`**   (`int`)   – The number of edges in the graph after simplification. * **`pcount`**   (`int`)   – The number of paths (lines starting with tag "P") in the GFA file. * **`file_path`**   (`str`)   – Path to the GFA file. * **`segment_names`**   (`list`)   – List of segment names. * **`segment_name_to_id`**   (`dict`)   – Mapping from segment name to internal ID.   This is used to map segment names to their vertex IDs in the graph. * **`segment_lengths`**   (`dict`)   – Mapping from segment name to length of sequence. * **`segment_offsets`**   (`dict`)   – Mapping from segment name to byte offset of the segment line in the GFA file. * **`oriented_links`**   (`dict`)   – Mapping from [from segment id][to segment id] -> list of (from orientation, to orientation). * **`link_overlap`**   (`dict`)   – Mapping from oriented segment pair (from segment id, from orientation, to segment id, to orientation) -> overlap length. * **`path_index`**   (`dict`)   – Mapping from path name to byte offset of the path line in the GFA file. * **`self_loops`**   (`list`)   – List of segment IDs that form self-loops. |

Methods:

| Name | Description |
| --- | --- |
| `[from_gfa](#agtools.core.unitig_graph.UnitigGraph.from_gfa "from_gfa(file_path)           classmethod    (agtools.core.unitig_graph.UnitigGraph.from_gfa)")` | Parse a GFA file into a UnitigGraph object. |
| `[get_segment_sequence](#agtools.core.unitig_graph.UnitigGraph.get_segment_sequence "get_segment_sequence(seg_name) (agtools.core.unitig_graph.UnitigGraph.get_segment_sequence)")` | Retrieve a DNA sequence for a segment. |
| `[get_neighbors](#agtools.core.unitig_graph.UnitigGraph.get_neighbors "get_neighbors(seg_name) (agtools.core.unitig_graph.UnitigGraph.get_neighbors)")` | Get neighboring segments of a given segment. |
| `[get_adjacency_matrix](#agtools.core.unitig_graph.UnitigGraph.get_adjacency_matrix "get_adjacency_matrix(type='matrix') (agtools.core.unitig_graph.UnitigGraph.get_adjacency_matrix)")` | Return the adjacency matrix as a matrix or a pandas DataFrame. |
| `[is_connected](#agtools.core.unitig_graph.UnitigGraph.is_connected "is_connected(from_seg, to_seg) (agtools.core.unitig_graph.UnitigGraph.is_connected)")` | Check if there is a path between two segments in the graph. |
| `[get_connected_components](#agtools.core.unitig_graph.UnitigGraph.get_connected_components "get_connected_components() (agtools.core.unitig_graph.UnitigGraph.get_connected_components)")` | Get connected components of the graph. |
| `[calculate_average_node_degree](#agtools.core.unitig_graph.UnitigGraph.calculate_average_node_degree "calculate_average_node_degree() (agtools.core.unitig_graph.UnitigGraph.calculate_average_node_degree)")` | Calculate the average node degree of the graph. |
| `[calculate_total_length](#agtools.core.unitig_graph.UnitigGraph.calculate_total_length "calculate_total_length() (agtools.core.unitig_graph.UnitigGraph.calculate_total_length)")` | Calculate the total length of all segments in the graph. |
| `[calculate_average_segment_length](#agtools.core.unitig_graph.UnitigGraph.calculate_average_segment_length "calculate_average_segment_length() (agtools.core.unitig_graph.UnitigGraph.calculate_average_segment_length)")` | Calculate the average segment length. |
| `[calculate_n50_l50](#agtools.core.unitig_graph.UnitigGraph.calculate_n50_l50 "calculate_n50_l50() (agtools.core.unitig_graph.UnitigGraph.calculate_n50_l50)")` | Calculate N50 and L50 for the segments in the graph. |
| `[get_gc_content](#agtools.core.unitig_graph.UnitigGraph.get_gc_content "get_gc_content() (agtools.core.unitig_graph.UnitigGraph.get_gc_content)")` | Calculate the GC content of segment sequences. |

Examples:

```
>>> from agtools.core.unitig_graph import UnitigGraph
>>> ug = UnitigGraph.from_gfa("assembly.gfa")
>>> ug.vcount
42
>>> ug.ecount
80
```

References

GFA: Graphical Fragment Assembly (GFA) Format Specification
<https://github.com/GFA-spec/GFA-spec>

### `calculate_average_node_degree()`

Calculate the average node degree of the graph.

|  |  |
| --- | --- |
| Returns: | * `int`   – Average node degree of the graph. |

|  |  |
| --- | --- |
| Raises: | * `ValueError`   – If the graph does not have any segments. |

Examples:

```
>>> ug.calculate_average_node_degree()
2.576374745417515
```

### `calculate_average_segment_length()`

Calculate the average segment length.

|  |  |
| --- | --- |
| Returns: | * `int`   – Average segment length. |

|  |  |
| --- | --- |
| Raises: | * `ValueError`   – If the graph does not have any segments. |

Examples:

```
>>> ug.calculate_average_segment_length()
8490.319755600814
```

### `calculate_n50_l50()`

Calculate N50 and L50 for the segment in the graph.

|  |  |
| --- | --- |
| Returns: | * `tuple of (int, int)`   – A tuple containing:   - N50 : int   The length N such that 50% of the total length is contained in segments of length >= N.   - L50 : int   The minimum number of segments whose summed length >= 50% of the total length. |

Examples:

```
>>> ug.calculate_n50_l50()
(15000, 12)
```

### `calculate_total_length()`

Calculate the total length of all segments in the graph.

|  |  |
| --- | --- |
| Returns: | * `int`   – Total length of all segments. |

Examples:

```
>>> ug.calculate_total_length()
350000
```

### `from_gfa(file_path)` `classmethod`

Parse a GFA file into a UnitigGraph object.

|  |  |
| --- | --- |
| Parameters: | * **`file_path`**   (`str`)   – Path to the GFA file. |

|  |  |
| --- | --- |
| Returns: | * `[UnitigGraph](#agtools.core.unitig_graph.UnitigGraph "UnitigGraph (agtools.core.unitig_graph.UnitigGraph)")`   – The constructed unitig graph object. |

Examples:

```
>>> ug = UnitigGraph.from_gfa("assembly.gfa")
>>> ug.vcount
42
>>> ug.ecount
80
```

### `get_adjacency_matrix(type='matrix')`

Return the adjacency matrix as igraph or pandas DataFrame.

|  |  |
| --- | --- |
| Parameters: | * **`type`**   (`str`, default:   `'matrix'`   )   – The return type. Options are:   - "matrix": Return the adjacency matrix object from `self.graph.get_adjacency()`.   - "pandas": Return a Pandas DataFrame with unitig names as row and column labels. |

|  |  |
| --- | --- |
| Returns: | * **`adjacency`**( `object or DataFrame`   ) – + If `type="matrix"`, returns the adjacency matrix object.   + If `type="pandas"`, returns a DataFrame where both rows and columns are indexed by unitig names. |

|  |  |
| --- | --- |
| Raises: | * `ValueError`   – If `type` is not "matrix" or "pandas". |

Examples:

```
>>> matrix = ug.get_adjacency_matrix()
>>> isinstance(matrix, list)
True
>>> df = ug.get_adjacency_matrix(type="pandas")
>>> df.head()
            unitig_1  unitig_2  unitig_3
unitig_1          0         1         0
unitig_2          1         0         1
unitig_3          0         1         0
```

### `get_connected_components()`

Get connected components of the graph.

|  |  |
| --- | --- |
| Returns: | * `list`   – A list of the connected components with internal segment IDs |

Examples:

```
>>> components = ug.get_connected_components()
>>> len(components)
3
>>> [len(c) for c in components]
[10, 8, 5]
>>> components[0]
[0, 1, 2, 3, ...]
```

### `get_gc_content()`

Calculate the GC content of segment sequences.

|  |  |
| --- | --- |
| Returns: | * `float`   – GC content as a percentage of total base pairs. |

|  |  |
| --- | --- |
| Raises: | * `ValueError`   – If total length of the segments is zero. |

Examples:

```
>>> round(ug.get_gc_content(), 2)
0.42
```

### `get_neighbors(seg_name)`

Get neighboring segments of a given segment.

|  |  |
| --- | --- |
| Parameters: | * **`seg_name`**   (`str`)   – The segment name. |

|  |  |
| --- | --- |
| Returns: | * `list of str`   – List of neighboring segment names. |

Examples:

```
>>> ug.get_neighbors("unitig_1")
['unitig_2', 'unitig_3']
```

### `get_path(path_name)`

Retrieve the segment string and overlaps string of a path.

This method retrieves the segment string and overlaps string of
a path from the original GFA file using byte offsets.

|  |  |
| --- | --- |
| Parameters: | * **`path_name`**   (`str`)   – The path identifier whose segment sequence should be retrieved. |

|  |  |
| --- | --- |
| Returns: | * **`segments`**( `str`   ) – The segment string for the path. * **`overlaps`**( `str`   ) – The overlaps string for the path. |

|  |  |
| --- | --- |
| Raises: | * `KeyError`   – If the path does not exist in the graph. |

Examples:

```
>>> ug.get_path("path_1")
('unitig_1+,unitig_2+,unitig_3+', '*')
```

### `get_segment_sequence(seg_name)`

Retrieve a DNA sequence for a segment.

This method retrieves the sequence of a segment from the original GFA file
using byte offsets, without loading all sequences into memory at once.

|  |  |
| --- | --- |
| Parameters: | * **`seg_name`**   (`str`)   – The segment name whose DNA sequence should be retrieved. |

|  |  |
| --- | --- |
| Returns: | * `Seq`   – The DNA sequence corresponding to the given segment. |

|  |  |
| --- | --- |
| Raises: | * `KeyError`   – If the segment name does not exist in the graph. * `ValueError`   – If the retrieved sequence length does not match the expected length   recorded during graph construction. |

Examples:

```
>>> ug.get_segment_sequence("unitig_1")[:10]
Seq('ATGCGTACGG')
```

### `is_connected(from_seg, to_seg)`

Check if there is a path between two segments in the graph.

This method determines whether a path exists between the segment
specified by `from_seg` and the segment specified by `to_seg`
using the underlying graph's shortest path search.

|  |  |
| --- | --- |
| Parameters: | * **`from_seg`**   (`str`)   – Name of the starting segment. * **`to_seg`**   (`str`)   – Name of the target segment. |

|  |  |
| --- | --- |
| Returns: | * `bool`   – True if there is a path connecting `from_seg` to `to_seg`,   False otherwise. |

Examples:

```
>>> ug.is_connected("unitig_1", "unitig_2")
True
```

---

## `ContigGraph`

Represents a contig-level assembly graph derived from a GFA file.

|  |  |
| --- | --- |
| Attributes: | * **`graph`**   (`Graph`)   – The undirected graph representing the contig-level assembly graph. * **`vcount`**   (`int`)   – The number of vertices (contigs) in the graph. * **`lcount`**   (`int`)   – The number of links (lines starting with tag "L") in the GFA file. * **`ecount`**   (`int`)   – The number of edges in the graph after simplification * **`file_path`**   (`str`)   – Path to the GFA file. * **`contig_names`**   (`list`)   – List of contig names. * **`contig_name_to_id`**   (`dict`)   – Mapping from contig name to internal ID.   This is used to map contig names to their vertex IDs in the graph. * **`contig_parser`**   (`FastaParser`)   – FastaParser object containing the file pointers to contig sequences. * **`contig_descriptions`**   (`(dict[str, str], optional)`)   – Dictionary mapping contig names to additional descriptions in FASTA file. * **`graph_to_contig_map`**   (`(bidict[int, str], optional)`)   – Bi-directional dictionary mapping from contig identifiers in the GFA file to FASTA file. * **`self_loops`**   (`(list[str], optional)`)   – List of contig names that form self-loops in the graph. |

Methods:

| Name | Description |
| --- | --- |
| `[get_contig_sequence](#agtools.core.contig_graph.ContigGraph.get_contig_sequence "get_contig_sequence(contig
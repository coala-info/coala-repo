# odgi CWL Generation Report

## odgi_bin

### Tool Description
Binning of pangenome sequence and path information in the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Total Downloads**: 70.8K
- **Last updated**: 2026-01-03
- **GitHub**: https://github.com/vgteam/odgi
- **Stars**: N/A
### Original Help Text
```text
Flag could not be matched: h
  odgi bin {OPTIONS}

    Binning of pangenome sequence and path information in the graph.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this FILE. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Bin Options ]
        -D[path-delim],
        --path-delim=[path-delim]         Annotate rows by prefix and suffix of
                                          this delimiter.
        -a, --aggregate-delim             Aggregate on path prefix delimiter.
                                          Argument depends on
                                          -D,--path-delim=[STRING].
        -j, --json                        Print bins and links to stdout in
                                          pseudo JSON format. Each line is a
                                          valid JSON object, but the whole file
                                          is not a valid JSON! First, each bin
                                          including its pangenome sequence is
                                          printed to stdout per line. Second,
                                          for each path in the graph, its
                                          traversed bins including
                                          metainformation: **bin** (bin
                                          identifier), **mean.cov** (mean
                                          coverage of the path in this bin),
                                          **mean.inv** (mean inversion rate of
                                          this path in this bin), **mean.pos**
                                          (mean nucleotide position of this path
                                          in this bin), and an array of ranges
                                          determining the nucleotide position of
                                          the path in this bin. Switching first
                                          and last nucleotide in a range
                                          represents a complement reverse
                                          orientation of that particular
                                          sequence.
        -n[N], --num-bins=[N]             The number of bins the pangenome
                                          sequence should be chopped up to.
        -w[bp], --bin-width=[bp]          The bin width specifies the size of
                                          each bin.
        -s, --no-seqs                     If -j,--json is set, no nucleotide
                                          sequences will be printed to stdout in
                                          order to save disk space.
        -g, --no-gap-links                Don't include gap links in the output.
                                          We divide links into 2 classes:
                                          1. The links which help to follow
                                          complex variations. They need to be
                                          drawn, else one could not follow the
                                          sequence of a path.
                                          2. The links helping to follow simple
                                          variations. These links are called
                                          gap-links. Such links solely
                                          connecting a path from left to right
                                          may not berelevant to understand a
                                          path's traveral through the bins.
                                          Therfore, when this option is set, the
                                          gap-links are left out saving disk
                                          space.
      [ HaploBlocker Options ]
        -b, --haplo-blocker               Write a TSV to stdout formatted in a
                                          way ready for HaploBlocker: Each row
                                          corresponds to a node. Each column
                                          corresponds to a path. Each value is
                                          the coverage of a specific node of a
                                          specific path.
        -p[N],
        --haplo-blocker-min-paths=[N]     Specify the minimum number of paths
                                          that need to be present in the bin to
                                          actually report that bin (default: 1).
        -c[N],
        --haplo-blocker-min-depth=[N]     Specify the minimum depth a path needs
                                          to have in a bin to actually report
                                          that bin (default: 1).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi bin.
```


## odgi_break

### Tool Description
Break cycles in the graph and drop its paths.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi break {OPTIONS}

    Break cycles in the graph and drop its paths.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the broken graph in ODGI format
                                          to FILE. A file ending of *.og* is
                                          recommended.
      [ Cycle Options ]
        -c[N], --cycle-max-bp=[N]         The maximum cycle length at which to
                                          break (default: 0).
        -s[N], --max-search-bp=[N]        The maximum search space of each BFS
                                          given in number of base pairs
                                          (default: 0).
        -u[N], --repeat-up-to=[N]         Iterate cycle breaking up to N times,
                                          or stop if no new edges are removed.
        -d, --show                        print edges we would remove
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi break.
```


## odgi_build

### Tool Description
Construct a dynamic succinct variation graph in ODGI format from a GFAv1.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi build {OPTIONS}

    Construct a dynamic succinct variation graph in ODGI format from a GFAv1.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -g[FILE], --gfa=[FILE]            GFAv1 FILE containing the nodes, edges
                                          and paths to build a dynamic succinct
                                          variation graph from.
        -o[FILE], --out=[FILE]            Write the dynamic succinct variation
                                          graph to this *FILE*. A file ending
                                          with *.og* is recommended.
      [ Graph Sorting ]
        -O, --optimize                    Compact the graph id space into a
                                          dense integer range.
        -s, --sort                        Apply a general topological sort to
                                          the graph and order the node ids
                                          accordingly. A bidirected adaptation
                                          of Kahn’s topological sort (1962) is
                                          used, which can handle components with
                                          no heads or tails. Here, both heads
                                          and tails are taken into account.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
        -d, --debug                       Verbosely print graph information to
                                          stderr. This includes the maximum
                                          node_id, the minimum node_id, the
                                          handle to node_id mapping, the deleted
                                          nodes and the path metadata.
      [ Program Information ]
        -h, --help                        Print a help message for odgi build.
```


## odgi_chop

### Tool Description
Divide nodes into smaller pieces preserving node topology and order.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi chop {OPTIONS}

    Divide nodes into smaller pieces preserving node topology and order.

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the chopped succinct variation
                                          graph in ODGI format to *FILE*. A file
                                          ending of *.og* is recommended.
        -c[N], --chop-to=[N]              Divide nodes that are longer than *N*
                                          base pairs into nodes no longer than
                                          *N* while maintaining graph topology.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -d, --debug                       Print information about the process to
                                          stderr.
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi chop.
```


## odgi_cover

### Tool Description
Cover the graph with paths.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi cover {OPTIONS}

    Cover the graph with paths.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the succinct variation graph
                                          with the generated paths in ODGI
                                          format to *FILE*. A file ending with
                                          *.og* is recommended.
      [ Cover Options ]
        -H[DEPTH],
        --hogwild-depth=[DEPTH]           Randomly cover the graph until it
                                          reaches the given average DEPTH.
                                          Specifying this option overwrites all
                                          other cover options except -I,
                                          --ignore-paths!
        -n[N],
        --num-paths-per-component=[N]     Number of paths to generate per
                                          component.
        -k[N], --node-window-size=[N]     Size of the node window to check each
                                          time a new path is extended (it has to
                                          be greater than or equal to 2).
        -c[N], --min-node-depth=[N]       Minimum node depth to reach (it has to
                                          be greater than 0). There will be
                                          generated paths until the specified
                                          minimum node coverage is reached, or
                                          until the maximum number of allowed
                                          generated paths is reached (number of
                                          nodes in the input ODGI graph).
        -I, --ignore-paths                Ignore the paths already embedded in
                                          the graph during the node depth
                                          initialization.
        -w[FILE],
        --write-node-depth=[FILE]         Write the node depth at the end of the
                                          paths generation to FILE. The file
                                          will contain tab-separated values
                                          (header included), and have 3 columns:
                                          component_id, node_ide, coverage.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Print information about the components
                                          and the progress to stderr
      [ Program Information ]
        -h, --help                        Print a help message for odgi cover.
```


## odgi_crush

### Tool Description
Replaces runs of Ns with single Ns (for example, ANNNT becomes ANT).

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi crush {OPTIONS}

    Replaces runs of Ns with single Ns (for example, ANNNT becomes ANT).

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the N-crushed succinct variation
                                          graph in ODGI format to *FILE*. A file
                                          ending of *.og* is recommended.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi crush.
```


## odgi_degree

### Tool Description
Describe the graph in terms of node degree.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi degree {OPTIONS}

    Describe the graph in terms of node degree.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --input=[FILE]          Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Degree Options ]
        -s[FILE], --subset-paths=[FILE]   Compute the degree considering only
                                          the paths specified in the FILE. The
                                          file must contain one path name per
                                          line and a subset of all paths can be
                                          specified; If a step is of a path of
                                          the given list, it is taken into
                                          account when calculating a node's
                                          degree. Else not.
        -r[PATH_NAME], --path=[PATH_NAME] Compute the degree of the given path
                                          PATH_NAME in the graph.
        -R[FILE], --paths=[FILE]          Report the degree only for the paths
                                          listed in FILE.
        -g[[node_id][,offset[,(+|-)]*]*],
        --graph-pos=[[node_id][,offset[,(+|-)]*]*]
                                          Compute the degree at the given node,
                                          e.g. 7 or 3,4 or 42,10,+ or 302,0,-.
        -G[FILE], --graph-pos-file=[FILE] A file with one graph position per
                                          line.
        -p[[path_name][,offset[,(+|-)]*]*],
        --path-pos=[[path_name][,offset[,(+|-)]*]*]
                                          Return degree at the given path
                                          position e.g. chrQ or chr3,42 or
                                          chr8,1337,+ or chrZ,3929,-.
        -F[FILE], --path-pos-file=[FILE]  A file with one path position per
                                          line.
        -b[FILE], --bed-input=[FILE]      A BED file of ranges in paths in the
                                          graph.
        -d, --graph-degree-table          Compute the degree on each node in the
                                          graph, writing a table by node:
                                          node.id, degree.
        -v, --graph-degree-vec            Compute the degree on each node in the
                                          graph, writing a vector by base in one
                                          line.
        -D, --path-degree                 Compute a vector of degree on each
                                          base of each path. Each line consists
                                          of a path name and subsequently the
                                          space-separated degree of each base.
        -a, --self-degree                 Compute the degree of the path versus
                                          itself on each base in each path. Each
                                          line consists of a path name and
                                          subsequently the space-separated
                                          degree of each base.
        -S, --summarize-graph-degree      Summarize the graph properties and
                                          dimensions. Print in tab-delimited
                                          format to stdout the node.count,
                                          edge.count, avg.degree, min.degree,
                                          max.degree.
        -w[LEN:MIN:MAX],
        --windows-in=[LEN:MIN:MAX]        Print to stdout a BED file of path
                                          intervals where the degree is between
                                          MIN and MAX, merging regions not
                                          separated by more than LEN bp.
        -W[LEN:MIN:MAX],
        --windows-out=[LEN:MIN:MAX]       Print to stdout a BED file of path
                                          intervals where the degree is outside
                                          of MIN and MAX, merging regions not
                                          separated by more than LEN bp.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi degree.
```


## odgi_depth

### Tool Description
Find the depth of a graph as defined by query criteria. Without specifying any non-mandatory options, it prints in a tab-delimited format path, start, end, and mean.depth to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi depth {OPTIONS}

    Find the depth of a graph as defined by query criteria. Without specifying
    any non-mandatory options, it prints in a tab-delimited format path, start,
    end, and mean.depth to stdout.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --input=[FILE]          Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Depth Options ]
        -s[FILE], --subset-paths=[FILE]   Compute the depth considering only the
                                          paths specified in the FILE. The file
                                          must contain one path name per line
                                          and a subset of all paths can be
                                          specified; If a step is of a path of
                                          the given list, it is taken into
                                          account when calculating a node's
                                          depth. Else not.
        -r[PATH_NAME], --path=[PATH_NAME] Compute the depth of the given path
                                          PATH_NAME in the graph.
        -R[FILE], --paths=[FILE]          Report the depth only for the paths
                                          listed in FILE.
        -g[[node_id][,offset[,(+|-)]*]*],
        --graph-pos=[[node_id][,offset[,(+|-)]*]*]
                                          Compute the depth at the given node,
                                          e.g. 7 or 3,4 or 42,10,+ or 302,0,-.
        -G[FILE], --graph-pos-file=[FILE] A file with one graph position per
                                          line.
        -p[[path_name][,offset[,(+|-)]*]*],
        --path-pos=[[path_name][,offset[,(+|-)]*]*]
                                          Return depth at the given path
                                          position e.g. chrQ or chr3,42 or
                                          chr8,1337,+ or chrZ,3929,-.
        -F[FILE], --path-pos-file=[FILE]  A file with one path position per
                                          line.
        -b[FILE], --bed-input=[FILE]      A BED file of ranges in paths in the
                                          graph.
        -d, --graph-depth-table           Compute the depth and unique depth on
                                          each node in the graph, writing a
                                          table by node: node.id, depth,
                                          depth.uniq.
        -v, --graph-depth-vec             Compute the depth on each node in the
                                          graph, writing a vector by base in one
                                          line.
        -D, --path-depth                  Compute a vector of depth on each base
                                          of each path. Each line consists of a
                                          path name and subsequently the
                                          space-separated depth of each base.
        -a, --self-depth                  Compute the depth of the path versus
                                          itself on each base in each path. Each
                                          line consists of a path name and
                                          subsequently the space-separated depth
                                          of each base.
        -S, --summarize                   Provide a summary of the depth
                                          distribution in the graph, in a
                                          tab-delimited format it prints to
                                          stdout: node.count, graph.length,
                                          step.count, path.length,
                                          mean.node.depth
                                          (step.count/node.count), and
                                          mean.graph.depth
                                          (path.length/graph.length).
        -w[LEN:MIN:MAX:TIPS],
        --windows-in=[LEN:MIN:MAX:TIPS]   Print to stdout a BED file of path
                                          intervals where the depth is between
                                          MIN and MAX, merging regions not
                                          separated by more than LEN bp. When
                                          TIPS=1, retain only tips.
        -W[LEN:MIN:MAX:TIPS],
        --windows-out=[LEN:MIN:MAX:TIPS]  Print to stdout a BED file of path
                                          intervals where the depth is outside
                                          of MIN and MAX, merging regions not
                                          separated by more than LEN bp. When
                                          TIPS=1, retain only tips.
        -U, --window-unique-depth         For --window-in and --window-out,
                                          count UNIQUE depth, not total node
                                          depth
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use in parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi depth.
```


## odgi_draw

### Tool Description
Draw previously-determined 2D layouts of the graph with diverse annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi draw {OPTIONS}

    Draw previously-determined 2D layouts of the graph with diverse annotations.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -c[FILE], --coords-in=[FILE]      Read the layout coordinates from this
                                          .lay format FILE produced by odgi
                                          layout.
      [ Files IO ]
        -T[FILE], --tsv=[FILE]            Write the TSV layout plus displayed
                                          annotations to this FILE.
        -s[FILE], --svg=[FILE]            Write an SVG rendering to this FILE.
        -p[FILE], --png=[FILE]            Write a rasterized PNG rendering to
                                          this FILE.
        -X[FILE], --path-index=[FILE]     Load the path index from this FILE.
      [ Visualization Options ]
        -H[FILE], --png-height=[FILE]     Height of PNG rendering (default:
                                          1000).
        -E[FILE], --png-border=[FILE]     Size of PNG border in bp (default:
                                          10).
        -C, --color-paths                 Color paths (in PNG output).
        -R[N], --scale=[N]                SVG image scaling (default 0.01).
        -B[N], --border=[N]               Image border (in approximate bp)
                                          (default 100.0).
        -w[N], --line-width=[N]           Line width (in approximate bp)
                                          (default 10.0).
        -S[N], --path-line-spacing=[N]    Spacing between path lines in PNG
                                          layout (in approximate bp) (default
                                          0.0).
        -b[FILE], --bed-file=[FILE]       Color the nodes based on the input
                                          annotation in the given BED FILE.
                                          Colors are derived from the 4th
                                          column, if present, else from the path
                                          name.If the 4th column value is in the
                                          format 'string#RRGGBB', the RRGGBB
                                          color (in hex notation) will be used.
        -f[N], --svg-sparse-factor=[N]    Remove this fraction of nodes from the
                                          SVG output (to output smaller files)
                                          (default: 0.0, keep all nodes).
        -l, --svg-lengthen-nodes          When node sparsitication is active,
                                          lengthen the remaining nodes
                                          proportionally with the sparsification
                                          factor
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi draw.
```


## odgi_explode

### Tool Description
Breaks a graph into connected components storing each component in its own file.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi explode {OPTIONS}

    Breaks a graph into connected components storing each component in its own
    file.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Explode Options ]
        -g, --to-gfa                      Write each connected component to a
                                          file in GFAv1 format.
        -p[STRING], --prefix=[STRING]     Write each connected component to a
                                          file with the given STRING prefix. The
                                          file for the component number `i` will
                                          be named `STRING.i.EXTENSION`
                                          (default: `component.i.og` or
                                          `component.i.gfa`).
        -b[N], --biggest=[N]              Specify the number of the biggest
                                          connected components to write, sorted
                                          by decreasing size (default: disabled,
                                          for writing them all).
        -s[C], --sorting-criteria=[C]     Specify how to sort the connected
                                          components by size:
                                          p) Path mass (total number of path
                                          bases) (default).
                                          l) Graph length (number of node
                                          bases).
                                          n) Number of nodes.
                                          P) Longest path.
        -O, --optimize                    Compact the node ID space in each
                                          connected component.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Print information about the components
                                          and the progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi explode.
```


## odgi_extract

### Tool Description
Extract subgraphs or parts of a graph defined by query criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi extract {OPTIONS}

    Extract subgraphs or parts of a graph defined by query criteria.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Graph Files IO ]
        -o[FILE], --out=[FILE]            Store all subgraphs in this FILE. The
                                          file name usually ends with *.og*.
      [ Extract Options ]
        -d[N],
        --max-distance-subpaths=[N]       Maximum distance between subpaths
                                          allowed for merging them. It reduces
                                          the fragmentation of unspecified paths
                                          in the input path ranges. Set 0 to
                                          disable it [default: 300000].
        -e[N],
        --max-merging-iterations=[N]      Maximum number of iterations in
                                          attempting to merge close subpaths. It
                                          stops early if during an iteration no
                                          subpaths were merged [default: 6].
        -s, --split-subgraphs             Instead of writing the target
                                          subgraphs into a single graph, write
                                          one subgraph per given target to a
                                          separate file named path:start-end.og
                                          (0-based coordinates).
        -I, --inverse                     Extract the parts of the graph that do
                                          not meet the query criteria.
        -n[ID], --node=[ID]               A single node ID from which to begin
                                          our traversal.
        -l[FILE], --node-list=[FILE]      A file with one node id per line. The
                                          node specified will be extracted from
                                          the input graph.
        -c[N], --context-steps=[N]        The number of steps (nodes) away from
                                          our initial subgraph that we should
                                          collect [default: 0 (disabled)]
        -L[N], --context-bases=[N]        The number of bases away from our
                                          initial subgraph that we should
                                          collect [default: 0 (disabled)]
        -r[STRING], --path-range=[STRING] Find the node(s) in the specified path
                                          range TARGET=path[:pos1[-pos2]]
                                          (0-based coordinates).
        -b[FILE], --bed-file=[FILE]       Find the node(s) in the path range(s)
                                          specified in the given BED FILE.
        -q[STRING],
        --pangenomic-range=[STRING]       Find the node(s) in the specified
                                          pangenomic range pos1-pos2 (0-based
                                          coordinates). The nucleotide positions
                                          refer to the pangenome’s sequence
                                          (i.e., the sequence obtained arranging
                                          all the graph’s node from left to
                                          right).
        -E, --full-range                  Collects all nodes in the sorted order
                                          of the graph in the min and max
                                          positions touched by the given path
                                          ranges. This ensures that all the
                                          paths of the subgraph are not split by
                                          node, but that the nodes are laced
                                          together again. Comparable to **-R,
                                          --lace-paths=FILE**, but specifically
                                          for all paths in the resulting
                                          subgraph. Be careful to use it with
                                          very complex graphs.
        -p[FILE],
        --paths-to-extract=[FILE]         List of paths to keep in the extracted
                                          graph. The FILE must contain one path
                                          name per line and a subset of all
                                          paths can be specified. Paths
                                          specified in the input path ranges
                                          (with -r/--path-range and/or
                                          -b/--bed-file) will be kept in any
                                          case.
        -R[FILE], --lace-paths=[FILE]     List of paths to fully retain in the
                                          extracted graph. Must contain one path
                                          name per line and a subset of all
                                          paths can be specified.
        -O, --optimize                    Compact the node ID space in the
                                          extracted graph(s).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Print information about the operations
                                          and the progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi extract.
```


## odgi_flatten

### Tool Description
Generate linearizations of a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi flatten {OPTIONS}

    Generate linearizations of a graph.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Output Options ]
        -f[FILE], --fasta=[FILE]          Write the concatenated node sequences
                                          (also known as pangenome sequence) in
                                          FASTA format to FILE.
        -n[FILE], --name-seq=[FILE]       The name to use for the concatenated
                                          graph sequence (default: input file
                                          name which was specified via -i,
                                          --idx=[FILE]).
        -b[FILE], --bed=[FILE]            Write the mapping between graph paths
                                          and the linearized FASTA sequence in
                                          BED format to FILE.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi flatten.
```


## odgi_flip

### Tool Description
Flip (reverse complement) paths to match the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi flip {OPTIONS}

    Flip (reverse complement) paths to match the graph.

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. GFA is
                                          also supported.
        -o[FILE], --out=[FILE]            Write the sorted dynamic succinct
                                          variation graph to this file (e.g.
                                          *.og*).
      [ Flip Options ]
        -n[FILE], --no-flips=[FILE]       Don't flip paths listed one per line
                                          in FILE.
        -r[FILE], --ref-flips=[FILE]      Flip paths to match the orientation of
                                          the paths listed one per line in FILE.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi flip.
```


## odgi_groom

### Tool Description
Harmonize node orientations.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi groom {OPTIONS}

    Harmonize node orientations.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the groomed succinct variation
                                          graph in ODGI format to *FILE*. A file
                                          ending with *.og* is recommended.
      [ Grooming Options ]
        -d, --use-dfs                     Use depth-first search for grooming.
        -R[FILE], --target-paths=[FILE]   Read the paths that should be
                                          considered as target paths
                                          (references) from this *FILE*. odgi
                                          groom tries to force a forward
                                          orientation of all steps for the given
                                          paths. A path's rank determines it's
                                          weight for decision making and is
                                          given by its position in the given
                                          *FILE*.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi groom.
```


## odgi_heaps

### Tool Description
Extract matrix of path pangenome coverage permutations for power law regression.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi heaps {OPTIONS}

    Extract matrix of path pangenome coverage permutations for power law
    regression.

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Heaps Options ]
        -p[FILE], --path-groups=[FILE]    Group paths as described in two-column
                                          FILE, with columns path.name and
                                          group.name.
        -S, --group-by-sample             Following PanSN naming
                                          (sample#hap#ctg), group by sample (1st
                                          field).
        -H, --group-by-haplotype          Following PanSN naming
                                          (sample#hap#ctg), group by haplotype
                                          (2nd field).
        -b[FILE], --bed-targets=[FILE]    BED file over path space of the graph,
                                          describing a subset of the graph to
                                          consider.
        -n[N], --n-permutations=[N]       Number of permutations to run.
        -d[N], --min-node-depth=[N]       Exclude nodes with less than this path
                                          depth (default: 0).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi heaps.
```


## odgi_inject

### Tool Description
Inject BED interval ranges as paths in the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi inject {OPTIONS}

    Inject BED interval ranges as paths in the graph.

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the sorted dynamic succinct
                                          variation graph to this file. A file
                                          ending with *.og* is recommended.
      [ Inject Options ]
        -b[FILE], --bed-targets=[FILE]    BED file over path space of the graph.
                                          Records will be converted into new
                                          paths in the output graph.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi inject.
```


## odgi_kmers

### Tool Description
Display and characterize the kmer space of a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi kmers {OPTIONS}

    Display and characterize the kmer space of a graph.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -k[K], --kmer-length=[K]          The kmer length to generate kmers
                                          from.
      [ Kmer Options ]
        -e[N], --max-furcations=[N]       Break at edges that would be induce
                                          this many furcations in a kmer.
        -D[N], --max-degree=[N]           Don't take nodes into account that
                                          have a degree greater than N.
        -c, --stdout                      Write the kmers to stdout. Kmers are
                                          line-separated.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi kmers.
```


## odgi_layout

### Tool Description
Establish 2D layouts of the graph using path-guided stochastic gradient descent. The graph must be sorted and id-compacted.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi layout {OPTIONS}

    Establish 2D layouts of the graph using path-guided stochastic gradient
    descent. The graph must be sorted and id-compacted.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Files IO ]
        -o[FILE], --out=[FILE]            Write the layout coordinates to this
                                          FILE in .lay binary format.
        -T[FILE], --tsv=[FILE]            Write the layout in TSV format to this
                                          FILE.
        -X[FILE], --path-index=[FILE]     Load the path index from this FILE so
                                          that it does not have to be created
                                          for the layout calculation.
        -C[PATH], --temp-dir=[PATH]       directory for temporary files
        -f[FILE],
        --path-sgd-use-paths=[FILE]       Specify a line separated list of paths
                                          to sample from for the on the fly term
                                          generation process in the path guided
                                          2D SGD (default: sample from all
                                          paths).
      [ Layout Initialization Options ]
        -N[C],
        --layout-initialization=[C]       Specify the layout initialization
                                          mode:
                                          d) Node rank in X and gaussian noise
                                          in Y (default).
                                          r) Uniform noise in X and Y in the
                                          order of the graph length.
                                          u) Node rank in X and uniform noise in
                                          Y.
                                          g) Gaussian noise in X and Y.
                                          h) Hilbert curve in X and Y.
      [ PG-SGD Options ]
        -G[N],
        --path-sgd-min-term-updates-paths=[N]
                                          Minimum number of terms N to be
                                          updated before a new path guided 2D
                                          SGD iteration with adjusted learning
                                          rate eta starts, expressed as a
                                          multiple of total path length
                                          (default: 10).
        -U[N],
        --path-sgd-min-term-updates-nodes=[N]
                                          Minimum number of terms N to be
                                          updated before a new path guided
                                          linear 1D SGD iteration with adjusted
                                          learning rate eta starts, expressed as
                                          a multiple of the number of nodes
                                          (default: argument is not set, the
                                          default of -G=[N],
                                          path-sgd-min-term-updates-paths=[N] is
                                          used).
        -j[N], --path-sgd-delta=[N]       The threshold of the maximum
                                          displacement approximately in bp at
                                          which to stop path guided 2D SGD
                                          (default: 0).
        -g[N], --path-sgd-eta=[N]         The final learning rate for path
                                          guided 2D SGD model (default: 0.01).
        -v[N], --path-sgd-eta-max=[N]     The first and maximum learning rate N
                                          for path guided 2D SGD model (default:
                                          squared longest path length).
        -a[N], --path-sgd-zipf-theta=[N]  The theta value N for the Zipfian
                                          distribution which is used as the
                                          sampling method for the second node of
                                          one term in the path guided 2D SGD
                                          model (default: 0.99).
        -x[N], --path-sgd-iter-max=[N]    The maximum number of iterations N for
                                          the path guided 2D SGD model (default:
                                          30).
        -K[N], --path-sgd-cooling=[N]     Use this fraction of the iterations
                                          for layout annealing (default: 0.5).
        -F[N],
        --path-sgd-iteration-max-learning-rate=[N]
                                          Specify the iteration N where the
                                          learning rate is max for path guided
                                          2D SGD model (default: 0).
        -k[N], --path-sgd-zipf-space=[N]  The maximum space size N of the
                                          Zipfian distribution which is used as
                                          the sampling method for the second
                                          node of one term in the path guided 2D
                                          SGD model (default: max path lengths).
        -I[N],
        --path-sgd-zipf-space-max=[N]     The maximum space size N of the
                                          Zipfian distribution beyond which
                                          quantization occurs (default: 1000).
        -l[N],
        --path-sgd-zipf-space-quantization-step=[N]
                                          The size of the quantization step N
                                          when the maximum space size of the
                                          Zipfian distribution is exceeded
                                          (default: 100).
        -u[STRING],
        --path-sgd-snapshot=[STRING]      Set the prefix to which each snapshot
                                          layout of a path guided 2D SGD
                                          iteration should be written to
                                          (default: NONE).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processsing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help summary for odgi layout.
```


## odgi_matrix

### Tool Description
Write the graph topology in sparse matrix format.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi matrix {OPTIONS}

    Write the graph topology in sparse matrix format.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Matrix Options ]
        -e, --edge-depth-weight           Weigh edges by their path depth.
        -d, --delta-weight                Weigh edges by the inverse id delta.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi matrix.
```


## odgi_normalize

### Tool Description
Compact unitigs and simplify redundant furcations.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi normalize {OPTIONS}

    Compact unitigs and simplify redundant furcations.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the normalized dynamic succinct
                                          variation graph in ODGI format to this
                                          file. A file ending with *.og* is
                                          recommended.
      [ Normalize Options ]
        -I[N], --max-iterations=[N]       Iterate the normalization up to N many
                                          times (default: 10).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -d, --debug                       Print information about the
                                          normalization process to stdout.
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi
                                          normalize.
```


## odgi_overlap

### Tool Description
Find the paths touched by given input paths.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi overlap {OPTIONS}

    Find the paths touched by given input paths.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --input=[FILE]          Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Overlap Options ]
        -s[FILE], --subset-paths=[FILE]   Perform the search considering only
                                          the paths specified in the FILE. The
                                          file must contain one path name per
                                          line and a subset of all paths can be
                                          specified.When searching the overlaps,
                                          only these paths will be considered.
        -r[PATH_NAME], --path=[PATH_NAME] Perform the search of the given path
                                          STRING in the graph.
        -R[FILE], --paths=[FILE]          Report the search results only for the
                                          paths listed in FILE.
        -b[FILE], --bed-input=[FILE]      A BED FILE of ranges in paths in the
                                          graph.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        display this help summary
```


## odgi_panpos

### Tool Description
Get the pangenome position of a given path and nucleotide position (1-based).

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi panpos {OPTIONS}

    Get the pangenome position of a given path and nucleotide position
    (1-based).

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph
                                          index in xp format from this *FILE*.
                                          The file name usually ends with *.xp*.
        -p[STRING], --path=[STRING]       The path name of the query.
        -n[N], --nuc-pos=[N]              The nucleotide position of the query.
      [ Program Information ]
        -h, --help                        Print a help message for odgi panpos.
```


## odgi_pathindex

### Tool Description
Create a path index for a given graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi pathindex {OPTIONS}

    Create a path index for a given graph.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*.
        -o[FILE], --out=[FILE]            Write the succinct variation graph
                                          index to this FILE. A file ending with
                                          *.xp* is recommended.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi
                                          pathindex.
```


## odgi_paths

### Tool Description
Interrogate the embedded paths of a graph. Does not print anything to stdout by default!

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi paths {OPTIONS}

    Interrogate the embedded paths of a graph. Does not print anything to stdout
    by default!

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Path Investigation Options ]
        -O[FILE], --overlaps=[FILE]       Read in the path grouping *FILE* to
                                          generate the overlap statistics from.
                                          The file must be tab-delimited. The
                                          first column lists a grouping and the
                                          second the path itself. Each line has
                                          one path entry. For each group the
                                          pairwise overlap statistics for each
                                          pairing will be calculated and printed
                                          to stdout.
        -L, --list-paths                  Print the paths in the graph to
                                          stdout. Each path is printed in its
                                          own line.
        -l, --list-path-start-end         If -L,--list-paths was specified, this
                                          additionally prints the start and end
                                          positions of each path in additional,
                                          tab-delimited coloumns.
        -f, --fasta                       Print paths in FASTA format to stdout.
                                          One line for the FASTA header, another
                                          line for the whole sequence.
        -H, --haplotypes                  Print to stdout the paths in a path
                                          coverage haplotype matrix based on the
                                          graph’s sort order. The output is
                                          tab-delimited: *path.name*,
                                          *path.length*, *path.step.count*,
                                          *node.1*, *node.2*, *node.n*. Each
                                          path entry is printed in its own line.
        -N, --scale-by-node-len           Scale the haplotype matrix cells by
                                          node length.
      [ Non-ref. Sequence Options ]
        --non-reference-nodes=[FILE]      Print to stdout IDs of nodes that are
                                          not in the paths listed (by line) in
                                          *FILE*.
        --non-reference-ranges=[FILE]     Print to stdout (in BED format) path
                                          ranges that are not in the paths
                                          listed (by line) in *FILE*.
      [ Sequence Type Options ]
        --coverage-levels=[c1,c2,...,cN]  List of coverage thresholds (number of
                                          paths that pass through the node).
                                          Print to stdout a TAB-separated table
                                          with node ID, node length, and class.
        --fraction-levels=[f1,f2,...,fN]  List of fraction thresholds (fraction
                                          of paths that pass through the node).
                                          Print to stdout a TAB-separated table
                                          with node ID , node length, and
                                          class.')]
        --path-range-class                Instead of node information, print to
                                          stdout a TAB-separated table with path
                                          range and class.
      [ Common Options ]
        --min-size=[N]                    Minimum size (in bps) of nodes (with
                                          --non-reference-nodes or
                                          --coverage-levels/fraction-levels) or
                                          ranges (with --non-reference-ranges or
                                          --coverage-levels/fraction-levels
                                          together with --path-range-class).
        --show-step-ranges                Show steps (that is, node IDs and
                                          strands) (with --non-reference-ranges
                                          or --coverage-levels/fraction-levels
                                          together with --path-range-class).
        -D[CHAR], --delim=[CHAR]          The part of each path name before this
                                          delimiter CHAR is a group identifier.
                                          For use with -H/--haplotypes,
                                          --non-reference-ranges or
                                          --coverage-levels/fraction-levels.
                                          With -H/--haplotypes it prints an
                                          additional, first column
                                          **group.name** to stdout.
        -p[N], --delim-pos=[N]            Consider the N-th occurrence of the
                                          delimiter specified with **-D,
                                          --delim** to obtain the group
                                          identifier. Specify 1 for the 1st
                                          occurrence (default).
      [ Path Modification Options ]
        -K[FILE], --keep-paths=[FILE]     Keep paths listed (by line) in *FILE*.
        -X[FILE], --drop-paths=[FILE]     Drop paths listed (by line) in *FILE*.
        -o[FILE], --out=[FILE]            Write the dynamic succinct variation
                                          graph to this file (e.g. *.og*).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi paths.
```


## odgi_pav

### Tool Description
Presence/absence variants (PAVs). It prints to stdout a TSV table with the 'PAV ratios'. For a given path range 'PR' and path 'P', the 'PAV ratio' is the ratio between the sum of the lengths of the nodes in 'PR' that are crossed by 'P' divided by the sum of the lengths of all the nodes in 'PR'. Each node is considered only once.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi pav {OPTIONS}

    Presence/absence variants (PAVs). It prints to stdout a TSV table with the
    'PAV ratios'. For a given path range 'PR' and path 'P', the 'PAV ratio' is
    the ratio between the sum of the lengths of the nodes in 'PR' that are
    crossed by 'P' divided by the sum of the lengths of all the nodes in 'PR'.
    Each node is considered only once.

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -b[FILE], --bed-file=[FILE]       Find PAVs in the path range(s)
                                          specified in the given BED FILE.
      [ Pav Options ]
        -p[FILE], --path-groups=[FILE]    Group paths as described in two-column
                                          FILE, with columns path.name and
                                          group.name.
        -S, --group-by-sample             Following PanSN naming
                                          (sample#hap#ctg), group by sample (1st
                                          field).
        -H, --group-by-haplotype          Following PanSN naming
                                          (sample#hap#ctg), group by haplotype
                                          (2nd field).
        -B[THRESHOLD],
        --binary-values=[THRESHOLD]       Print 1 if the PAV ratio is greater
                                          than or equal to the specified
                                          THRESHOLD, else 0.
        -M, --matrix-output               Emit the PAV ratios in a matrix, with
                                          path ranges as rows and paths/groups
                                          as columns.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi pav.
```


## odgi_position

### Tool Description
Find, translate, and liftover graph and path positions between graphs. Results are printed to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi position {OPTIONS}

    Find, translate, and liftover graph and path positions between graphs.
    Results are printed to stdout.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --target=[FILE]         Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Position Options ]
        -x[FILE], --source=[FILE]         Translate positions from this *FILE
                                          graph into the target graph using
                                          common *-l, --lift-paths* shared
                                          between both graphs (default: use the
                                          same source/target graph). It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -r[PATH_NAME],
        --ref-path=[PATH_NAME]            Translate the given positions into
                                          positions relative to this reference
                                          path.
        -R[FILE], --ref-paths=[FILE]      Use the ref-paths in *FILE* for
                                          positional translation.
        -l[PATH_NAME],
        --lift-path=[PATH_NAME]           Lift positions from *-x, --source* to
                                          *-i, --target* via coordinates in this
                                          path common to both graphs (default:
                                          all common paths between *-x,
                                          --source* and *-i, --target*).
        -L[FILE], --lift-paths=[FILE]     Same as in *-l, --lift-paths*, but for
                                          all paths in *FILE*.
        -g[[node_id][,offset[,(+|-)]*]*],
        --graph-pos=[[node_id][,offset[,(+|-)]*]*]
                                          A graph position, e.g. 42,10,+ or
                                          302,0,-.
        -G[FILE], --graph-pos-file=[FILE] Same as in *-g, --graph-pos*, but for
                                          all graph positions in *FILE*.
        -p[[path_name][,offset[,(+|-)]*]*],
        --path-pos=[[path_name][,offset[,(+|-)]*]*]
                                          A path position, e.g. chr8,1337,+ or
                                          chrZ,3929,-.
        -F[FILE], --path-pos-file=[FILE]  A *FILE* with one path position per
                                          line.
        -b[FILE], --bed-input=[FILE]      A BED file of ranges in paths in the
                                          graph to lift into the target graph
                                          *-v, --give-graph-pos* emit graph
                                          positions.
        -E[FILE], --gff-input=[FILE]      A GFF/GTF file with annotation of
                                          ranges in paths in the graph to lift
                                          into the target (sub)graph emitting
                                          graph identifiers with annotation. The
                                          output is a CSV reading for the
                                          visualization within Bandage. The
                                          first column is the node identifier,
                                          the second column the annotation. If
                                          several annotations exist for the same
                                          node, they are combined via ';'.
        -v, --give-graph-pos              Emit graph positions (node, offset,
                                          strand) rather than path positions.
        -I, --all-immediate               Emit all positions immediately at the
                                          given graph/path position.
        -d[DISTANCE],
        --search-radius=[DISTANCE]        Limit coordinate conversion
                                          breadth-first search up to DISTANCE bp
                                          from each given position (default:
                                          10000).
        -w[N], --jaccard-context=[N]      Maximum walking distance in
                                          nucleotides for one orientation when
                                          finding the best target (reference)
                                          range for each query path (default:
                                          10000). Note: If we walked 9999 base
                                          pairs and **w, --jaccard-context** is
                                          **10000**, we will also include the
                                          next node, even if we overflow the
                                          actual limit.
        --all-positions                   Emit all positions for all nodes in
                                          the specified ref-paths.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information
        -h, --help                        Print a help message for odgi
                                          position.
```


## odgi_priv

### Tool Description
Differentially private sampling of graph subpaths. Apply the exponential mechanism to randomly sample shared sub-haplotypes with a given ε, target coverage, and minimum length.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi priv {OPTIONS}

    Differentially private sampling of graph subpaths. Apply the exponential
    mechanism to randomly sample shared sub-haplotypes with a given ε, target
    coverage, and minimum length.

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE* (both
                                          GFAv1 and .og format accepted).
        -o[FILE], --out=[FILE]            Write the graph with sub-paths sampled
                                          under differential privacy to this
                                          FILE (.og recommended).
      [ Differential Privacy Mechanism
      ]
        -e[e], --epsilon=[e]              Epsilon (ε) for exponential
                                          mechanism. [default: 0.01]
        -d[DEPTH], --target-depth=[DEPTH] Sample until we have approximately
                                          this path depth over the graph.
                                          [default: 1]
        -c[N], --min-hap-freq=[N]         Minimum frequency (count) of haplotype
                                          observation to emit. Singularities
                                          occur at -c 1, so we warn against its
                                          use. [default: 2]
        -b[bp], --bp-target=[bp]          Target sampled haplotype length. All
                                          long haplotypes tend to be rare, so
                                          setting this to lengths greater than
                                          the typical recombination block size
                                          will result in long runtimes and poor
                                          sampling of the graph. [default:
                                          10000]
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
        -W, --write-haps                  Write each sampled haplotype to
                                          stdout.
      [ Program Information ]
        -h, --help                        Print a help message for odgi paths.
```


## odgi_procbed

### Tool Description
Intersect and adjust BED interval into PanSN-defined path subranges. Lift BED files into graphs produced by odgi extract. Uses path range information in the path names.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi procbed {OPTIONS}

    Pprocrustes-BED: Intersect and adjust BED interval into PanSN-defined path
    subranges. Lift BED files into graphs produced by odgi extract. Uses path
    range information in the path names.

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Procbed Options ]
        -b[FILE], --bed-targets=[FILE]    BED file over path space of the full
                                          graph from which this subgraph was
                                          obtained. Using path range information
                                          in the path names, overlapping records
                                          will be rewritten to fit into the
                                          coordinate space of the subgraph.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi procbed.
```


## odgi_prune

### Tool Description
Remove parts of the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi prune {OPTIONS}

    Remove parts of the graph.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the pruned graph in ODGI format
                                          to *FILE*. A file ending with *.og* is
                                          recommended.
      [ Kmer Options ]
        -k[K], --kmer-length=[K]          The length of the kmers to consider.
        -e[N], --max-furcations=[N]       Break at edges that would induce *N*
                                          many furcations in a kmer.
      [ Node Options ]
        -d[N], --max-degree=[N]           Remove nodes that have a higher node
                                          degree than *N*.
        -c[N], --min-depth=[N]            Remove nodes covered by fewer than *N*
                                          number of path steps.
        -C[N], --max-depth=[N]            Remove nodes covered by more than *N*
                                          number of path steps.
        -T, --cut-tips                    Remove nodes which are graph tips.
      [ Edge Options ]
        -E, --edge-depth                  Remove edges outside of the minimum
                                          and maximum coverage rather than
                                          nodes. Only set this argument in
                                          combination with **-c,
                                          –min-coverage**=*N* and **-C,
                                          --max-coverage**=*N*.
        -b[N], --best-edges=[N]           Only keep the *N* most covered inbound
                                          and output edges of each node.
      [ Step Options ]
        -s[N], --expand-steps=[N]         Also include nodes within this many
                                          steps of a component passing the prune
                                          thresholds.
        -l[N], --expand-length=[N]        Also include nodes within this graph
                                          nucleotide distance of a component
                                          passing the prune thresholds.
      [ Path Options ]
        -p[N], --expand-path-length=[N]   Also include nodes within this path
                                          length of a component passing the
                                          prune thresholds.
        -r[FILE], --drop-paths=[FILE]     List of paths to remove. The FILE must
                                          contain one path name per line and a
                                          subset of all paths can be specified.
        -D, --drop-all-paths              Remove all paths from the graph.
        -y, --drop-empty-paths            Remove empty paths from the graph.
        -m[N], --cut-tips-min-depth=[N]   Remove nodes which are graph tips and
                                          have less than *N* path depth.
        -I, --remove-isolated             Remove isolated nodes covered by a
                                          single path.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi prune.
```


## odgi_server

### Tool Description
Start a basic HTTP server with a given path index file to go from *path:position* to *pangenome:position* very efficiently.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi server {OPTIONS}

    Start a basic HTTP server with a given path index file to go from
    *path:position* to *pangenome:position* very efficiently.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph
                                          index from this *FILE*. The file name
                                          usually ends with *.xp*.
        -p[N], --port=[N]                 Run the server under this port.
      [ HTTP Options ]
        -a[IP], --ip=[IP]                 Run the server under this IP address.
                                          If not specified, *IP* will be
                                          *localhost*.
      [ Program Information ]
        -h, --help                        Print a help message for odgi server.
```


## odgi_similarity

### Tool Description
Provides a sparse similarity matrix for paths or groups of paths. Each line prints in a tab-delimited format to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi similarity {OPTIONS}

    Provides a sparse similarity matrix for paths or groups of paths. Each line
    prints in a tab-delimited format to stdout.

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Node Masking Options ]
        -m[FILE], --mask=[FILE]           Load node mask from this file. Each
                                          line contains a 0 or 1, where 0 means
                                          the node at that position should be
                                          ignored in similarity computation.
      [ Path Investigation Options ]
        -D[CHAR], --delim=[CHAR]          The part of each path name before this
                                          delimiter CHAR is a group identifier.
        -p[N], --delim-pos=[N]            Consider the N-th occurrence of the
                                          delimiter specified with **-D,
                                          --delim** to obtain the group
                                          identifier. Specify 1 for the 1st
                                          occurrence (default).
        -d, --distances                   Provide distances (dissimilarities)
                                          instead of similarities. Outputs
                                          additional columns with the Euclidean
                                          and Manhattan distances.
        -a, --all                         Emit entries for all pairs of
                                          paths/groups, including those with
                                          zero intersection.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi
                                          similarity.
```


## odgi_sort

### Tool Description
Apply different kind of sorting algorithms to a graph. The most prominent one is the PG-SGD sorting algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi sort {OPTIONS}

    Apply different kind of sorting algorithms to a graph. The most prominent
    one is the PG-SGD sorting algorithm.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the sorted dynamic succinct
                                          variation graph to this file. A file
                                          ending with *.og* is recommended.
      [ Files IO Options ]
        -X[FILE], --path-index=[FILE]     Load the succinct variation graph
                                          index from this *FILE*. The file name
                                          usually ends with *.xp*.
        -s[FILE], --sort-order=[FILE]     *FILE* containing the sort order. Each
                                          line contains one node identifer.
        -C[PATH], --temp-dir=[PATH]       directory for temporary files
      [ Topological Sort Options ]
        -b, --breadth-first               Use a (chunked) breadth first
                                          topological sort.
        -B[N], --breadth-first-chunk=[N]  Chunk size for breadth first
                                          topological sort. Specify how many
                                          nucleotides to grap at once in each
                                          BFS phase.
        -c, --cycle-breaking              Use a cycle breaking sort.
        -z, --depth-first                 Use a (chunked) depth first
                                          topological sort.
        -Z[N], --depth-first-chunk=[N]    Chunk size for the depth first
                                          topological sort. Specify how many
                                          nucleotides to grap at once in each
                                          DFS phase.
        -w, --two-way                     Use a two-way topological algorithm
                                          for sorting. It is a maximum of
                                          head-first and tail-first topological
                                          sort.
        -n, --no-seeds                    Don't use heads or tails to seed the
                                          topological sort.
      [ Random Sort Options ]
        -r, --random                      Randomly sort the graph.
      [ DAGify Sort Options ]
        -d, --dagify-sort                 Sort on the basis of a DAGified graph.
      [ Path Guided 1D SGD Sort ]
        -Y, --path-sgd                    Apply the path-guided linear 1D SGD
                                          algorithm to organize graph.
        -f[FILE],
        --path-sgd-use-paths=[FILE]       Specify a line separated list of paths
                                          to sample from for the on the fly term
                                          generation process in the path guided
                                          linear 1D SGD (default: sample from
                                          all paths).
        -G[N],
        --path-sgd-min-term-updates-paths=[N]
                                          The minimum number of terms to be
                                          updated before a new path guided
                                          linear 1D SGD iteration with adjusted
                                          learning rate eta starts, expressed as
                                          a multiple of total path steps
                                          (default: *1.0*). Can be overwritten
                                          by *-U,
                                          -path-sgd-min-term-updates-nodes=N*.
        -U[N],
        --path-sgd-min-term-updates-nodes=[N]
                                          The minimum number of terms to be
                                          updated before a new path guided
                                          linear 1D SGD iteration with adjusted
                                          learning rate eta starts, expressed as
                                          a multiple of the number of nodes
                                          (default: NONE.
                                          *-G,path-sgd-min-term-updates-paths=N*
                                          is used).
        -j[N], --path-sgd-delta=[N]       The threshold of maximum displacement
                                          approximately in bp at which to stop
                                          path guided linear 1D SGD (default:
                                          *0.0*).
        -g[N], --path-sgd-eps=[N]         The final learning rate for path
                                          guided linear 1D SGD model (default:
                                          *0.01*).
        -v[N], --path-sgd-eta-max=[N]     The first and maximum learning rate
                                          for path guided linear 1D SGD model
                                          (default: *squared steps of longest
                                          path in graph*).
        -a[N], --path-sgd-zipf-theta=[N]  The theta value for the Zipfian
                                          distribution which is used as the
                                          sampling method for the second node of
                                          one term in the path guided linear 1D
                                          SGD model (default: *0.99*).
        -x[N], --path-sgd-iter-max=[N]    The maximum number of iterations for
                                          path guided linear 1D SGD model
                                          (default: 100).
        -K[N], --path-sgd-cooling=[N]     Use this fraction of the iterations
                                          for layout annealing (default: 0.5).
        -F[N],
        --iteration-max-learning-rate=[N] The iteration where the learning rate
                                          is max for path guided linear 1D SGD
                                          model (default: *0*).
        -k[N], --path-sgd-zipf-space=[N]  The maximum space size of the Zipfian
                                          distribution which is used as the
                                          sampling method for the second node of
                                          one term in the path guided linear 1D
                                          SGD model (default: *longest path
                                          length*).
        -I[N],
        --path-sgd-zipf-space-max=[N]     The maximum space size of the Zipfian
                                          distribution beyond which quantization
                                          occurs (default: *100*).
        -l[N],
        --path-sgd-zipf-space-quantization-step=[N]
                                          Quantization step size when the
                                          maximum space size of the Zipfian
                                          distribution is exceeded (default:
                                          *100*).
        -y[N],
        --path-sgd-zipf-max-num-distributions=[N]
                                          Approximate maximum number of Zipfian
                                          distributions to calculate (default:
                                          *100*).
        -q[STRING],
        --path-sgd-seed=[STRING]          | Set the seed for the deterministic
                                          1-threaded path guided linear 1D SGD
                                          model (default: *pangenomic!*).
        -u[STRING],
        --path-sgd-snapshot=[STRING]      Set the prefix to which each snapshot
                                          graph of a path guided 1D SGD
                                          iteration should be written to. This
                                          is turned off per default. This
                                          argument only works when *-Y,
                                          –path-sgd* was specified. Not
                                          applicable in a pipeline of sorts.
        -H[FILE], --target-paths=[FILE]   Read the paths that should be
                                          considered as target paths
                                          (references) from this *FILE*. PG-SGD
                                          will keep the nodes of the given paths
                                          fixed. A path's rank determines it's
                                          weight for decision making and is
                                          given by its position in the given
                                          *FILE*.
        -e[STRING],
        --path-sgd-layout=[STRING]        write the layout of a sorted, path
                                          guided 1D SGD graph to this file, no
                                          default
      [ Pipeline Sorting Options ]
        -p[STRING], --pipeline=[STRING]   Apply a series of sorts, based on
                                          single character command line
                                          arguments given to this command
                                          (default: NONE). *s*: Topolocigal
                                          sort, heads only. *n*: Topological
                                          sort, no heads, no tails. *d*: DAGify
                                          sort. *c*: Cycle breaking sort. *b*:
                                          Breadth first topological sort. *z*:
                                          Depth first topological sort. *w*:
                                          Two-way topological sort. *r*: Random
                                          sort. *Y*: PG-SGD 1D sort. *f*:
                                          Reverse order. *g*: Groom the graph.
                                          An example could be *Ygs*.
      [ Path Sorting Options ]
        -L, --paths-min                   Sort paths by their lowest contained
                                          node identifier.
        -M, --paths-max                   Sort paths by their highest contained
                                          node identifier.
        -A, --paths-avg                   Sort paths by their average contained
                                          node identifier.
        -R, --paths-avg-rev               Sort paths in reverse by their average
                                          contained node identifier.
        -D[path-delim],
        --path-delim=[path-delim]         Sort paths in bins by their prefix up
                                          to this delimiter.
      [ Optimize Options ]
        -O, --optimize                    Use the MutableHandleGraph::optimize
                                          method to compact the node identifier
                                          space.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi sort.
```


## odgi_squeeze

### Tool Description
Squeezes multiple graphs in ODGI format into the same file in ODGI format.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi squeeze {OPTIONS}

    Squeezes multiple graphs in ODGI format into the same file in ODGI format.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -f[FILE], --input-graphs=[FILE]   Input file containing the list of
                                          graphs to squeeze into the same
                                            file. The file must contain one
                                          graph per line. It also accepts GFAv1,
                                          but the on-the-fly conversion to the
                                          ODGI format requires additional time!
        -o[FILE], --out=[FILE]            Store all the input graphs in this
                                          file. The file name usually ends with
                                          *.og*.
      [ Squeeze Options ]
        -s[STRING],
        --rank-suffix=[STRING]            Add the separator and the input file
                                          rank as suffix to the path names
                                            (to avoid path name collisions).
      -O, --optimize                    Compact the node ID space for each
                                        connected component before squeezing.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
      -P, --progress                    Print information about the progress to
                                        stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi squeeze.
```


## odgi_stats

### Tool Description
Metrics describing a variation graph and its path relationship.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi stats {OPTIONS}

    Metrics describing a variation graph and its path relationship.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Summary Options ]
        -S, --summarize                   Summarize the graph properties and
                                          dimensions. Print to stdout the
                                          #nucleotides, #nodes, #edges, #paths,
                                          #steps in a tab-delimited format.
        -W, --weak-connected-components   Shows the properties of the weakly
                                          connected components.
        -L, --self-loops                  Number of nodes with a self-loop.
        -N, --nondeterministic-edges      Show nondeterministic edges (those
                                          that extend to the same next base).
        -b, --base-content                Describe the base content of the
                                          graph. Print to stdout the #A, #C, #G
                                            and #T in a tab-delimited format.
        -D[STRING], --delim=[STRING]      The part of each path name before this
                                          delimiter is a group identifier, which
                                          when specified will ensure that odgi
                                          stats collects the summary information
                                          per group and not per path.
        -f, --file-size                   Show the file size in bytes.
        -a[DELIM,POS],
        --pangenome-sequence-class-counts=[DELIM,POS]
                                          Show counted pangenome sequence class
                                          counts of all samples. Classes are
                                          Private (only one sample visiting the
                                          node), Core (all samples visiting the
                                          node), and Shell (not Core or
                                          Private). The given String determines
                                          how to find the sample name in the
                                          path names: DELIM,POS. Split the whole
                                          path name by DELIM and access the
                                          actual sample name at POS of the split
                                          result. If the full path name is the
                                          sample name, select a DELIM that is
                                          not in the path names and set POS to
                                          0. If -m,--multiqc was set, this
                                          OPTION has to be set implicitly.
      [ Sorting Goodness Eval Options ]
        -c[FILE], --coords-in=[FILE]      Load the 2D layout coordinates in
                                          binary layout format from this *FILE*.
                                          The file name usually ends with
                                          *.lay*. The sorting goodness
                                          evaluation will then be performed for
                                          this *FILE*. When the layout
                                          coordinates are provided, the mean
                                          links length and the sum path nodes
                                          distances statistics are evaluated in
                                          2D, else in 1D. Such a file can be
                                          generated with *odgi layout*.
        -l, --mean-links-length           Calculate the mean links length. This
                                          metric is path-guided and computable
                                          in 1D and 2D.
        -g, --no-gap-links                Don’t penalize gap links in the mean
                                          links length. A gap link is a link
                                          which connects two nodes that are
                                          consecutive in the linear pangenomic
                                          order. This option is specifiable only
                                          to compute the mean links length in
                                          1D.
        -s, --sum-path-nodes-distances    Calculate the sum of path nodes
                                          distances. This metric is path-guided
                                          and computable in 1D and 2D. For each
                                          path, it iterates from node to node,
                                          summing their distances, and
                                          normalizing by the path length. In 1D,
                                          if a link goes back in the linearized
                                          viewpoint of the graph, this is
                                          penalized (adding 3 times its length
                                          in the sum).
        -d,
        --penalize-different-orientation  If a link connects two nodes which
                                          have different orientations, this is
                                          penalized (adding 2 times its length
                                          in the sum).
        -p, --path-statistics             Display the statistics (mean links
                                          length or sum path nodes distances)
                                          for each path.
        -w, --weighted-feedback-arc       Compute the sum of weights of all
                                          feedback arcs, i.e. backward pointing
                                          edges the statistics (the weight is
                                          the number of times the edge is
                                          traversed by paths).
        -j, --weighted-reversing-join     Compute the sum of weights of all
                                          reversing joins, i.e. edges joining
                                          two in- or two out-sides (the weight
                                          is the number of times the edge is
                                          traversed by paths).
        -q, --links_length_per_nuc        Compute the links length per
                                          nucleotide, i.e. sum up the links
                                          lengths of all paths and divide this
                                          value by the nucleotide lengths of all
                                          paths. This metric can be used to
                                          compare the linearity of different
                                          graphs. By default we don't count gap
                                          links.
      [ IO Format Options ]
        -m, --multiqc                     Setting this option prints all!
                                          statistics in YAML format instead of
                                          pseudo TSV to stdout. This includes
                                          *-S,--summarize*,
                                          *-W,--weak-connected-components*,
                                          *-L,--self-loops*,
                                          *-b,--base-content*,
                                          *-l,--mean-links-length*,
                                          *-g,--no-gap-links*,
                                          *-s,--sum-path-nodes-distances*,
                                          *-f,--file-size*, and
                                          *-d,--penalize-different-orientation*.
                                          *-p,path-statistics* is still
                                          optional. Not applicable to
                                          *-N,--nondeterministic-edges*.
                                          Overwrites all other given OPTIONs!
                                          The output is perfectly curated for
                                          the ODGI MultiQC module.
        -y, --yaml                        Setting this option prints all
                                          selected statistics in YAML format
                                          instead of pseudo TSV to stdout.
      [ Processing Information ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi stats.
```


## odgi_stepindex

### Tool Description
Generate a step index from a given graph. If no output file is provided via *-o, --out*, the index will be directly written to *INPUT_GRAPH.stpidx*.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi stepindex {OPTIONS}

    Generate a step index from a given graph. If no output file is provided via
    *-o, --out*, the index will be directly written to *INPUT_GRAPH.stpidx*.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --input=[FILE]          Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the created step index to the
                                          specified file. A file ending with
                                          *.stpidx* is recommended. (default:
                                          *INPUT_GRAPH.stpidx*).
      [ Step Index Options ]
        -a[N],
        --step-index-sample-rate=[N]      The sample rate when building the step
                                          index. We index a node only if
                                          mod(node_id, step-index-sample-rate)
                                          == 0! Number must be dividable by 2 or
                                          0 to disable sampling. (default: 8).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi
                                          validate.
```


## odgi_tension

### Tool Description
evaluate the tension of a graph helping to locate structural variants and abnormalities

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi tension {OPTIONS}

    evaluate the tension of a graph helping to locate structural variants and
    abnormalities

  OPTIONS:

      [ MANDATORY ARGUMENTS ]
        -i[FILE], --idx=[FILE]            load the graph from this file
        -c[FILE], --coords-in=[FILE]      read the layout coordinates from this
                                          .lay format file produced by odgi sort
                                          or odgi layout
      [ Tension Options ]
        -w[N], --window-size=[N]          window size in bases in which each
                                          tension is calculated, DEFAULT: 1kb
        -n, --node-sized-windows          instead of manual window sizes, each
                                          window has the size of the node of the
                                          step we are currently iterating
        -p, --pangenome-mode              calculate the tension for each node of
                                          the pangenome: node tension is the sum
                                          of the tension of all steps visiting
                                          that node. Results are written in TSV
                                          format to stdout. 1st col: node
                                          identifier. 2nd col:
                                          tension=(path_layout_dist/path_nuc_dist).
                                          3rd col: 2nd_col/#steps_on_node.
                                          (DEFAULT: ENABLED)
      [ Threading ]
      -t[N], --threads=[N]              number of threads to use for parallel
                                        phases
      [ Processing Information ]
        -P, --progress                    display progress
      [ Program Information ]
        -h, --help                        display this help summary
```


## odgi_tips

### Tool Description
Identifying break point positions relative to given query (reference) path(s) of all the tips in the graph or of tips of given path(s). Prints BED records to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi tips {OPTIONS}

    Identifying break point positions relative to given query (reference)
    path(s) of all the tips in the graph or of tips of given path(s). Prints BED
    records to stdout.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --input=[FILE]          Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Tips Options ]
        -q[NAME], --query-path=[NAME]     Use this query path.
        -r[NAME], --target-path=[NAME]    Use this target (reference) path.
        -Q[FILE], --query-paths=[FILE]    Use query paths listed (one per line)
                                          in FILE.
        -R[FILE], --target-paths=[FILE]   Use target (reference) paths listed
                                          (one per line) in FILE.
        -v[FILE],
        --not-visited-tsv=[FILE]          Write target path(s) that do not visit
                                          the query path(s) to this FILE.
        -n[N], --n-best=[N]               Report up to the Nth best target
                                          (reference) mapping for each query
                                          path (default: 1).
        -w[N], --jaccard-context=[N]      Maximum walking distance in
                                          nucleotides for one orientation when
                                          finding the best target (reference)
                                          range for each query path (default:
                                          10000). Note: If we walked 9999 base
                                          pairs and **w, --jaccard-context** is
                                          **10000**, we will also include the
                                          next node, even if we overflow the
                                          actual limit.
        -j, --jaccards                    If for a target (reference) path
                                          several matches are possible, also
                                          report the additional jaccard indices
                                          (default: false). In the resulting
                                          BED, an '.' is added, if set to
                                          'false'.
      [ Step Index Options ]
        -a[FILE], --step-index=[FILE]     Load the step index from this *FILE*.
                                          The file name usually ends with
                                          *.stpidx*. (default: build the step
                                          index from scratch with a sampling
                                          rate of 8).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi tips.
```


## odgi_unchop

### Tool Description
Merge unitigs into a single node preserving the node order.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi unchop {OPTIONS}

    Merge unitigs into a single node preserving the node order.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the unchopped dynamic succinct
                                          variation graph in ODGI format to this
                                          *FILE*. A file ending with *.og* is
                                          recommended.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Print information about the process to
                                          stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi unchop.
```


## odgi_unitig

### Tool Description
Output unitigs of the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi unitig {OPTIONS}

    Output unitigs of the graph.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ FASTQ Options ]
        -f, --fake-fastq                  Write the unitigs in FASTQ format to
                                          stdout with a fixed quality value of
                                          *I*.
      [ Unitig Options ]
        -t[N], --sample-to=[N]            Continue unitigs with a random walk in
                                          the graph so that they have at least
                                          the given *N* length.
        -p[N], --sample-plus=[N]          Continue unitigs with a random walk in
                                          the graph by *N* past their natural
                                          end.
        -l[N],
        --min-begin-node-length=[N]       Only begin unitigs collection from
                                          nodes which have at least length *N*.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi unitig.
```


## odgi_untangle

### Tool Description
Project paths into reference-relative BEDPE (optionally PAF), to decompose paralogy relationships.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi untangle {OPTIONS}

    Project paths into reference-relative BEDPE (optionally PAF), to decompose
    paralogy relationships.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Untangling Options ]
        -q[NAME], --query-path=[NAME]     Use this query path.
        -r[NAME], --target-path=[NAME]    Use this target (reference) path.
        -Q[FILE], --query-paths=[FILE]    Use query paths listed (one per line)
                                          in FILE.
        -R[FILE], --target-paths=[FILE]   Use target (reference) paths listed
                                          (one per line) in FILE.
        -m[N], --merge-dist=[N]           Merge segments shorter than this
                                          length into previous segments.
        -s[N], --max-self-coverage=[N]    Skip mappings with greater than this
                                          level of self-coverage.
        -n[N], --n-best=[N]               Report up to the Nth best target
                                          (reference) mapping for each query
                                          segment (default: 1).
        -j[F], --min-jaccard=[F]          Report target mappings >= the given
                                          jaccard threshold, with 0 <= F <= 1.0
                                          (default: 0.0).
        -e[N], --cut-every=[N]            Start a segment boundary every Nbp of
                                          the sorted graph (default: 0/off).
        -p, --paf-output                  Emit the output in PAF format.
        -G, --gene-order                  Write each query as a series of target
                                          gene segments.
        -g, --gggenes-output              Emit the output in gggenes-compatible
                                          tabular format.
        -X, --gggenes-schematic           Emit the output in gggenes-compatible
                                          *schematic* tabular format, where each
                                          gene is rendered as 100bp.
        -c[FILE],
        --cut-points-input=[FILE]         A text file of node identifiers (one
                                          identifier per row) where to start the
                                          segment boundaries.When specified, no
                                          further starting points will be added.
        -d[FILE],
        --cut-points-output=[FILE]        Emit node identifiers where segment
                                          boundaries started (one identifier per
                                          row).
      [ Debugging Options ]
        -S, --self-dotplot                Render a table showing the positional
                                          dotplot of the query against itself.
      [ Step Index Options ]
        -a[FILE], --step-index=[FILE]     Load the step index from this *FILE*.
                                          The file name usually ends with
                                          *.stpidx*. (default: build the step
                                          index from scratch with a sampling
                                          rate of 8).
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi
                                          untangle.
```


## odgi_validate

### Tool Description
Validate a graph checking if the paths are consistent with the graph topology.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi validate {OPTIONS}

    Validate a graph checking if the paths are consistent with the graph
    topology.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --input=[FILE]          Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi
                                          validate.
```


## odgi_view

### Tool Description
Project a graph into other formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi view {OPTIONS}

    Project a graph into other formats.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
      [ Output Options ]
        -g, --to-gfa                      Write the graph in GFAv1 format to
                                          standard output.
        -a, --node-annotation             Emit node annotations for the graph in
                                          GFAv1 format.
        -d, --display                     Show the internal structures of a
                                          graph. Print to stderr the maximum
                                          node identifier, the minimum node
                                          identifier, the nodes vector, the
                                          delete nodes bit vector and the path
                                          metadata, each in a separate line.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi view.
```


## odgi_viz

### Tool Description
Visualize a variation graph in 1D.

### Metadata
- **Docker Image**: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
- **Homepage**: https://github.com/vgteam/odgi
- **Package**: https://anaconda.org/channels/bioconda/packages/odgi/overview
- **Validation**: PASS

### Original Help Text
```text
Flag could not be matched: h
  odgi viz {OPTIONS}

    Visualize a variation graph in 1D.

  OPTIONS:

      [ MANDATORY OPTIONS ]
        -i[FILE], --idx=[FILE]            Load the succinct variation graph in
                                          ODGI format from this *FILE*. The file
                                          name usually ends with *.og*. It also
                                          accepts GFAv1, but the on-the-fly
                                          conversion to the ODGI format requires
                                          additional time!
        -o[FILE], --out=[FILE]            Write the visualization in PNG format
                                          to this *FILE*.
      [ Visualization Options ]
        -x[N], --width=[N]                Set the width in pixels of the output
                                          image (default: 1500).
        -y[N], --height=[N]               Set the height in pixels of the output
                                          image (default: 500).
        -a[N], --path-height=[N]          The height in pixels for a path.
        -X[N], --path-x-padding=[N]       The padding in pixels on the x-axis
                                          for a path.
        -n, --no-path-borders             Don't show path borders.
        -b, --black-path-borders          Draw path borders in black (default is
                                          white).
        -R, --pack-paths                  Pack all paths rather than displaying
                                          a single path per row.
        -L[FLOAT],
        --link-path-pieces=[FLOAT]        Show thin links of this relative width
                                          to connect path pieces.
        -A[STRING],
        --alignment-prefix=[STRING]       Apply alignment related visual motifs
                                          to paths which have this name prefix.
                                          It affects the [**-S, --show-strand**]
                                          and [**-d, –change-darkness**]
                                          options.
        -S, --show-strand                 Use red and blue coloring to display
                                          forward and reverse alignments. This
                                          parameter can be set in combination
                                          with [**-A,
                                          –alignment-prefix**=*STRING*].
        -z,
        --color-by-mean-inversion-rate    Change the color respect to the node
                                          strandness (black for forward, red for
                                          reverse); in binned mode (**-b,
                                          --binned-mode**), change the color
                                          respect to the mean inversion rate of
                                          the path for each bin, from black (no
                                          inversions) to red (bin mean inversion
                                          rate equals to 1).
        -N, --color-by-uncalled-bases     Change the color with respect to the
                                          uncalled bases of the path for each
                                          bin, from black (no uncalled bases) to
                                          green (all uncalled bases).
        -s[CHAR],
        --color-by-prefix=[CHAR]          Color paths by their names looking at
                                          the prefix before the given character
                                          CHAR.
        -F[FILE], --path-colors=[FILE]    Read per-path RGB colors from FILE.
                                          Each non-empty, non-comment line must
                                          be: PATH<TAB>R,G,B or
                                          PATH<TAB>#RRGGBB.
        -k, --cluster-paths               Automatically order paths by
                                          similarity (bin-level Jaccard) so
                                          similar paths are adjacent.
        -J[FILE],
        --highlight-node-ids=[FILE]       Color nodes listed in FILE (one id per
                                          row) in red and all other nodes in
                                          grey.
        -M[FILE], --prefix-merges=[FILE]  Merge paths beginning with prefixes
                                          listed (one per line) in *FILE*.
        -I[PREFIX],
        --ignore-prefix=[PREFIX]          Ignore paths starting with the given
                                          *PREFIX*.
      [ Intervals Selection Options ]
        -r[STRING], --path-range=[STRING] Nucleotide range to visualize:
                                          ``STRING=[PATH:]start-end``.
                                          ``\*-end`` for ``[0,end]``;
                                          ``start-*`` for
                                          ``[start,pangenome_length]``. If no
                                          PATH is specified, the nucleotide
                                          positions refer to the pangenome’s
                                          sequence (i.e., the sequence obtained
                                          arranging all the graph’s node from
                                          left to right).
      [ Path Selection Options ]
        -p[FILE],
        --paths-to-display=[FILE]         List of paths to display in the
                                          specified order; the file must contain
                                          one path name per line and a subset of
                                          all paths can be specified.
      [ Path Names Viz Options ]
        -H, --hide-path-names             Hide the path names on the left of the
                                          generated image.
        -C, --color-path-names-background Color path names background with the
                                          same color as paths.
        -c[N],
        --max-num-of-characters=[N]       Maximum number of characters to
                                          display for each path name (max 128
                                          characters). The default value is *the
                                          length of the longest path name* (up
                                          to 128 characters).
      [ Binned Mode Options ]
        -w[bp], --bin-width=[bp]          The bin width specifies the size of
                                          each bin in the binned mode. If it is
                                          not specified, the bin width is
                                          calculated from the width in pixels of
                                          the output image.r
        -m, --color-by-mean-depth         Change the color with respect to the
                                          mean coverage of the path for each
                                          bin, using the colorbrewer palette
                                          specified in -B --colorbrewer-palette
        -B[SCHEME:N],
        --colorbrewer-palette=[SCHEME:N]  Use the colorbrewer palette specified
                                          by the given SCHEME, with the number
                                          of levels N. Specifiy 'show' to see
                                          available palettes.
        -G, --no-grey-depth               Use the colorbrewer palette for <0.5x
                                          and ~1x coverage bins. By default,
                                          these bins are light and neutral grey.
      [ Gradient Mode Options ]
        -d, --change-darkness             Change the color darkness based on
                                          nucleotide position in the path. When
                                          it is used in binned mode, the mean
                                          inversion rate of the bin node is
                                          considered to set the color gradient
                                          starting position: when this rate is
                                          greater than 0.5, the bin is
                                          considered inverted, and the color
                                          gradient starts from the right-end of
                                          the bin. This parameter can be set in
                                          combination with [**-A,
                                          –alignment-prefix**=*STRING*].
        -l, --longest-path                Use the longest path length to change
                                          the color darkness.
        -u, --white-to-black              Change the color darkness from white
                                          (for the first nucleotide position) to
                                          black (for the last nucleotide
                                          position).
      [ Compressed Mode Options ]
        -O, --compressed-mode             Compress the view vertically,
                                          summarizing the path coverage across
                                          all paths displaying the information
                                          using only one path 'COMPRESSED_MODE'.
                                          A heatmap color-coding from
                                          https://colorbrewer2.org/#type=diverging&scheme=RdBu&n=11
                                          is used. Alternatively, one can enter
                                          a colorbrewer palette via -B,
                                          --colorbrewer-palette.
      [ Threading ]
        -t[N], --threads=[N]              Number of threads to use for parallel
                                          operations.
      [ Processing Information ]
        -P, --progress                    Write the current progress to stderr.
      [ Program Information ]
        -h, --help                        Print a help message for odgi viz.
```


## Metadata
- **Skill**: generated

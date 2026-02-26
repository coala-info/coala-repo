# merquryfk CWL Generation Report

## merquryfk_CNplot

### Tool Description
Plots k-mer counts for sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/MERQURY.FK
- **Package**: https://anaconda.org/channels/bioconda/packages/merquryfk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/merquryfk/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/thegenemyers/MERQURY.FK
- **Stars**: N/A
### Original Help Text
```text
Usage: CNpLot  [-w<double(6.0)>] [-h<double(4.5)>]
               [-[xX]<number(x2.1)>] [-[yY]<number(y1.1)>]
               [-vk] [-lfs] [-pdf] [-z] [-T<int(4)>] [-P<dir($TMPDIR)>]
               <reads>[.ktab] <asm>:dna> <out>[.cni]
  or

Usage: CNpLot  [-w<double(6.0)>] [-h<double(4.5)>]
               [-[xX]<number(x2.1)>] [-[yY]<number(y1.1)>]
               [-v] [-lfs] [-pdf] [-z] <out>[.cni]

      -w: width in inches of plots
      -h: height in inches of plots
      -x: max x as a real-valued multiple of x* with max
              count 'peak' away from the origin
      -X: max x as an int value in absolute terms
      -y: max y as a real-valued multiple of max count
              'peak' away from the origin
      -Y: max y as an int value in absolute terms

      -l: draw line plot
      -f: draw fill plot
      -s: draw stack plot
          any combo allowed, none => draw all

      -z: plot counts of k-mers unique to assembly

    -pdf: output .pdf (default is .png)

      -v: verbose output to stderr
      -k: keep plotting data as <out>.cni for a later go
      -T: number of threads to use
      -P: Place all temporary files in directory -P.
```


## merquryfk_HAPmaker

### Tool Description
HAPmaker

### Metadata
- **Docker Image**: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/MERQURY.FK
- **Package**: https://anaconda.org/channels/bioconda/packages/merquryfk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HAPmaker  [-v] [-T<int(4)>] <mat>[.ktab] <pat>[.ktab] <child>[.ktab]

      -v: verbose output to stderr
      -T: number of threads to use
```


## merquryfk_HAPplot

### Tool Description
Plots HAP data

### Metadata
- **Docker Image**: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/MERQURY.FK
- **Package**: https://anaconda.org/channels/bioconda/packages/merquryfk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HAPplot  [-vk] [-w<double(6.0)>] [-h<double(4.5)>] [-pdf] [-T<int(4)>] [-P<dir($TMPDIR)>]
                <mat>[.hap[.ktab]] <pat>[.hap[.ktab]] <asm1:dna> [<asm2:dna>] <out>[.hpi]
  or

Usage: HAPplot  [-v] [-w<double(6.0)>] [-h<double(4.5)>] [-pdf] <out>[.hpi]

      -w: width in inches of plots
      -h: height in inches of plots

    -pdf: output .pdf (default is .png)

      -v: verbose output to stderr
      -k: keep plotting data as <out>.hpi for a later go
      -T: number of threads to use
      -P: Place all temporary files in directory -P.
```


## merquryfk_ASMplot

### Tool Description
Plots assembly statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/MERQURY.FK
- **Package**: https://anaconda.org/channels/bioconda/packages/merquryfk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ASMpLot  [-w<double(6.0)>] [-h<double(4.5)>]
                [-[xX]<number(x2.1)>] [-[yY]<number(y1.1)>]
                [-vk] [-lfs] [-pdf] [-z] [-T<int(4)>] [-P<dir($TMPDIR)>]
                <reads>[.ktab] <asm1:dna> [<asm2:dna>] <out>[.asmi]
  or

Usage: ASMpLot  [-w<double(6.0)>] [-h<double(4.5)>]
                [-[xX]<number(x2.1)>] [-[yY]<number(y1.1)>]
                [-v] [-lfs] [-pdf] [-z] <out>[.asmi]

      -w: width in inches of plots
      -h: height in inches of plots
      -x: max x as a real-valued multiple of x* with max
              count 'peak' away from the origin
      -X: max x as an int value in absolute terms
      -y: max y as a real-valued multiple of max count
              'peak' away from the origin
      -Y: max y as an int value in absolute terms

      -l: draw line plot
      -f: draw fill plot
      -s: draw stack plot
          any combo allowed, none => draw all

    -pdf: output .pdf (default is .png)

      -z: plot counts of k-mers unique to one or both assemblies

      -v: verbose output to stderr
      -k: keep plotting data as <out>.asmi for a later go
      -T: number of threads to use
      -P: Place all temporary files in directory -P.
```


## merquryfk_KatComp

### Tool Description
Compare k-mer counts between two sources and generate plots.

### Metadata
- **Docker Image**: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/MERQURY.FK
- **Package**: https://anaconda.org/channels/bioconda/packages/merquryfk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: KatComp  [-w<double(6.0)>] [-h<double(4.5)>]
                [-[xX]<number(x2.1)>] [-[yY]<number(y2.1)>]
                [-lfs] [-pdf] [-T<int(4)>]
                <source1>[.ktab] <source2>[.ktab] <out>

      -w: width in inches of plots
      -h: height in inches of plots
      -x: max x as a real-valued multiple of x* with max
              count 'peak' away from the origin
      -X: max x as an int value in absolute terms
      -y: max y as a real-valued multiple of y* with max
              count 'peak' away from the origin
      -Y: max y as an int value in absolute terms

      -l: draw line plot
      -f: draw fill plot
      -s: draw stack plot
          any combo allowed, none => draw all

    -pdf: output .pdf (default is .png)

      -T: number of threads to use
```


## merquryfk_KatGC

### Tool Description
Plots KatGC results

### Metadata
- **Docker Image**: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/MERQURY.FK
- **Package**: https://anaconda.org/channels/bioconda/packages/merquryfk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: KatGC  [-w<double(6.0)>] [-h<double(4.5)>]
              [-[xX]<number(x2.1)>] [-lfs] [-pdf] [-T<int(4)>]
              <source>[.ktab] <out>

      -w: width in inches of plots
      -h: height in inches of plots
      -x: max x as a real-valued multiple of x* with max
              count 'peak' away from the origin
      -X: max x as an int value in absolute terms

      -l: draw a contour map
      -f: draw a heat map
      -s: draw a heat map with contour overlay
          any combo allowed, none => draw all

    -pdf: output .pdf (default is .png)

      -T: number of threads to use
```


Chimeric reads

Chimeric reads, also called split reads, are sequence reads that are split into two or more portions, where each
portion aligns to a different region of the genome. The sequence for each split read will be annotated as "clipped"
relative to the original read sequence. In the BAM format one of alignments will be designated "primary",
the remaining are designated "supplementary". Both primary and supplementary alignments will optional contain
an "SA" tag describing their relationship to the original read sequence. The features described on this page
rely on this tag and are not available if the tag is absent.

*Screenshot illustrating chimeric reads with alignments to multiple chromosomes. Display conventions are described
in detail below.*

![Screenshot 2023-10-23 at 1 19 46 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/4cec267e-7bc6-42c3-be13-f08071eea5cf)

## Connection indicator[#](#connection-indicator "Direct link to this section")

### Clipping indicator[#](#clipping-indicator "Direct link to this section")

* Standard clipping indicator when no SA tag is present:
  ![Screenshot 2023-10-23 at 1 27 11 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/01cc7bb4-96e0-46ff-9cd1-163d7395c8f3)
* Clipped with SA Tag: ![Screenshot 2023-10-23 at 1 27 02 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/fed0e096-dbf6-4f06-abc4-67d8057889ca)
  / ![Screenshot 2023-10-23 at 1 27 21 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/64cf383f-64c0-4bf0-8b2f-9ea7162dc742)
  / ![Screenshot 2023-10-23 at 2 03 46 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/42e0d94b-a702-4fbe-a42b-3f1af2219cc2)

### Between chromosome connections[#](#between-chromosome-connections "Direct link to this section")

* New optional labels to show which chromosome a read connects to when there are chimeric reads that span different
  chromosomes.
* These are colored according to the same coloring scheme that remote mates are colored.
* These can be enabled / disabled in the preferences menu
  ( `View -> Preferences -> Alignments -> Chr` )

### Within chromosome connections[#](#within-chromosome-connections "Direct link to this section")

* Colors indicate orientation with respect to the current read
* Pale pink means consistent orientation:
  ![Screenshot 2023-10-23 at 1 27 02 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/fed0e096-dbf6-4f06-abc4-67d8057889ca)
* Red means the supplementary read is **inverted** compared to this one:
  ![Screenshot 2023-10-23 at 1 27 21 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/64cf383f-64c0-4bf0-8b2f-9ea7162dc742)

## Supplementary alignment diagram[#](#supplementary-alignment-diagram "Direct link to this section")

New display to make viewing and navigating complex alignments easier.

* Understanding how the reads are connected is hard from just text
  ![Screenshot 2023-10-23 at 1 40 10 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/dee15a20-c615-48e0-9f08-e1e0dd5634d4)

Easier to see visually:

![Screenshot 2023-10-23 at 1 40 38 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/b06db468-5823-46ea-a2e4-6cedba71d9d8)

Access the new supplementary reads diagram by right-clicking on a read and selecting *Supplementary Reads Diagram* from the menu.

### Features[#](#features "Direct link to this section")

Shows the same reads in two different views simultaneously to help understand how the read is connected and aligned.

1. **Alignment Order**: Shows the linked reads laid out according to how they were aligned. Its scaled so each
   chromosome is given
   equal space but within a chromome reads are size proportionally to how much space on the reference they align to.
2. **Read Order**: The same reads laid out according to how they were read from the original molecule.
   The reads in this view are scaled proportionally to the number of bases in the read.
3. **Highlighted read**: Mousing over a read will highlight the same read in both views and display, arcs indicate the
   connection
   to the next/previous read according to the read order. The arrow indicate forward/reverse strand.
4. **Selected Read Coordinates**: shows the aligned coordinates of the highlighted read.

   ![edit](https://github.com/igvteam/igv-docs-website/assets/4700332/e0520141-08f2-413e-942f-f55d522aa934)

### Navigation[#](#navigation "Direct link to this section")

You can use it to jump around to the relevant reads.

* `click` on a read to jump to that read in the main view
* `shift+clck` to add a new split pane with that read

### Overlapping reads are displayed in the alignment view[#](#overlapping-reads-are-displayed-in-the-alignment-view "Direct link to this section")

Reads which overlap are shown in the relevant proportion and position to one another.
![Screenshot 2023-10-21 at 10 18 00 PM](https://github.com/igvteam/igv-docs-website/assets/4700332/6c87b9b4-1594-442d-9d3a-84e66fcfeb0f)

## Other features[#](#other-features "Direct link to this section")

### Group by: chimeric[#](#group-by-chimeric "Direct link to this section")

To group all the reads with SA tags, right-click in the alignment track and select *Group by > chimeric*.

### Sort by: clip length[#](#sort-by-clip-length "Direct link to this section")

To sort the reads by clip length, right-click in the alignment track and select *Sort by > left clip* or *Sort by > right clip*

### New navigation features[#](#new-navigation-features "Direct link to this section")

* **Show supplemental reads in split screen**: Split the view to show all the associated supplemental reads in a split screen view
  (`Right click -> View chimeric reads in split screen`)
  ![Screenshot 2023-10-23 at 2 15 30 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/3fd8c32d-e12e-45fe-b8a4-5b645aaa4e36)
* **Sort the selected reads to the top when jumping**: When using jump to mate or navigating to a specific supplemental read, the selected
  reads will be sorted to the top in all panes so it's easier to identify hem.

### Improved display in tooltips for long reads / SA tags[#](#improved-display-in-tooltips-for-long-reads-sa-tags "Direct link to this section")

* Tooltip CIGARs are now shown with elipses if they are extremely long
  ![Screenshot 2023-10-23 at 2 09 58 AM](https://github.com/igvteam/igv-docs-website/assets/4700332/cf17fc32-7764-463e-b3a8-2412181aed8c)
* SA tags display now shows all the reads uniformly and highlights the selected one
  ![](https://github.com/igvteam/igv-docs-website/assets/4700332/129f6339-9ad3-4eb3-b699-f04afe4ece5d)
xml version="1.0" encoding="UTF-8"?

mothur
The website that supports the mothur software program - one of the most widely used tools for analyzing 16S rRNA gene sequence data. Step inside to learn how to use the software, get help, and join our community!
https://mothur.org/
Mon, 14 Jul 2025 20:36:10 +0000
Mon, 14 Jul 2025 20:36:10 +0000
Jekyll v3.10.0

README for the SILVA v138.2 reference files
<p>The good people at <a href="http://arb-silva.de">SILVA</a> have released a new version of the SILVA v138 (and v138.1) database. <a href="https://www.arb-silva.de/documentation/release-1382/">My understanding</a> is that this update removed 13 sequences from v138. The biggest change was a number of modifications to the taxonomy including applying 6 taxonomic levels and using “Incertae Sedis” instead of “unclassified”. A little bit of tweaking is needed to get their files to be compatible with mothur. This README document describes the process that I used to generate the <a href="http://www.mothur.org/wiki/Silva\_reference\_files">mothur-compatible reference files</a>.</p>
<h2 id="curation-of-references">Curation of references</h2>
<h3 id="getting-the-data-in-and-out-of-the-arb-database">Getting the data in and out of the ARB database</h3>
<p>This README file explains how we generated the silva reference files for use with mothur’s <code class="language-plaintext highlighter-rouge">classify.seqs</code> and <code class="language-plaintext highlighter-rouge">align.seqs</code> commands. I’ll assume that you have a functioning copy of arb installed on your computer. For this README we are using version 6.0. First we need to download the database and decompress it. From the command line we do the following:</p>
<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>wget -N https://www.arb-silva.de/fileadmin/silva\_databases/release\_138\_2/ARB\_files/SILVA\_138.2\_SSURef\_NR99\_03\_07\_24\_opt.arb.gz
gunzip SILVA\_138.2\_SSURef\_NR99\_03\_07\_24\_opt.arb.gz
arb SILVA\_138.2\_SSURef\_NR99\_03\_07\_24\_opt.arb
</code></pre></div></div>
<p>This will launch us into the arb environment with the ‘‘Ref NR 99’’ database opened. This database has 510,495 sequences within it that are not more than 99% similar to each other. The release notes for <a href="http://www.arb-silva.de/documentation/release-1382/">this database</a> as well as the idea behind the <a href="http://www.arb-silva.de/projects/ssu-ref-nr/">non-redundant database</a> are available from the silva website. Within arb do the following:</p>
<ol>
<li>Click the search button</li>
<li>Set the first search field to ‘ARB\_color’ and set it to 1. Click on the equal sign until it indicates not equal (this removes low quality reads and chimeras)</li>
<li>Click ‘Search’. This yielded 446,875 hits</li>
<li>Click the “Mark Listed Unmark Rest” button</li>
<li>Close the “Search and Query” box</li>
<li>Now click on File-&gt;export-&gt;export to external format</li>
<li>In this box the <code class="language-plaintext highlighter-rouge">Export</code> option should be set to <code class="language-plaintext highlighter-rouge">marked</code>, <code class="language-plaintext highlighter-rouge">Filter</code> to <code class="language-plaintext highlighter-rouge">none</code>, and <code class="language-plaintext highlighter-rouge">Compression</code> should be set to <code class="language-plaintext highlighter-rouge">no</code>.</li>
<li>In the field for <code class="language-plaintext highlighter-rouge">Choose an output file name make sure the path has you in the correct working directory and enter </code>silva.full\_v138\_2.fasta`.</li>
<li>
<p>Select a format: fasta\_mothur.eft. This is a custom formatting file that I have created that includes the sequences accession number and it’s taxonomy across the top line. To create one for you will need to create <code class="language-plaintext highlighter-rouge">fasta\_mothur.eft</code> in the <code class="language-plaintext highlighter-rouge">$ARBHOME/lib/export/</code> folder with the following:</p>
<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>SUFFIX fasta
BEGIN
<span class="o">&gt;</span><span class="k">\*</span><span class="o">(</span>acc<span class="o">)</span>.<span class="k">\*</span><span class="o">(</span>name<span class="o">)</span><span class="se">\t</span><span class="k">\*</span><span class="o">(</span>align\_ident\_slv<span class="o">)</span><span class="se">\t</span><span class="k">\*</span><span class="o">(</span>tax\_slv<span class="o">)</span><span class="p">;</span>
<span class="k">\*</span><span class="o">(</span>|export\_sequence<span class="o">)</span>
</code></pre></div> </div>
</li>
<li>Save this as silva.full\_v138\_2.fasta</li>
<li>You can now quit arb.</li>
</ol>
<h3 id="screening-the-sequences">Screening the sequences</h3>
<p>Now we need to screen the sequences for those that span the 27f and 1492r primer region, have 5 or fewer ambiguous base calls, and that are unique. We’ll also extract the taxonomic information from the header line. Run the following commands from a bash terminal:</p>
<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>#Convert from RNA to DNA sequences...
sed '/^[^&gt;]/s/[Uu]/T/g' silva.full\_v138\_2.fasta &gt; silva.full\_v138\_2\_dna.fasta
mothur "#screen.seqs(fasta=silva.full\_v138\_2\_dna.fasta, start=1044, end=43116, maxambig=5);
pcr.seqs(start=1044, end=43116, keepdots=T);
degap.seqs();
unique.seqs();"
#identify the unique sequences without regard to their alignment
grep "&gt;" silva.full\_v138\_2\_dna.good.pcr.ng.unique.fasta | cut -f 1 | cut -c 2- &gt; silva.full\_v138\_2\_dna.good.pcr.ng.unique.accnos
#get the unique sequences without regard to their alignment
mothur "#get.seqs(fasta=silva.full\_v138\_2\_dna.good.pcr.fasta, accnos=silva.full\_v138\_2\_dna.good.pcr.ng.unique.accnos)"
#generate alignment file
mv silva.full\_v138\_2\_dna.good.pcr.pick.fasta silva.nr\_v138\_2.align
#generate taxonomy file
grep '&gt;' silva.nr\_v138\_2.align | cut -f1,3 | cut -f2 -d'&gt;' &gt; silva.nr\_v138.full
</code></pre></div></div>
<p>The mothur commands above do several things. First the <code class="language-plaintext highlighter-rouge">screen.seqs</code> command removes sequences that are not full length and have more than 5 ambiguous base calls. Note: this will remove a number of Archaea since the ARB RN reference database lets in shorter (&gt;900 bp) archaeal 16S rRNA gene sequences. Second, <code class="language-plaintext highlighter-rouge">pcr.seqs</code> converts any base calls that occur before position 1044 and after 43116 to <code class="language-plaintext highlighter-rouge">.</code> to make them only span the region between the 27f and 1492r priming sites. Finally, it is possible that weird things happen in the alignments and so we unalign the sequences (<code class="language-plaintext highlighter-rouge">degap.seqs</code>) and identify the unique sequences (<code class="language-plaintext highlighter-rouge">unique.seqs</code>). We then convert the resulting fasta file into an accnos file so that we can go back into mothur and pull out the unique sequences from the aligned file (<code class="language-plaintext highlighter-rouge">get.seqs</code>).</p>
<h3 id="formatting-the-taxonomy-files">Formatting the taxonomy files</h3>
<p>Now we want to make sure the taxonomy file is properly formatted for use with mothur. First we want to grab the SILVA taxa mapping file by running the following in <code class="language-plaintext highlighter-rouge">bash</code>:</p>
<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>wget https://www.arb-silva.de/fileadmin/silva\_databases/release\_138\_2/Exports/taxonomy/tax\_slv\_ssu\_138.2.txt.gz
<span class="nb">gunzip </span>tax\_slv\_ssu\_138.2.txt.gz
</code></pre></div></div>
<p>We’ll run the following code from within R to clean up the taxa names and make sure everything has six levels:</p>
<div class="language-R highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">tidyverse</span><span class="p">)</span><span class="w">
</span><span class="n">desired\_levels</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">"domain"</span><span class="p">,</span><span class="w"> </span><span class="s2">"phylum"</span><span class="p">,</span><span class="w"> </span><span class="s2">"class"</span><span class="p">,</span><span class="w"> </span><span class="s2">"order"</span><span class="p">,</span><span class="w"> </span><span class="s2">"family"</span><span class="p">,</span><span class="w"> </span><span class="s2">"genus"</span><span class="p">)</span><span class="w">
</span><span class="n">desired\_levels\_tbl</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tibble</span><span class="p">(</span><span class="w">
</span><span class="n">tax\_level</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">factor</span><span class="p">(</span><span class="n">desired\_levels</span><span class="p">,</span><span class="w"> </span><span class="n">desired\_levels</span><span class="p">))</span><span class="w">
</span><span class="c1"># this is their reference taxonomy with levels for each substring found</span><span class="w">
</span><span class="c1"># in the database</span><span class="w">
</span><span class="n">tax\_label\_level</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read\_tsv</span><span class="p">(</span><span class="s2">"tax\_slv\_ssu\_138.2.txt"</span><span class="p">,</span><span class="w"> </span><span class="n">col\_names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w">
</span><span class="n">col\_type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">cols</span><span class="p">(</span><span class="n">.default</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">col\_character</span><span class="p">()))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w">
</span><span class="n">select</span><span class="p">(</span><span class="n">tax\_label</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">X1</span><span class="p">,</span><span class="w"> </span><span class="n">tax\_level</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">X3</span><span class="p">)</span><span class="w">
</span><span class="c1"># this is the the full taxonoy for each sequence in the database</span><span class="w">
</span><span class="n">database\_tax\_label</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read\_tsv</span><span class="p">(</span><span class="s2">"silva.nr\_v138.full"</span><span class="p">,</span><span class="w">
</span><span class="n">col\_names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">"id"</span><span class="p">,</span><span class="w"> </span><span class="s2">"tax\_label"</span><span class="p">),</span><span class="w">
</span><span class="n">col\_type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">cols</span><span class="p">(</span><span class="n">.default</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">col\_character</span><span class="p">()))</span><span class="w">
</span><span class="c1"># these are the unique tax\_label values found in database\_tax\_label</span><span class="w">
</span><span class="n">unique\_tax\_labels</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">database\_tax\_label</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w">
</span><span class="n">select</span><span class="p">(</span><span class="n">tax\_label</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w">
</span><span class="n">distinct</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w">
</span><span class="n">left\_join</span><span class="p">(</span><span class="n">tax\_label\_level</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">"tax\_label"</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w">
</span><span class="n">select</span><span class="p">(</span><span class="n">tax\_label</span><span class="p">)</span><span class="w">
</span><span class="c1"># now need to get each of the substrings found in unique\_tax\_labels and return</span><span class="w">
</span><span class="c1"># the tax\_level for each substring taxonomy</span><span class="w">
</span><span class="n">generate\_substrings</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">s</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w">
</span><span class="n">words</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">str\_replace</span><span class="p">(</span><span class="n">s</span><span class="p">,</span><span class="w"> </span><span class="s2">";$"</span><span class="p">,</span><span class="w"> </span><span class="s2">""</span><span class="p">)</span><span class="w"> </span><span class="o">|&gt;</span><span class="w">
</span><span class="n">str\_split</span><span class="p">(</span><span class="s2">";"</span><span class="p">)</span><span class="w"> </span><span class="o">|&gt;</span><span class="w">
</span><span class="n">unlist</span><span class="p">()</span><span class="w">
</span><span class="n">substrings</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">character</span><span class="p">(</span><span class="nf">length</span><span class="p">(</span><span class="n">words</span><span class="p">))</span><span class="w">
</span><span class="k">for</span><span class="p">(</span><span class="n">w</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="nf">seq\_along</span><span class="p">(</span><span class="n">words</span><span class="p">)){</span><span class="w">
</span><span class="n">substrings</span><span class="p">[</span><s
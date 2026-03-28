xml version="1.0" encoding="utf-8"?

Salmon: Fast, accurate and bias-aware transcript quantification from RNA-seq data
Jekyll

2023-05-25T14:36:25+00:00
/salmon/

Rob Patro
/salmon/
you@email.com

Hello World

/salmon/blog/hello-world
2014-08-08T19:39:55+00:00
2014-08-08T19:39:55+00:00

Rob Patro
/salmon
you@email.com

<p>You’ll find this post in your <code class="language-plaintext highlighter-rouge">\_posts</code> directory - edit this post and re-build (or run with the <code class="language-plaintext highlighter-rouge">-w</code> switch) to see your changes!
To add new posts, simply add a file in the <code class="language-plaintext highlighter-rouge">\_posts</code> directory that follows the convention: YYYY-MM-DD-name-of-post.ext.</p>
<h2 id="sample-heading">Sample Heading</h2>
<h3 id="sample-heading-2">Sample Heading 2</h3>
<p>Jekyll also offers powerful support for code snippets:</p>
<figure class="highlight"><pre><code class="language-ruby" data-lang="ruby"><span class="k">def</span> <span class="nf">print\_hi</span><span class="p">(</span><span class="nb">name</span><span class="p">)</span>
<span class="nb">puts</span> <span class="s2">"Hi, </span><span class="si">#{</span><span class="nb">name</span><span class="si">}</span><span class="s2">"</span>
<span class="k">end</span>
<span class="n">print\_hi</span><span class="p">(</span><span class="s1">'Tom'</span><span class="p">)</span>
<span class="c1">#=&gt; prints 'Hi, Tom' to STDOUT.</span></code></pre></figure>
<p>Check out the <a href="http://jekyllrb.com">Jekyll docs</a> for more info on how to get the most out of Jekyll. File all bugs/feature requests at <a href="https://github.com/jekyll/jekyll">Jekyll’s GitHub repo</a>.</p>
<p><a href="/salmon/blog/hello-world/">Hello World</a> was originally published by Rob Patro at <a href="/salmon">Salmon: Fast, accurate and bias-aware transcript quantification from RNA-seq data</a> on August 08, 2014.</p>

Override Author Byline Test Post

/salmon/articles/author-override
2014-06-19T00:00:00+00:00
2014-06-19T00:00:00+00:00

Billy Rick
/salmon
billy@rick.com

<p>For those of you who may have content written by multiple authors on your site you can now assign different authors to each post if desired.</p>
<p>Previously the theme used a global author for the entire site and those attributes would be used in all bylines, social networking links, Twitter Card attribution, and Google Authorship. These <code class="language-plaintext highlighter-rouge">owner</code> variables were defined in <code class="language-plaintext highlighter-rouge">config.yml</code></p>
<p>Start by modifying or creating a new <code class="language-plaintext highlighter-rouge">authors.yml</code> file in the <code class="language-plaintext highlighter-rouge">\_data</code> folder and add your authors using the following format.</p>
<figure class="highlight"><pre><code class="language-yaml" data-lang="yaml"><span class="c1"># Authors</span>
<span class="na">billy\_rick</span><span class="pi">:</span>
<span class="na">name</span><span class="pi">:</span> <span class="s">Billy Rick</span>
<span class="na">web</span><span class="pi">:</span> <span class="s">http://thewhip.com</span>
<span class="na">email</span><span class="pi">:</span> <span class="s">billy@rick.com</span>
<span class="na">bio</span><span class="pi">:</span> <span class="s2">"</span><span class="s">What</span><span class="nv"> </span><span class="s">do</span><span class="nv"> </span><span class="s">you</span><span class="nv"> </span><span class="s">want,</span><span class="nv"> </span><span class="s">jewels?</span><span class="nv"> </span><span class="s">I</span><span class="nv"> </span><span class="s">am</span><span class="nv"> </span><span class="s">a</span><span class="nv"> </span><span class="s">very</span><span class="nv"> </span><span class="s">extravagant</span><span class="nv"> </span><span class="s">man."</span>
<span class="na">avatar</span><span class="pi">:</span> <span class="s">bio-photo-2.jpg</span>
<span class="na">twitter</span><span class="pi">:</span> <span class="s">extravagantman</span>
<span class="na">google</span><span class="pi">:</span>
<span class="na">plus</span><span class="pi">:</span> <span class="s">BillyRick</span>
<span class="na">cornelius\_fiddlebone</span><span class="pi">:</span>
<span class="na">name</span><span class="pi">:</span> <span class="s">Cornelius Fiddlebone</span>
<span class="na">email</span><span class="pi">:</span> <span class="s">cornelius@thewhip.com</span>
<span class="na">bio</span><span class="pi">:</span> <span class="s2">"</span><span class="s">I</span><span class="nv"> </span><span class="s">ordered</span><span class="nv"> </span><span class="s">what?"</span>
<span class="na">avatar</span><span class="pi">:</span> <span class="s">bio-photo.jpg</span>
<span class="na">twitter</span><span class="pi">:</span> <span class="s">rhymeswithsackit</span>
<span class="na">google</span><span class="pi">:</span>
<span class="na">plus</span><span class="pi">:</span> <span class="s">CorneliusFiddlebone</span></code></pre></figure>
<p>To assign Billy Rick as an author for our post. You’d add the following YAML front matter to a post:</p>
<figure class="highlight"><pre><code class="language-yaml" data-lang="yaml"><span class="na">author</span><span class="pi">:</span> <span class="s">billy\_rick</span></code></pre></figure>
<p><a href="/salmon/articles/author-override/">Override Author Byline Test Post</a> was originally published by Rob Patro at <a href="/salmon">Salmon: Fast, accurate and bias-aware transcript quantification from RNA-seq data</a> on June 19, 2014.</p>

Syntax Highlighting Post

/salmon/articles/code-highlighting-post
2013-08-16T00:00:00+00:00
2013-08-16T00:00:00+00:00

Rob Patro
/salmon
you@email.com

<p>Syntax highlighting is a feature that displays source code, in different colors and fonts according to the category of terms. This feature facilitates writing in a structured language such as a programming language or a markup language as both structures and syntax errors are visually distinct. Highlighting does not affect the meaning of the text itself; it is intended only for human readers.<sup id="fnref:1" role="doc-noteref"><a href="#fn:1" class="footnote" rel="footnote">1</a></sup></p>
<h3 id="pygments-or-rouge-code-blocks">Pygments or Rouge Code Blocks</h3>
<p>To modify styling and highlight colors edit <code class="language-plaintext highlighter-rouge">/\_sass/\_syntax.scss</code>.</p>
<figure class="highlight"><pre><code class="language-css" data-lang="css"><span class="nf">#container</span> <span class="p">{</span>
<span class="nl">float</span><span class="p">:</span> <span class="nb">left</span><span class="p">;</span>
<span class="nl">margin</span><span class="p">:</span> <span class="m">0</span> <span class="m">-240px</span> <span class="m">0</span> <span class="m">0</span><span class="p">;</span>
<span class="nl">width</span><span class="p">:</span> <span class="m">100%</span><span class="p">;</span>
<span class="p">}</span></code></pre></figure>
<figure class="highlight"><pre><code class="language-html" data-lang="html"><span class="nt">&lt;nav</span> <span class="na">class=</span><span class="s">"pagination"</span> <span class="na">role=</span><span class="s">"navigation"</span><span class="nt">&gt;</span>
{% if page.previous %}
<span class="nt">&lt;a</span> <span class="na">href=</span><span class="s">"{{ site.url }}{{ page.previous.url }}"</span> <span class="na">class=</span><span class="s">"btn"</span> <span class="na">title=</span><span class="s">"{{ page.previous.title }}"</span><span class="nt">&gt;</span>Previous article<span class="nt">&lt;/a&gt;</span>
{% endif %}
{% if page.next %}
<span class="nt">&lt;a</span> <span class="na">href=</span><span class="s">"{{ site.url }}{{ page.next.url }}"</span> <span class="na">class=</span><span class="s">"btn"</span> <span class="na">title=</span><span class="s">"{{ page.next.title }}"</span><span class="nt">&gt;</span>Next article<span class="nt">&lt;/a&gt;</span>
{% endif %}
<span class="nt">&lt;/nav&gt;</span><span class="c">&lt;!-- /.pagination --&gt;</span></code></pre></figure>
<figure class="highlight"><pre><code class="language-ruby" data-lang="ruby"><span class="k">module</span> <span class="nn">Jekyll</span>
<span class="k">class</span> <span class="nc">TagIndex</span> <span class="o">&lt;</span> <span class="no">Page</span>
<span class="k">def</span> <span class="nf">initialize</span><span class="p">(</span><span class="n">site</span><span class="p">,</span> <span class="n">base</span><span class="p">,</span> <span class="n">dir</span><span class="p">,</span> <span class="n">tag</span><span class="p">)</span>
<span class="vi">@site</span> <span class="o">=</span> <span class="n">site</span>
<span class="vi">@base</span> <span class="o">=</span> <span class="n">base</span>
<span class="vi">@dir</span> <span class="o">=</span> <span class="n">dir</span>
<span class="vi">@name</span> <span class="o">=</span> <span class="s1">'index.html'</span>
<span class="nb">self</span><span class="p">.</span><span class="nf">process</span><span class="p">(</span><span class="vi">@name</span><span class="p">)</span>
<span class="nb">self</span><span class="p">.</span><span class="nf">read\_yaml</span><span class="p">(</span><span class="no">File</span><span class="p">.</span><span class="nf">join</span><span class="p">(</span><span class="n">base</span><span class="p">,</span> <span class="s1">'\_layouts'</span><span class="p">),</span> <span class="s1">'tag\_index.html'</span><span class="p">)</span>
<span class="nb">self</span><span class="p">.</span><span class="nf">data</span><span class="p">[</span><span class="s1">'tag'</span><span class="p">]</span> <span class="o">=</span> <span class="n">tag</span>
<span class="n">tag\_title\_prefix</span> <span class="o">=</span> <span class="n">site</span><span class="p">.</span><span class="nf">config</span><span class="p">[</span><span class="s1">'tag\_title\_prefix'</span><span class="p">]</span> <span class="o">||</span> <span class="s1">'Tagged: '</span>
<span class="n">tag\_title\_suffix</span> <span class="o">=</span> <span class="n">site</span><span class="p">.</span><span class="nf">config</span><span class="p">[</span><span class="s1">'tag\_title\_suffix'</span><span class="p">]</span> <span class="o">||</span> <span class="s1">'&amp;#8211;'</span>
<span class="nb">self</span><span class="p">.</span><span class="nf">data</span><span class="p">[</span><span class="s1">'title'</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"</span><span class="si">#{</span><span class="n">tag\_title\_prefix</span><span class="si">}#{</span><span class="n">tag</span><span class="si">}</span><span class="s2">"</span>
<span class="nb">self</span><span class="p">.</span><span class="nf">data</span><span class="p">[</span><span class="s1">'description'</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"An archive of posts tagged </span><span class="si">#{</span><span class="n">tag</span><span class="si">}</span><span class="s2">."</span>
<span class="k">end</span>
<span class="k">end</span>
<span class="k">end</span></code></pre></figure>
<h3 id="standard-code-block">Standard Code Block</h3>
<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>&lt;nav class="pagination" role="navigation"&gt;
{% if page.previous %}
&lt;a href="{{ site.url }}{{ page.previous.url }}" class="btn" title="{{ page.previous.title }}"&gt;Previous article&lt;/a&gt;
{% endif %}
{% if page.next %}
&lt;a href="{{ site.url }}{{ page.next.url }}" class="btn" title="{{ page.next.title }}"&gt;Next article&lt;/a&gt;
{% endif %}
&lt;/nav&gt;&lt;!-- /.pagination --&gt;
</code></pre></div></div>
<h3 id="fenced-code-blocks">Fenced Code Blocks</h3>
<p>To modify styling and highlight colors edit <code class="language-plaintext highlighter-rouge">/\_sass/\_coderay.scss</code>. Line numbers and a few other things can be modified in <code class="language-plaintext highlighter-rouge">\_config.yml</code>. Consult <a href="http://jekyllrb.com/docs/configuration/">Jekyll’s documentation</a> for more information.</p>
<div class="language-css highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nf">#container</span> <span class="p">{</span>
<span class="nl">float</span><span class="p">:</span> <span class="nb">left</span><span class="p">;</span>
<span class="nl">margin</span><span class="p">:</span> <span class="m">0</span> <span class="m">-240px</span> <span class="m">0</span> <span class="m">0</span><span class="p">;</span>
<span class="nl">width</span><span class="p">:</span> <span class="m">100%</span><span class="p">;</span>
<span class="p">}</span>
</code></pre></div></div>
<div class="language-html highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nt">&lt;nav</span> <span class="na">class=</span><span class="s">"pagination"</span> <span class="na">role=</span><span class="s">"navigation"</span><span class="nt">&gt;</span>
{% if page.previous %}
<span class="nt">&lt;a</span> <span class="na">href=</span><span class="s">"{{ site.url }}{{ page.previous.url }}"</span> <span class="na">class=</span><span class="s">"btn"</span> <span class="na">title=</span><span class="s">"{{ page.previous.title }}"</span><span class="nt">&gt;</span>Previous article<span class="nt">&lt;/a&gt;</span>
{% endif %}
{% if page.next %}
<span class="nt">&lt;a</span> <span class="na">href=</span><span class="s">"{{ site.url }}{{ page.next.url }}"</span> <span class="na">class=</span><span class="s">"btn"</span> <span class="na">title=</span><span class="s">"{{ page.next.title }}"</span><span class="nt">&gt;</span>Next article<span class="nt">&lt;/a&gt;</span>
{% endif %}
<span class="nt">&lt;/nav&gt;</span><span class="c">&lt;!-- /.pagination --&gt;</span>
</code></pre></div></div>
<div class="language-ruby highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="k">module</span> <span class="nn">Jekyll</span>
<span class="k">class</span> <span class="nc">TagIndex</span> <span class="o">&lt;</span> <span class="no">Page</span>
<span class="k">def</span> <span class="nf">initialize</span><span class="p">(</span><span class="n">site</span><span class="p">,</span> <span class="n">base</span><span class="p">,</span> <span class="n">dir</span><span class="p">,</span> <span class="n">tag</span><span class="p">)</span>
<span class="vi">@site</span> <span class="o">=</span> <span class="n">site</span>
<span class="vi">@base</span> <span class="o">=</span> <span class="n">base</span>
<span class="vi">@dir</span> <span class="o">=</span> <span class="n">dir</span>
<span class="vi">@name</span> <span class="o">=</span> <span class="s1">'index.html'</span>
<span class="nb">self</span><span class="p">.</span><span class="nf">
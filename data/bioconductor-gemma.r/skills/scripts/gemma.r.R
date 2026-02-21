# Code example from 'gemma.r' vignette. See references/ for full tutorial.






<html>
<head>

    <title>
        
    Bioconductor 

    </title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    
    
    <link rel="icon" href="/static/favicon.ico" type="image/x-icon"/>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    
    
    

    
    
        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-55275703-1"></script>
        <script>
            window.dataLayer = window.dataLayer || [];

            function gtag() {
                dataLayer.push(arguments);
            }

            gtag('js', new Date());

            gtag('config', "UA-55275703-1");
        </script>

    

    
    <link rel="stylesheet" href="/static/CACHE/css/output.b3e21268cb4d.css" type="text/css">

    
    <script src="/static/CACHE/js/output.10280c94381d.js"></script>

    
    

    
    
    

    
    
    

</head>


<body itemscope itemtype="https://schema.org/QAPage">

<div class="ui inverted container main">

    

    <span class="menus">
        
        




<div class="ui top attached text menu" id="menu-topics">
    <div class="ui inverted dimmer"></div>
    
    


    <div class="right menu" id="login-opts">

        
            <a class="item " href="/accounts/login/">
                <i class="sign-in icon"></i>Log In</a>

            <a class="item " href="/accounts/signup/">
                <i class="user icon"></i> Sign Up</a>
        

        <a class="item " href="/info/about/"> <i
                class="info icon"></i>about</a>
        <a class="item  " href="/info/faq/"> <i
                class="question icon"></i> faq
        </a>
    </div>
</div>

        



<div class="ui labeled icon attached pointing menu" id="menu-header">
    
        <div class="header item" id="logo">
            <a href="https://support.bioconductor.org/"><img class="ui image"  src="/static/transparent-logo.png"></a>
        </div>
    

    <a class="item  format add-question" href="/new/post/">
        <span class="">Ask a question</span>
    </a>

    <a class="item  format " href="/">
    <span class="">Latest</span>
    </a>
    <a class=" item  format" href="/t/news/">
    <span class="">News</span>
    </a>
    <a class=" item  format " href="/t/jobs/">
    <span class="">Jobs</span>
    </a>

    <a class=" item  format " href="/t/tutorials/">
    <span class="">Tutorials</span>
    </a>

    <a class=" item   format " href="/t/">
        <span class="">Tags</span>
    </a>

    <a class=" item  format " href="/user/list/">
        <span class="">Users</span>
    </a>

</div>


    </span>

    <span class="phone-menus">
        



    <div class="header item" id="logo">
        <a href="/"><img class="ui image" width="220px" src="/static/transparent-logo.png"></a>
    </div>


<div class="ui labeled icon attached fluid pointing menu" id="menu-header" style="background-color: white">

    <div class="ui left simple dropdown item">

        <i class="bars icon"><i class="dropdown icon"></i></i>
        <div class="menu">
            <a class="item " href="/new/post/">
                <i class=" edit icon"></i>New Post
            </a>

            <a class="item  " href="/">
                <i class=" list icon"></i> Latest
            </a>
            <a class="item   " href="/t/news/">
                <i class=" newspaper icon"></i> News
            </a>
            <a class="item  " href="/t/jobs/">
                <i class=" briefcase icon"></i> Jobs
            </a>

            <a class="item  " href="/t/tutorials/">
                <i class=" info circle icon"></i> Tutorials
            </a>

            <a class="item  " href="/t/">
                <i class="tag icon"></i>Tags
            </a>
            <a class="item " href="/user/list/">
                <i class=" world icon"></i>
                Users
            </a>
        </div>

    </div>


    <div class="ui right simple dropdown  item">
        

    </div>

    <div class="ui right simple dropdown item">

        <i class="user icon"><i class="dropdown icon"></i></i>
        <div class="menu" id="login-opts">
            
                <a class="item " href="/accounts/login/"><i class="sign-in icon"></i>
                    Log In</a>
                <a class="item " href="/accounts/signup/"><i
                        class="arrow circle up icon"></i>
                    Sign Up</a>
            

            <a class="item " href="/info/about/"><i class="info circle icon"></i>About
            </a>
        </div>


    </div>
</div>

    </span>

    
        
        <div class="ui bottom attached segment block">

            

    <div class="ui stackable grid">

        <div class="fit twelve wide content column">
            

    
    <div class="ui horizontal basic top-menu segments">
        

    <div class="ui horizontal basic top-menu segments">

        <div style="padding-right: 19px;">
            <div class="ui small compact menu sorting no-box-shadow">
                <div class="ui simple dropdown item">
                    Limit
                    <i class="dropdown icon"></i>

                    <div class="menu">

                        <a class="item" href="/tag/gemma.r/?limit=all">
                            <i class="check icon"></i>all time
                        </a>
                        <a class="item" href="/tag/gemma.r/?limit=today">
                            <i class=""></i>today
                        </a>
                        <a class="item" href="/tag/gemma.r/?limit=week">
                            <i class=""></i>this week
                        </a>
                        <a class="item" href="/tag/gemma.r/?limit=month">
                            <i class=""></i>this month
                        </a>
                        <a class="item" href="/tag/gemma.r/?limit=year">
                            <i class=""></i>this year
                        </a>
                        <div class="ui divider"></div>
                        <a class="item" href="/t/open/">
                            <i class=""></i>Unanswered
                        </a>

                        <a class="item" href="/">
                            <i class=""></i>All posts
                        </a>
                        


                    </div>
                </div>
            </div>
        </div>

        <div style="padding-right: 19px;">
            <div class="ui small compact menu sorting no-box-shadow">
                <div class="ui simple dropdown item">
                    Sort
                    <i class="dropdown icon"></i>

                    <div class="menu">

                        <a class="item" href="/tag/gemma.r/?order=update">
                            <i class=""></i>Update
                        </a>
                        <a class="item" href="/tag/gemma.r/?order=answers">
                            <i class=""></i>Answers
                        </a>
                         <a class="item" href="/tag/gemma.r/?order=bookmarks">
                            <i class=""></i>Bookmarks
                        </a>
                          <a class="item" href="/tag/gemma.r/?order=creation">
                            <i class=""></i>Creation
                        </a>
                        <a class="item" href="/tag/gemma.r/?order=replies">
                            <i class=""></i>Replies
                        </a>
                        <a class="item" href="/tag/gemma.r/?order=rank">
                            <i class="check icon"></i>Rank
                        </a>
                        <a class="item" href="/tag/gemma.r/?order=views">
                            <i class=""></i>Views
                        </a>

                        <a class="item" href="/tag/gemma.r/?order=votes">
                            <i class=""></i>Votes
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>


        <div class="ui basic segment search-bar" id="search-anchor">

    <div class="center-text ">

        <form class="ui form" method="GET" action="/post/search/" style="margin: 0">

            <div class="ui  search">
                <div class="ui icon input">
                    <input value="" class="search-input" type="text" name="query" placeholder="Search ... ">
                    <i class="search icon"></i>
                </div>
            </div>

        </form>

    </div>

</div>


    </div>



    
    

    <div class="ui divided items">
        
            <div class="ui warn message">No posts found. </div>
        
    </div>


    <div class="ui page-bar segment">
        







    <span class="phone">0
    results
    &bull;

        Page </span> 1 of 1







    </div>


        </div>

        <div class="four wide column sidefeed">

            <div class="ui large wrap-text" id="sidebar">
                

    

    
        


<b>Recent ... </b>

<div class="ui large wrap-text">
    <div class="event">
        <div class="ui container">
                <span>Replies </span>
                <div class="ui relaxed list" >

                    

                        <div class="item spaced">
                            <a href="/p/9163210/"> Comment: soGGi error</a>
                            by
                            <a href="/u/85874/">a2a2asawhaa
                            </a>

                        <span>  


    
        &bull;
    

    0

</span>

                        <div class="muted" style="">
                            When software updates lead to unexpected visual outputs in tools like ggplot2, finding a stable and reliable alternative for your digital t…
                            </div>
                        </div>

                    

                        <div class="item spaced">
                            <a href="/p/9163209/"> Comment: Inconsistencies between accessor functions for TxDb databases with selected seql</a>
                            by
                            <a href="/u/85874/">a2a2asawhaa
                            </a>

                        <span>  


    
        &bull;
    

    0

</span>

                        <div class="muted" style="">
                            While technical inconsistencies in Bioconductor resources can be frustrating for researchers, the world of mobile entertainment offers high…
                            </div>
                        </div>

                    

                        <div class="item spaced">
                            <a href="/p/9163208/"> Comment: The BioC2026 Sticker Design Contest is Open!</a>
                            by
                            <a href="/u/85874/">a2a2asawhaa
                            </a>

                        <span>  


    
        &bull;
    

    0

</span>

                        <div class="muted" style="">
                            Just as the BioC2026 contest celebrates creativity and community contributions, choosing a [ZH88 Game Download APK][1] allows you to engage…
                            </div>
                        </div>

                    

                        <div class="item spaced">
                            <a href="/p/9163207/"> Comment: Region specific age contrasts in DEXSeq</a>
                            by
                            <a href="/u/85874/">a2a2asawhaa
                            </a>

                        <span>  


    
        &bull;
    

    0

</span>

                        <div class="muted" style="">
                            When analyzing complex biological data like transcript usage, ensuring you have the right tools is as essential as finding the DK11 Game do…
                            </div>
                        </div>

                    

                        <div class="item spaced">
                            <a href="/p/9163205/"> Answer: Unable to create venndiagram using VennDiagram 1.5.1 package</a>
                            by
                            <a href="/u/85882/">kesha
                            </a>

                        <span>  


    
        &bull;
    

    0

</span>

                        <div class="muted" style="">
                            &lt;a href=https://vavadacasinox.com/&gt;vavadacasinox.com&lt;/a&gt;
                            </div>
                        </div>

                    

                </div>
        </div>
    </div>
<div class="ui divider"></div>
    <div class="event">
        <div class="ui container">
                <div>Votes </div>
                <div class="ui relaxed list" >
                    
                       <div class="item spaced" >
                            <a href="/p/85786/">A: Reference paper or resource for limma::diffSplice and edgeR::diffSpliceDGE metho</a>
                       </div>
                    
                       <div class="item spaced" >
                            <a href="/p/9163188/">Answer: Which preprocessing steps are needed before running limpa?</a>
                       </div>
                    
                       <div class="item spaced" >
                            <a href="/p/9163189/">Answer: Should I use beta1 from limpa::dpc() or limpa::dpcCN(), if they differ?</a>
                       </div>
                    
                       <div class="item spaced" >
                            <a href="/p/9163188/">Answer: Which preprocessing steps are needed before running limpa?</a>
                       </div>
                    
                       <div class="item spaced" >
                            <a href="/p/9163188/">Answer: Which preprocessing steps are needed before running limpa?</a>
                       </div>
                    
                </div>
        </div>
    </div>

<div class="ui divider"></div>

    <div class="event">
        <div class="ui container">
            <span>Awards</span>
            <a href="/b/list/"> &bull;  All <i class="ui angle small double right icon"></i></a>

                <div class="ui relaxed list" >
                   

                        <div class="item"  style="">
                            <span>
                                <a href="/b/view/popular-question/">Popular Question <i class="eye icon"></i></a> to
                                <a href="/u/13992/">
                                    hauken_heyken</a>
                                <span>  


    
        &utrif;
    

    80

</span>
                            </span>
                        </div>

                    

                        <div class="item"  style="">
                            <span>
                                <a href="/b/view/scholar/">Scholar <i class="check circle outline icon"></i></a> to
                                <a href="/u/179/">
                                    Gordon Smyth</a>
                                <span>  


    
        <i class="ui muted bolt icon"></i>
    

    53k

</span>
                            </span>
                        </div>

                    

                        <div class="item"  style="">
                            <span>
                                <a href="/b/view/popular-question/">Popular Question <i class="eye icon"></i></a> to
                                <a href="/u/5570/">
                                    Peter Hickey</a>
                                <span>  


    
        &utrif;
    

    760

</span>
                            </span>
                        </div>

                    

                        <div class="item"  style="">
                            <span>
                                <a href="/b/view/popular-question/">Popular Question <i class="eye icon"></i></a> to
                                <a href="/u/490/">
                                    Sean Davis</a>
                                <span>  


    
        <i class="ui muted bolt icon"></i>
    

    21k

</span>
                            </span>
                        </div>

                    

                        <div class="item"  style="">
                            <span>
                                <a href="/b/view/popular-question/">Popular Question <i class="eye icon"></i></a> to
                                <a href="/u/5106/">
                                    James W. MacDonald</a>
                                <span>  


    
        <i class="ui muted bolt icon"></i>
    

    68k

</span>
                            </span>
                        </div>

                    
                </div>

        </div>
    </div>

<div class="ui divider"></div>
    <div class="event">
        <div class="ui container">
                <span>Locations</span>
                 <a href="/user/list/">&bull;  All <i class="ui angle small double right icon"></i></a>

                 <div class="ui relaxed list" >

                    
                        <div class="item spaced" >
                        <span>
                        <a class="ui mini avatar thread-users  list-avatar image" href="/u/85892/">
                            <img src="https://secure.gravatar.com/avatar/095148a8fcb6dee39063fa26c9d9f994?s=90&amp;d=mp">
                        </a>
                        </span>

                            United States, <span class="muted">1 hour ago</span>
                        </div>

                    
                        <div class="item spaced" >
                        <span>
                        <a class="ui mini avatar thread-users  list-avatar image" href="/u/6732/">
                            <img src="https://secure.gravatar.com/avatar/b1d9b3de6fc5202485c7a398f15ab399?s=90&amp;d=retro">
                        </a>
                        </span>

                            The city by the bay, <span class="muted">1 hour ago</span>
                        </div>

                    
                        <div class="item spaced" >
                        <span>
                        <a class="ui mini avatar thread-users  list-avatar image" href="/u/61416/">
                            <img src="https://secure.gravatar.com/avatar/4a1970d8920a3c951303aba2e67c889e?s=90&amp;d=mp">
                        </a>
                        </span>

                            Australia, <span class="muted">2 hours ago</span>
                        </div>

                    
                        <div class="item spaced" >
                        <span>
                        <a class="ui mini avatar thread-users  list-avatar image" href="/u/59885/">
                            <img src="https://secure.gravatar.com/avatar/83cb93b23c3c868293d287e5a477e28d?s=90&amp;d=mp">
                        </a>
                        </span>

                            Australia, <span class="muted">2 hours ago</span>
                        </div>

                    
                        <div class="item spaced" >
                        <span>
                        <a class="ui mini avatar thread-users  list-avatar image" href="/u/21670/">
                            <img src="https://secure.gravatar.com/avatar/f3eb4c03a9fee2ffc8ebcde9126e6e32?s=90&amp;d=identicon">
                        </a>
                        </span>

                            Melbourne, Australia, <span class="muted">3 hours ago</span>
                        </div>

                    
                </div>
        </div>
    </div>



</div>

    


            </div>
        </div>

    </div>

    
    <div id="traffic">Traffic: 1318 users visited in the last hour</div>




        </div>
    

    
        


<div class="ui three  center aligned column stackable tiny grid">
    <div class=" left aligned column" style="padding-right: 13%">

        <b>Content</b>
        <a href="/#search-anchor">Search</a><br>
        <a href="/user/list/">Users</a><br>
        <a href="/t/">Tags</a><br>
        <a href="/b/list/">Badges</a>

    </div>
    <div class="left aligned column" style="padding-right: 12%">
        <b>Help</b>
        <a href="/info/about/">About</a><br>
        <a href="/info/faq/">FAQ</a><br>

    </div>
    <div class=" left aligned column">

        <b>Access</b>
        <a href="/info/rss/">RSS</a><br>
        <a href="/info/api/">API</a><br>
        <a href="#">Stats</a>

    </div>
</div>
<div class="ui divider"></div>

<div class="ui vertical center aligned basic segment">
    <p>Use of this site constitutes acceptance of our <a href="/info/policy/">User Agreement and Privacy
        Policy</a>.</p>
    <div class="smaller muted">
        Powered by the <a href="https://github.com/ialbert/biostar-central" class="ui image">
        <img src="/static/images/badge-forum.svg"></a> version 2.3.6
    </div>

</div>
    

    

</div>


</body>


</html>

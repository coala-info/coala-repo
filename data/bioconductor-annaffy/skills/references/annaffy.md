Textual Description of annaffy

Colin A. Smith

October 29, 2025

Introduction

annaffy is part of the Bioconductor project. It is designed to help interface between
Affymetrix analysis results and web-based databases. It provides classes and functions
for accessing those resources both interactively and through statically generated HTML
pages.

The core functionality of annaffy depends on annotation contained in Bioconductor
data packages. The data packages are created by the SQLForge code inside of another
package called AnnotationDbi. It gathers annotation data from many diverse sources
and makes the information easily processed by R. Preconstructed packages for most
Affymetrix chips are available on the Bioconductor web site.

1 Loading Annotation Data

annaffy represents each type of annotation data as a different class. Currently imple-
mented classes include:

aafSymbol gene symbol

aafDescription gene description/name

aafFunction gene functional description

aafChromosome genomic chromosome

aafChromLoc location on the chromosome (in base pairs)

aafGenBank GenBank accession number

aafLocusLink LocusLink ids (almost never more than one)

aafCytoband mapped cytoband location

1

aafUniGene UniGene cluster ids (almost never more than one)

aafPubMed PubMed ids

aafGO Gene Ontology identifiers, names, types, and evidence codes

aafPathway KEGG pathway identifiers and names

For each class, there is a constructor function with the same name.

It takes as
arguments a vector of Affymetrix probe ids as well as the chip name. The chip name
corresponds to the name of the data package that contains the annotation. If the data
package for the chip is not already loaded, the constructor will attempt to load it. The
constructor returns a list of the corresponding objects populated with annotation data.
(NA values in the annotation package are mapped to empty objects.)

> library("annaffy")

(For the purpose of demonstration, we will use the hgu95av2.db metadata package

and probe ids from the aafExpr dataset.)

> data(aafExpr)
> probeids <- featureNames(aafExpr)
> symbols <- aafSymbol(probeids, "hgu95av2.db")
> symbols[[54]]

[1] "ARVCF"
attr(,"class")
[1] "aafSymbol"

> symbols[55:57]

An object of class "aafList"
[[1]]
[1] "MRPS14"
attr(,"class")
[1] "aafSymbol"

[[2]]
[1] "TDRD3"
attr(,"class")
[1] "aafSymbol"

[[3]]
character(0)
attr(,"class")
[1] "aafSymbol"

2

All annotation constructors return their results as aafList objects, which act like
normal lists but have special behavior when used with certain methods. One such
method is getText(), which returns a simple textual representation of most annaffy
objects. Note the differing ways annaffy handles missing annotation data.

> getText(symbols[54:57])

[1] "ARVCF"

"MRPS14" "TDRD3"

""

Other annotation constructors return more complex data structures:

> gos <- aafGO(probeids, "hgu95av2.db")
> gos[[3]]

An object of class "aafGO"
[[1]]
An object of class "aafGOItem"
@id
@name "signaling receptor binding"
@type "Molecular Function"
@evid "IEA"

"GO:0005102"

"GO:0005163"

[[2]]
An object of class "aafGOItem"
@id
@name "nerve growth factor receptor binding"
@type "Molecular Function"
@evid "IBA"

[[3]]
An object of class "aafGOItem"
@id
"GO:0005515"
@name "protein binding"
@type "Molecular Function"
@evid "IPI"

"GO:0005576"

[[4]]
An object of class "aafGOItem"
@id
@name "extracellular region"
@type "Cellular Component"
@evid "IEA"

3

"GO:0005576"

[[5]]
An object of class "aafGOItem"
@id
@name "extracellular region"
@type "Cellular Component"
@evid "TAS"

"GO:0005615"

[[6]]
An object of class "aafGOItem"
@id
@name "extracellular space"
@type "Cellular Component"
@evid "IBA"

"GO:0005737"

[[7]]
An object of class "aafGOItem"
@id
@name "cytoplasm"
@type "Cellular Component"
@evid "ISS"

"GO:0005788"

[[8]]
An object of class "aafGOItem"
@id
@name "endoplasmic reticulum lumen"
@type "Cellular Component"
@evid "TAS"

"GO:0007169"

[[9]]
An object of class "aafGOItem"
@id
@name "cell surface receptor protein tyrosine kinase signaling pathway"
@type "Biological Process"
@evid "IBA"

"GO:0007399"

[[10]]
An object of class "aafGOItem"
@id
@name "nervous system development"
@type "Biological Process"
@evid "TAS"

4

"GO:0007411"

[[11]]
An object of class "aafGOItem"
@id
@name "axon guidance"
@type "Biological Process"
@evid "TAS"

[[12]]
An object of class "aafGOItem"
"GO:0007416"
@id
@name "synapse assembly"
@type "Biological Process"
@evid "IDA"

[[13]]
An object of class "aafGOItem"
"GO:0008021"
@id
@name "synaptic vesicle"
@type "Cellular Component"
@evid "IBA"

"GO:0008083"

[[14]]
An object of class "aafGOItem"
@id
@name "growth factor activity"
@type "Molecular Function"
@evid "IBA"

"GO:0008083"

[[15]]
An object of class "aafGOItem"
@id
@name "growth factor activity"
@type "Molecular Function"
@evid "IEA"

"GO:0008083"

[[16]]
An object of class "aafGOItem"
@id
@name "growth factor activity"
@type "Molecular Function"
@evid "TAS"

5

"GO:0010832"

[[17]]
An object of class "aafGOItem"
@id
@name "negative regulation of myotube differentiation"
@type "Biological Process"
@evid "ISS"

"GO:0010976"

[[18]]
An object of class "aafGOItem"
@id
@name "positive regulation of neuron projection development"
@type "Biological Process"
@evid "ISS"

[[19]]
An object of class "aafGOItem"
"GO:0021675"
@id
@name "nerve development"
@type "Biological Process"
@evid "IBA"

"GO:0030424"

[[20]]
An object of class "aafGOItem"
@id
@name "axon"
@type "Cellular Component"
@evid "IBA"

"GO:0030425"

[[21]]
An object of class "aafGOItem"
@id
@name "dendrite"
@type "Cellular Component"
@evid "IBA"

"GO:0031547"

[[22]]
An object of class "aafGOItem"
@id
@name "brain-derived neurotrophic factor receptor signaling pathway"
@type "Biological Process"
@evid "TAS"

6

"GO:0031550"

[[23]]
An object of class "aafGOItem"
@id
@name "positive regulation of brain-derived neurotrophic factor receptor signaling pathway"
@type "Biological Process"
@evid "TAS"

"GO:0038180"

[[24]]
An object of class "aafGOItem"
@id
@name "nerve growth factor signaling pathway"
@type "Biological Process"
@evid "IBA"

"GO:0043524"

[[25]]
An object of class "aafGOItem"
@id
@name "negative regulation of neuron apoptotic process"
@type "Biological Process"
@evid "IBA"

"GO:0048471"

[[26]]
An object of class "aafGOItem"
@id
@name "perinuclear region of cytoplasm"
@type "Cellular Component"
@evid "ISS"

"GO:0048668"

[[27]]
An object of class "aafGOItem"
@id
@name "collateral sprouting"
@type "Biological Process"
@evid "IDA"

"GO:0048672"

[[28]]
An object of class "aafGOItem"
@id
@name "positive regulation of collateral sprouting"
@type "Biological Process"
@evid "IDA"

7

"GO:0048812"

[[29]]
An object of class "aafGOItem"
@id
@name "neuron projection morphogenesis"
@type "Biological Process"
@evid "IBA"

"GO:0050804"

[[30]]
An object of class "aafGOItem"
@id
@name "modulation of chemical synaptic transmission"
@type "Biological Process"
@evid "IBA"

"GO:0051965"

[[31]]
An object of class "aafGOItem"
@id
@name "positive regulation of synapse assembly"
@type "Biological Process"
@evid "IDA"

"GO:2000008"

[[32]]
An object of class "aafGOItem"
@id
@name "regulation of protein localization to cell surface"
@type "Biological Process"
@evid "TAS"

"GO:2001234"

[[33]]
An object of class "aafGOItem"
@id
@name "negative regulation of apoptotic signaling pathway"
@type "Biological Process"
@evid "ISS"

The gene ontology constructor, aafGO(), returns aafLists of aafGO objects, which
are in turn lists of aafGOItem objects. Within each of those objects, there are four slots:
id, name, type, and evidence code. The individual slots can be accessed with the @
operator.

> gos[[3]][[1]]@name

[1] "signaling receptor binding"

8

If the reader is not already aware, R includes two subsetting operators, which can
be the source of some confusion at first. Single brackets ([]) always return an object
of the same type that they are used to subset. For example, using single brackets to
subset an aafList will return another aafList, even if it only contains one item. On
the other hand, double brackets ([[]]) return just a single item which is not enclosed
in a list. Thus the above statement first picks out the third aafGO object, then the first
aafGOItem, and finally the name slot.

2 Linking to Online Databases

One of the most important features of the annaffy package its ability to link to various
public online databases. Most of the annotation classes in annaffy have a getURL()
method which returns single or multiple URLs, depending on the object type.

The simplest annotation class which produces a URL is aafGenBank. Because
Affymetrix chips are generally based off GenBank, all probes have a corresponding
GenBank accession number, even those missing other annotation data. The GenBank
database provides information about the expressed sequence that the Affymetrix chip
detects. Additionally, it helps break down the functional parts of the sequence and pro-
vides information about the authors that initially sequenced the gene fragment. (See
this URL here.)

> gbs <- aafGenBank(probeids, "hgu95av2.db")
> getURL(gbs[[1]])

[1] "http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=search&db=nucleotide&term=U41068%5BACCN%5D&doptcmdl=GenBank"

In most distributions of R, you can open URLs in your browser with the browseURL()
function. Many other types of URLs are also possible. Entrez Gene (formerly LocusLink)
is a very useful online database that links to many other data sources not referenced
by Bioconductor. One worthy of note is OMIM, which provides relatively concise gene
function and mutant phenotype information. (See this URL here.)

> lls <- aafLocusLink(probeids, "hgu95av2.db")
> getURL(lls[[2]])

[1] "http://www.ncbi.nlm.nih.gov/sites/entrez?Db=gene&Cmd=DetailsSearch&Term=2322"

If you are interested in exploring the area of the genome surrounding a probe, the
aafCytoband provides a link to NCBI’s online genome viewer. It includes adjacent genes
and other genomic annotations. (See this URL here.)

> bands <- aafCytoband(probeids, "hgu95av2.db")
> getURL(bands[[2]])

9

[1] "http://www.ncbi.nlm.nih.gov/mapview/map_search.cgi?direct=on&idtype=gene&id=2322"

For primary literature information about a gene, use the aafPubMed class. It will
provide a link to a list of abstracts on PubMed which describe the gene of interest. The
list abstracts that Bioconductor provides are by no means complete and will sometimes
only include the paper in which the gene was cloned. (See this URL here.)

> pmids <- aafPubMed(probeids, "hgu95av2.db")
> getURL(pmids[[2]])

[1] "http://www.ncbi.nih.gov/entrez/query.fcgi?tool=bioconductor&cmd=Retrieve&db=PubMed&list_uids=2004790%2c7507245%2c7692230%2c7789184%2c8394751%2c8946930%2c9614102%2c9651358%2c9918857%2c10022833%2c10080542%2c10409713%2c10482988%2c10698507%2c11027663%2c11091200%2c11133746%2c11290608%2c11442493%2c11535508%2c11971190%2c11983110%2c12036858%2c12060771%2c12070009%2c12239146%2c12239147%2c12384447%2c12393674%2c12468433%2c12468438%2c12477932%2c12481903%2c12676789%2c12681969%2c12691136%2c12816873%2c12842996%2c12854887%2c12926083%2c12935959%2c12951584%2c12969963%2c14504097%2c14562119%2c14604974%2c14630076%2c14654525%2c14670924%2c14737077%2c14759363%2c14977832%2c14981546%2c14982881%2c15044257%2c15054042%2c15059064%2c15061200%2c15166029%2c15167911%2c15178581%2c15242879%2c15253381%2c15289019%2c15345593%2c15352981%2c15363457%2c15574429%2c15583855%2c15604885%2c15604894%2c15645287%2c15650056%2c15674343%2c15710585%2c15769897%2c15770067%2c15778081%2c15781338%2c15797998%2c15831474%2c15863200%2c15902284%2c15921740%2c15959528%2c15973451%2c15978940%2c15996732%2c16015387%2c16029447%2c16046528%2c16076867%2c16116483%2c16185475%2c16213360%2c16234090%2c16263569%2c16263793%2c16320249%2c16326981%2c16368883%2c16410383%2c16410449%2c16502586%2c16517725%2c16533526%2c16598313%2c16642044%2c16684964%2c16809615%2c16861351%2c16949153%2c16982329%2c16990784%2c16990788%2c17036374%2c17056111%2c17064989%2c17105820%2c17128418%2c17222369%2c17229632%2c17230226%2c17268528%2c17312001%2c17387224%2c17442779%2c17446348%2c17456725%2c17485549%2c17498302%2c17550846%2c17579862%2c17584026%2c17598835%2c17606455%2c17620055%2c17650443%2c17668209%2c17690703%2c17708786%2c17708787%2c17708788%2c17763464%2c17851551%2c17851558%2c17881645%2c17881646%2c17910045%2c17936561%2c17939400%2c17940205%2c17943971%2c17957027%2c17965322%2c17972951%2c17983653%2c18024405%2c18024407%2c18067018%2c18067020%2c18068628%2c18071308%2c18081718%2c18096476%2c18156731%2c18184863%2c18192111%2c18192505%2c18261272%2c18270328%2c18303245%2c18305215%2c18309032%2c18336585%2c18343790%2c18394702%2c18450602%2c18464120%2c18473998%2c18483393%2c18490735%2c18503825%2c18559874%2c18605083%2c18641025%2c18670883%2c18755984%2c18797870%2c18925699%2c18955790%2c18977345%2c19016763%2c19052976%2c19052993%2c19059939%2c19085113%2c19141860%2c19144660%2c19151774%2c19176010%2c19176014%2c19181379%2c19181784%2c19204327%2c19221039%2c19236740%2c19279329%2c19296110%2c19309322%2c19330068%2c19345670%2c19351817%2c19395028%2c19411632%2c19438505%2c19464057%2c19466291%2c19529981%2c19536888%2c19540337%2c19540590%2c19549778%2c19557552%2c19562748%2c19602710%2c19603346%2c19635202%2c19637342%2c19665070%2c19672946%2c19684517%2c19698218%2c19700852%2c19765320%2c19773259%2c19775300%2c19808698%2c19824900%2c19840437%2c19853583%2c19865112%2c19878996%2c19913121%2c19915372%2c19921191%2c19934300%2c19956635%2c19965647%2c19968062%2c19995225%2c20001230%2c20018615%2c20023256%2c20031210%2c20035824%2c20039765%2c20066533%2c20096459%2c20098747%2c20119833%2c20133893%2c20137111%2c20159992%2c20172040%2c20182906%2c20201926%2c20212254%2c20237506%2c20302766%2c20354824%2c20368469%2c20368538%2c20376086%2c20379614%2c20439648%2c20504356%2c20508617%2c20513120%2c20514303%2c20515557%2c20520634%2c20525753%2c20546020%2c20548095%2c20571062%2c20592250%2c20628086%2c20651067%2c20656931%2c20670134%2c20678218%2c20693296%2c20740398%2c20800603%2c20803351%2c20807885%2c20815269%2c20861915%2c20872983%2c20875128%2c20875872%2c20880116%2c20959405%2c20963938%2c20966504%2c20981678%2c21048955%2c21067377%2c21067588%2c21114537%2c21114781%2c21129033%2c21133602%2c21148331%2c21173125%2c21176335%2c21180092%2c21233836%2c21242187%2c21245599%2c21245757%2c21262971%2c21269566%2c21332708%2c21338238%2c21357706%2c21387358%2c21389326%2c21453545%2c21487043%2c21516120%2c21516736%2c21520003%2c21523727%2c21523728%2c21527514%2c21537333%2c21552520%2c21589872%2c21606167%2c21621842%2c21674859%2c21685470%2c21696826%2c21744003%2c21767516%2c21768087%2c21789382%2c21820407%2c21859732%2c21860418%2c21873635%2c21907407%2c21967978%2c22044003%2c22050655%2c22084166%2c22096027%2c22099191%2c22104247%2c22126574%2c22126602%2c22129478%2c22132874%2c22208491%2c22210879%2c22261446%2c22291086%2c22343664%2c22354205%2c22368270%2c22374696%2c22378655%2c22421058%2c22422053%2c22438257%2c22454318%2c22458420%2c22471708%2c22481022%2c22487825%2c22494415%2c22514634%2c22532519%2c22562027%2c22591177%2c22605576%2c22674490%2c22684224%2c22705992%2c22721497%2c22733614%2c22736495%2c22751451%2c22807997%2c22858906%2c22858909%2c22875611%2c22911473%2c22914610%2c22952242%2c22972921%2c22996295%2c23009217%2c23017497%2c23040356%2c23082484%2c23086275%2c23115106%2c23124877%2c23127761%2c23135354%2c23154527%2c23167317%2c23167384%2c23190472%2c23238897%2c23246379%2c23276395%2c23300935%2c23321254%2c23335073%2c23340802%2c23359050%2c23377000%2c23377436%2c23430109%2c23431389%2c23479570%2c23480665%2c23508117%2c23511494%2c23540998%2c23548639%2c23567961%2c23584564%2c23590662%2c23603912%2c23613521%2c23631653%2c23647058%2c23650535%2c23666693%2c23722894%2c23740774%2c23763915%2c23774633%2c23783394%2c23793916%2c23796006%2c23840454%2c23846442%2c23878140%2c23906301%2c23907410%2c23929599%2c23982978%2c24005813%2c24040307%2c24067137%2c24090502%2c24097631%2c24144836%2c24160850%2c24164801%2c24175822%2c24192815%2c24240202%2c24268349%2c24282218%2c24288427%2c24314260%2c24319184%2c24323990%2c24390456%2c24498869%2c24525236%2c24573385%2c24574459%2c24582753%2c24608088%2c24666762%2c24724602%2c24724782%2c24737502%2c24779074%2c24786392%2c24801015%2c24849514%2c24855211%2c24859829%2c24895100%2c24895580%2c24951466%2c24981688%2c25079101%2c25083817%2c25086665%2c25105536%2c25145343%2c25155901%2c25192740%2c25215878%2c25216797%2c25234168%2c25237195%2c25270908%2c25280219%2c25281355%2c25287662%2c25381129%2c25400766%2c25441683%2c25456130%2c25456387%2c25468431%2c25487917%2c25519476%2c25527567%2c25530565%2c25547679%2c25548440%2c25550214%2c25573287%2c25578618%2c25605217%2c25605370%2c25640477%2c25679063%2c25697362%2c25713434%2c25762638%2c25802479%2c25858894%2c25957287%2c26046670%2c26062848%2c26163606%2c26191952%2c26212328%2c26234722%2c26244574%2c26286850%2c26292723%2c26294738%2c26308771%2c26384303%2c26438511%2c26462154%2c26487272%2c26515730%2c26526573%2c26547258%2c26551637%2c26566084%2c26584077%2c26617391%2c26669855%2c26692109%2c26781613%2c26808072%2c26822154%2c26847745%2c26848862%2c26852660%2c26891877%2c26916980%2c26999641%2c27016502%2c27018948%2c27040395%2c27060207%2c27071442%2c27087256%2c27132990%2c27221943%2c27248172%2c27268085%2c27280396%2c27300438%2c27315441%2c27346558%2c27373815%2c27391351%2c27411587%2c27416910%2c27435003%2c27436336%2c27458164%2c27462455%2c27465508%2c27517160%2c27540013%2c27568101%2c27590507%2c27735988%2c27748272%2c27748370%2c27775694%2c27791036%2c27797237%2c27797250%2c27870947%2c27881871%2c27906677%2c27919943%2c27993871%2c28034991%2c28052408%2c28086240%2c28107692%2c28108507%2c28108543%2c28158719%2c28159598%2c28194038%2c28211167%2c28213513%2c28271164%2c28294102%2c28318150%2c28319113%2c28470536%2c28496177%2c28522571%2c28538663%2c28561688%2c28616699%2c28618074%2c28625976%2c28751768%2c28751773%2c28895560%2c28947392%2c28960265%2c29055209%2c29059168%2c29062038%2c29079128%2c29165010%2c29183886%2c29251252%2c29257272%2c29330746%2c29348145%2c29463564%2c29471895%2c29530994%2c29563490%2c29615816%2c29669779%2c29691342%2c29773601%2c29786546%2c29806051%2c29907544%2c29950146%2c29991678%2c30021884%2c30055376%2c30082225%2c30117185%2c30122013%2c30250637%2c30275197%2c30320942%2c30372901%2c30572745%2c30651634%2c30659317%2c30686591%2c30695511%2c30706524%2c30710101%2c30828789%2c30898150%2c30923103%2c30926392%2c30953031%2c31034878%2c31066629%2c31089248%2c31147598%2c31186273%2c31201827%2c31244296%2c31285539%2c31395602%2c31432396%2c31434952%2c31511612%2c31515354%2c31518054%2c31554356%2c31606550%2c31645666%2c31650168%2c31669649%2c31756575%2c31790499%2c31819100%2c31821677%2c31943762%2c31943770%2c31955503%2c31963113%2c31967735%2c32048621%2c32149729%2c32155324%2c32163103%2c32173273%2c32296014%2c32299905%2c32332018%2c32388535%2c32393312%2c32447933%2c32460405%2c32495317%2c32533751%2c32543003%2c32547322%2c32581359%2c32583303%2c32668024%2c32680424%2c32707033%2c32712325%2c32843624%2c32898396%2c32955823%2c33078658%2c33091616%2c33109387%2c33112537%2c33119202%2c33123895%2c33149267%2c33182501%2c33226740%2c33289421%2c33340276%2c33371116%2c33514926%2c33550446%2c33592069%2c33598693%2c33623141%2c33631087%2c33661592%2c33780043%2c33811005%2c33817952%2c33830077%2c33851200%2c33971801%2c34003103%2c34024909%2c34045454%2c34070902%2c34099621%2c34101344%2c34108128%2c34168220%2c34169421%2c34217323%2c34289175%2c34299191%2c34299222%2c34316017%2c34348451%2c34376373%2c34487021%2c34521806%2c34550682%2c34671057%2c34723452%2c34750506%2c34811450%2c34830393%2c34831215%2c34863627%2c34876631%2c34896257%2c35068331%2c35086749%2c35092883%2c35281004%2c35350997%2c35354918%2c35384245%2c35412895%2c35485701%2c35796012%2c35876828%2c35900493%2c35901509%2c35906694%2c36104354%2c36226489%2c36232688%2c36384254%2c36395068%2c36403191%2c36407352%2c36444394%2c36485136%2c36539954%2c36542496%2c36738279%2c36881031%2c37012202%2c37066885%2c37147424%2c37246158%2c37341821%2c37356962%2c37428863%2c37435718%2c37485586%2c37519024%2c37759552%2c37783807%2c37788644%2c38049555%2c38327131%2c38495876%2c38625438%2c38775115%2c38811818%2c39246183"

A number of interesting queries can be done with the gene ontology class. You can
display the gene ontology family hierarchy for an entire probe id at once, including
multiple GO ids. The usefulness of such a query may be dubious, but it is possible. See
this URL here.

> getURL(gos[[1]])

[1] "http://amigo.geneontology.org/amigo/term/GO:0001501%0aGO:0001501%0aGO:0005201%0aGO:0005515%0aGO:0005576%0aGO:0005576%0aGO:0005581%0aGO:0005585%0aGO:0005592%0aGO:0005788%0aGO:0005788%0aGO:0007605%0aGO:0007605%0aGO:0007605%0aGO:0030020%0aGO:0030020%0aGO:0030020%0aGO:0030020%0aGO:0030199%0aGO:0030199%0aGO:0030199%0aGO:0030674%0aGO:0031012%0aGO:0031012%0aGO:0046872%0aGO:0051216%0aGO:0051216%0aGO:0051216%0aGO:0060021%0aGO:0060023"

You can also show the family hierarchy for a single GO id. (See this URL here.)

> getURL(gos[[1]][[4]])

[1] "http://amigo.geneontology.org/amigo/term/GO:0005515"

The last link type of note is that for KEGG Pathway information. Most genes are
not annotated with pathway data. However, for those that are, it is possible to retrieve
schematics of the biochemical pathways a gene is involved in. (See this URL here. Look
for the enzyme in question to be highlighted in red.)

> paths <- aafPathway(probeids, "hgu95av2.db")
> getURL(paths[[4]])

[1] "http://www.genome.ad.jp/kegg/pathway/hsa/hsa04640.html"
[2] "http://www.genome.ad.jp/kegg/pathway/hsa/hsa04662.html"
[3] "http://www.genome.ad.jp/kegg/pathway/hsa/hsa05340.html"

10

3 Building HTML Pages

In addition to using annaffy interactively through R, it may also be desirable to generate
annotated reports summarizing your microarray analysis results. Such a report can
be utilized by a scientist collaborator with no knowledge of either R or Bioconductor.
Additionally, by having all the annotation and statistical data presented together on one
page, connections between and generalizations about the data can be made in a more
efficient manner.

The primary intent of the annaffy package is to produce such reports in HTML.
Additionally, it can easily format the same report as tab-delimited text for import into
a table, spreadsheet, or database. It supports nearly all the annotation data available
through Bioconductor. Additionally, it has facilities for including and colorizing user
data in an informative manner.

The rest of this tutorial will make use of an ExpressionSet generated for demonstra-
tion purposes. It contains anonymized data from a microarray experiment which used
the Affymetrix hgu95av2 chip. There are eight total samples in the set, four control
samples and four experimental samples. 250 expression measures were selected at ran-
dom from the results, and another 250 probe ids were selected at random and assigned
to those expression measures. The data therefore has no real biological significance, but
can still fully show the capabilities of annaffy.

3.1 Limiting the Results

HTML reports generated by annaffy can grow to become quite large unless some mea-
sures are taken to limit the results. Multi-megabyte web pages are unwieldy and should
thus be avoided. Doing a ranked statistical analysis is one way to limit results, and will
be shown here. We will rank the expression measures by putting their two-sample Welch
t-statistics in order of decreasing absolute value.

The first step is to load the multtest package which will be used for the t-test. (It

is also part of the Bioconductor project.)

> library(multtest)

The mt.teststat() function requires a vector that specifies which samples belong
to the different observation classes. Using a few R tricks, that vector can be produced
directly from the first covariate of pData.

> class <- as.integer(pData(aafExpr)$covar1) - 1

[1] 0 0 0 0 1 1 1 1

Using the class vector, we calculate the t-statistic for each of the probes. We then
generate an index vector which can be used to order the probes themselves in increasing
order. As a last step, we produce the vector of ranked probe ids. Latter annotation
steps will only use the first 50 of those probes.

11

> teststat <- mt.teststat(exprs(aafExpr), class)
> index <- order(abs(teststat), decreasing = TRUE)
> probeids <- featureNames(aafExpr)[index]

3.2 Annotating the Probes

Once there is a list of probes, annotation is quite simple. The only decision that needs
to be made is which classes of annotation to include in the table.
Including all the
annotation classes, which is the default, may not be a good idea. If the table grows too
wide, its usefulness may decrease. To see which columns of data can be included, use
the aaf.handler() function. When called with no arguments, it returns the annotation
types annaffy can handle.

> aaf.handler()

[1] "Probe"
[4] "Chromosome"
[7] "Gene"

[10] "Gene Ontology"

"Symbol"
"Chromosome Location" "GenBank"
"Cytoband"
"Pathway"

"PubMed"

"Description"

To help avoid typing errors, subset the vector instead of retyping each column name.

> anncols <- aaf.handler()[c(1:3,8:9,11:13)]

[1] "Probe"
[6] "Pathway"

"Symbol"
NA

"Description" "Cytoband"
NA

"PubMed"

This may be too many columns, but it is possible at a later stage to choose to
either not show some of the columns or remove them altogether. Note that by using the
widget=TRUE option in the next function, it is also possible select data columns with a
graphical widget. See Figure 1.

Now we generate the annotation table with the aafTableAnn() function. Note that
for this tutorial, annaffy is acting as its own data package. If you wish to annotate
results for other chips, download the appropriate data package from the Bioconductor
website.

> anntable <- aafTableAnn(probeids[1:50], "hgu95av2.db", anncols)

To see what has been produced so far, use the saveHTML() method to generate the
HTML report. Using the optional argument open=TRUE will open the resulting file in
your browser.

> saveHTML(anntable, "example1.html", title = "Example Table without Data")

See this page online here.

12

Figure 1: Graphical display for selecting annotation data columns.

13

3.3 Adding Other Data

To add other data to the table, just use any of the other table constructors to generate
your own table, and then merge the two. For instance, listing the t-test results along
with the annotation data is quite useful. annaffy provides the option of colorizing
signed data, making it easier to assimilate.

> testtable <- aafTable("t-statistic" = teststat[index[1:50]], signed = TRUE)
> table <- merge(anntable, testtable)

After HTML generation, a one line change to the style sheet header will change the
colors used to show the positive and negative values. In fact, with a bit of CSS it is
possible to heavily customize the appearance of the tables very quickly, even on a column
by column basis.

annaffy also provides an easy way to include expression data in the table. It colorizes
the cells with varrying intensities of green to show relative expression values. Addition-
ally, because of the way merge works, it will always match probe id rows together,
regardless of their order. This allows a quick "sanity check" on the other statistics pro-
duced, and can help decrease user error. (Check, for example, that the t-statistics and
ranking seem reasonable given the expression data.)

> exprtable <- aafTableInt(aafExpr, probeids = probeids[1:50])
> table <- merge(table, exprtable)
> saveHTML(table, "example2.html", title = "Example Table with Data")

See this page online here.
Producing a tab-delimited text version uses the saveText() method. The text ouput

also includes more digits of precision than HTML.

> saveText(table, "example2.txt")

4 Searching Metadata

Often a biologist will make hypotheses about changes in gene expression either before
or after the microarray experiment. In order to facilitate the formulation and testing
of such hypotheses, annaffy includes functions to search annotation metadata using
various criteria. All search functions return character vectors of Affymetrix probe ids
that can be used to subset data and annotation.

4.1 Text

The two currently implemented search functions are simple and easy to use. The first
is a text search that matches against the textual representation of biological metadata.

14

Recall that textual representations are extracted using the getText() method. For
complex annotation structures, the textual representation can include a variety of infor-
mation, including numeric identifiers and textual descriptions.

For the purposes of demonstration, we will use the hgu95av2.db annotation data

package available through Bioconductor.

> library(hgu95av2.db)
> probeids <- ls(hgu95av2SYMBOL)
> gos <- aafGO(probeids[1:2], "hgu95av2.db")
> getText(gos)

[1] "GO:0000045: autophagosome assembly, GO:0000165: MAPK cascade, GO:0000165: MAPK cascade, GO:0000165: MAPK cascade, GO:0000166: nucleotide binding, GO:0001784: phosphotyrosine residue binding, GO:0002841: negative regulation of T cell mediated immune response to tumor cell, GO:0004672: protein kinase activity, GO:0004674: protein serine/threonine kinase activity, GO:0004674: protein serine/threonine kinase activity, GO:0004674: protein serine/threonine kinase activity, GO:0004674: protein serine/threonine kinase activity, GO:0004707: MAP kinase activity, GO:0004707: MAP kinase activity, GO:0004707: MAP kinase activity, GO:0005515: protein binding, GO:0005524: ATP binding, GO:0005634: nucleus, GO:0005634: nucleus, GO:0005634: nucleus, GO:0005635: nuclear envelope, GO:0005654: nucleoplasm, GO:0005654: nucleoplasm, GO:0005654: nucleoplasm, GO:0005737: cytoplasm, GO:0005737: cytoplasm, GO:0005737: cytoplasm, GO:0005737: cytoplasm, GO:0005739: mitochondrion, GO:0005739: mitochondrion, GO:0005769: early endosome, GO:0005769: early endosome, GO:0005770: late endosome, GO:0005770: late endosome, GO:0005788: endoplasmic reticulum lumen, GO:0005794: Golgi apparatus, GO:0005794: Golgi apparatus, GO:0005829: cytosol, GO:0005829: cytosol, GO:0005856: cytoskeleton, GO:0005856: cytoskeleton, GO:0005886: plasma membrane, GO:0005901: caveola, GO:0005901: caveola, GO:0005901: caveola, GO:0005925: focal adhesion, GO:0005925: focal adhesion, GO:0005929: cilium, GO:0006351: DNA-templated transcription, GO:0006468: protein phosphorylation, GO:0006915: apoptotic process, GO:0006974: DNA damage response, GO:0007166: cell surface receptor signaling pathway, GO:0007173: epidermal growth factor receptor signaling pathway, GO:0007173: epidermal growth factor receptor signaling pathway, GO:0008286: insulin receptor signaling pathway, GO:0009887: animal organ morphogenesis, GO:0010468: regulation of gene expression, GO:0010507: negative regulation of autophagy, GO:0010508: positive regulation of autophagy, GO:0010759: positive regulation of macrophage chemotaxis, GO:0010759: positive regulation of macrophage chemotaxis, GO:0014032: neural crest cell development, GO:0014044: Schwann cell development, GO:0015630: microtubule cytoskeleton, GO:0016020: membrane, GO:0016301: kinase activity, GO:0016310: phosphorylation, GO:0016740: transferase activity, GO:0019233: sensory perception of pain, GO:0019902: phosphatase binding, GO:0019902: phosphatase binding, GO:0030278: regulation of ossification, GO:0030509: BMP signaling pathway, GO:0030641: regulation of cellular pH, GO:0030878: thyroid gland development, GO:0031143: pseudopodium, GO:0031281: positive regulation of cyclase activity, GO:0031663: lipopolysaccharide-mediated signaling pathway, GO:0031669: cellular response to nutrient levels, GO:0032206: positive regulation of telomere maintenance, GO:0032206: positive regulation of telomere maintenance, GO:0032435: negative regulation of proteasomal ubiquitin-dependent protein catabolic process, GO:0032496: response to lipopolysaccharide, GO:0032872: regulation of stress-activated MAPK cascade, GO:0032872: regulation of stress-activated MAPK cascade, GO:0034198: cellular response to amino acid starvation, GO:0034198: cellular response to amino acid starvation, GO:0035556: intracellular signal transduction, GO:0036064: ciliary basal body, GO:0038083: peptidyl-tyrosine autophosphorylation, GO:0038133: ERBB2-ERBB3 signaling pathway, GO:0038202: TORC1 signaling, GO:0042473: outer ear morphogenesis, GO:0042552: myelination, GO:0042593: glucose homeostasis, GO:0042770: signal transduction in response to DNA damage, GO:0042802: identical protein binding, GO:0043330: response to exogenous dsRNA, GO:0045944: positive regulation of transcription by RNA polymerase II, GO:0048009: insulin-like growth factor receptor signaling pathway, GO:0048538: thymus development, GO:0050804: modulation of chemical synaptic transmission, GO:0050821: protein stabilization, GO:0050868: negative regulation of T cell activation, GO:0051216: cartilage development, GO:0051403: stress-activated MAPK cascade, GO:0051403: stress-activated MAPK cascade, GO:0051493: regulation of cytoskeleton organization, GO:0051493: regulation of cytoskeleton organization, GO:0060020: Bergmann glial cell differentiation, GO:0060324: face development, GO:0060425: lung morphogenesis, GO:0060440: trachea formation, GO:0061308: cardiac neural crest cell development involved in heart development, GO:0061514: interleukin-34-mediated signaling pathway, GO:0070161: anchoring junction, GO:0070371: ERK1 and ERK2 cascade, GO:0070371: ERK1 and ERK2 cascade, GO:0070374: positive regulation of ERK1 and ERK2 cascade, GO:0070498: interleukin-1-mediated signaling pathway, GO:0070849: response to epidermal growth factor, GO:0070849: response to epidermal growth factor, GO:0071260: cellular response to mechanical stimulus, GO:0071356: cellular response to tumor necrosis factor, GO:0072584: caveolin-mediated endocytosis, GO:0072584: caveolin-mediated endocytosis, GO:0090170: regulation of Golgi inheritance, GO:0090170: regulation of Golgi inheritance, GO:0090370: negative regulation of cholesterol efflux, GO:0098792: xenophagy, GO:0098978: glutamatergic synapse, GO:0106310: protein serine kinase activity, GO:0120041: positive regulation of macrophage proliferation, GO:0120041: positive regulation of macrophage proliferation, GO:0140297: DNA-binding transcription factor binding, GO:0150078: positive regulation of neuroinflammatory response, GO:0150078: positive regulation of neuroinflammatory response, GO:1904262: negative regulation of TORC1 signaling, GO:1904417: positive regulation of xenophagy, GO:2000641: regulation of early endosome to late endosome transport, GO:2000641: regulation of early endosome to late endosome transport"
[2] "GO:0000166: nucleotide binding, GO:0001525: angiogenesis, GO:0001568: blood vessel development, GO:0001570: vasculogenesis, GO:0001701: in utero embryonic development, GO:0001936: regulation of endothelial cell proliferation, GO:0001936: regulation of endothelial cell proliferation, GO:0003180: aortic valve morphogenesis, GO:0003180: aortic valve morphogenesis, GO:0004672: protein kinase activity, GO:0004713: protein tyrosine kinase activity, GO:0004714: transmembrane receptor protein tyrosine kinase activity, GO:0004714: transmembrane receptor protein tyrosine kinase activity, GO:0004714: transmembrane receptor protein tyrosine kinase activity, GO:0005515: protein binding, GO:0005524: ATP binding, GO:0005886: plasma membrane, GO:0005886: plasma membrane, GO:0005886: plasma membrane, GO:0007165: signal transduction, GO:0007169: cell surface receptor protein tyrosine kinase signaling pathway, GO:0007498: mesoderm development, GO:0009888: tissue development, GO:0016020: membrane, GO:0016301: kinase activity, GO:0016525: negative regulation of angiogenesis, GO:0016740: transferase activity, GO:0030336: negative regulation of cell migration, GO:0032526: response to retinoic acid, GO:0043235: receptor complex, GO:0045026: plasma membrane fusion, GO:0045766: positive regulation of angiogenesis, GO:0048771: tissue remodeling, GO:0048771: tissue remodeling, GO:0060836: lymphatic endothelial cell differentiation, GO:0060836: lymphatic endothelial cell differentiation, GO:0060854: branching involved in lymph vessel morphogenesis, GO:0060854: branching involved in lymph vessel morphogenesis, GO:1901201: regulation of extracellular matrix assembly, GO:1901201: regulation of extracellular matrix assembly"

The textual search is probably best applied to the Symbol, Description, and Pathway
metadata types.
(A specialized Gene Ontology search will be discussed later.) For
instance, to find all the kinases on a chip, simply do a text search of Description for
kinases.

> kinases <- aafSearchText("hgu95av2.db", "Description", "kinase")
> kinases[1:5]

[1] "1000_at"

"1001_at"

"1007_s_at" "1008_f_at" "1010_at"

> print(length(kinases))

[1] 770

One can search multiple metadata types with multiple queries all with a single func-
tion call. For instance, to find all genes with "ribosome" or "polymerase" in the De-
scription or Pathway annotation, use the following function call.

> probes <- aafSearchText("hgu95av2.db", c("Description", "Pathway"),
+
> print(length(probes))

c("ribosome", "polymerase"))

[1] 83

When doing searches of multiple annotation data types or multiple terms, by default
the search returns all probe ids matching any of the search criteria. That can be altered
by changing the logical operator from OR to AND using the logic="AND" argument.
This is useful because aafSearchText() does not automatically tokenize a search query
as Google and many other search engines do. For example, "DNA polymerase" finds
all occurrences of that exact string. To find all probes whose description contains both
"DNA" and "polymerase", use the following function call.

15

> probes <- aafSearchText("hgu95av2.db", "Description",
+
> print(length(probes))

c("DNA", "polymerase"), logic = "AND")

[1] 16

Another useful application of the text search is to map a vector of GenBank accession
numbers onto a vector of probe ids. This comes in handy if you wish to filter microarray
data based on the results of a BLAST job.

> gbs <- c("AF035121", "AL021546", "AJ006123", "AL080082", "AI289489")
> aafSearchText("hgu95av2.db", "GenBank", gbs)

[1] "1954_at"
[6] "38199_at"

"32573_at"

"32955_at"

"34040_s_at" "35581_at"

Lastly, two points for power users. One, the text search is always case insensitive.
Second, individual search terms are treated as Perl compatible regular expressions. This
means that you should be cautious of special regular expression characters. See the Perl
documentation1 for further information about how to use regular expressions.

4.2 Gene Ontology

The second type of search available is a Gene Ontology search.
It takes a vector of
Gene Ontology identifiers and maps them onto a list of probe ids. Gene Ontology is a
tree and you can include or exclude descendents with the descendents argument. The
search also supports the logic argument. Because the Bioconductor metadata packages
include pre-indexed Gene Ontology mappings, this search is very fast.

The input format for Gene Ontology ids is very flexible. You may use numeric or

character vectors, either excluding or including the "GO:" prefix and leading zeros.

> aafSearchGO("hgu95av2.db", c("GO:0000002", "GO:0000008"))

character(0)

> aafSearchGO("hgu95av2.db", c("2", "8"))

character(0)

> aafSearchGO("hgu95av2.db", c(2, 8))

character(0)

A good source for finding relevant Gene Ontology identifiers is the AmiGO website2,

operated by the Gene Ontology Consortium.

1http://perldoc.perl.org/perlre.html
2http://www.godatabase.org/

16


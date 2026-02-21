Social Networks Analysis Data

Denise Scholtens

SNAData contains graphNEL objects of the social networks analysis data available in Appendix
B of Wasserman. S. and Faust. K. (1994). Social Network Analysis. New York: Cambridge University
Press. The descriptions of the data available here are based on the information in Appendix B.

> library(graph)
> library(Rgraphviz)
> library(SNAData)
>

Krackhardt’s High-tech Managers

Tables B.1 - B.3 in Wasserman and Faust contain data for three directed relations between Krackhardt’s
21 high-tech managers: advice, friendship, reports to. Table B.4 contains a table of four attributes for
the managers: age (in years), tenure (length of time employed by the company, in years), level in
corporate hierarchy (coded 1,2,3), department of the company (coded 1,2,3,4).

Relation W & F

SNAData object

Table No.

Graphs:
advice

B.1

advice

friendship B.2

friendship

reports to

B.3

reportsTo

Attributes:
attributes

B.4

krackhardtAttrs

> data(advice)
> data(friendship)
> data(reportsTo)
> data(krackhardtAttrs)
> advice

A graphNEL graph with directed edges
Number of Nodes = 21
Number of Edges = 190

1

> friendship

A graphNEL graph with directed edges
Number of Nodes = 21
Number of Edges = 102

> reportsTo

A graphNEL graph with directed edges
Number of Nodes = 21
Number of Edges = 20

> krackhardtAttrs

Age Tenure Level Dept
4
4
2
4
2
1
0
1
2
3
3
1
2
2
2
4
1
3
2
2
1

33 9.333
1
42 19.583
2
40 12.750
3
33 7.500
4
32 3.333
5
59 28.000
6
55 30.000
7
34 11.333
8
9
62 5.417
10 37 9.250
11 46 27.000
12 34 8.917
13 48 0.250
14 43 10.417
15 40 8.417
16 27 4.667
17 30 12.417
18 33 9.083
19 32 4.833
20 38 11.667
21 36 12.500

3
2
3
3
3
3
1
3
3
3
3
3
3
2
3
3
3
2
3
3
2

> plot(reportsTo)
>

2

Padgett’s Florentine Families

Tables B.5 - B.6 contain data for two undirected relations between 16 of Padgett’s Florentine families:
business, marital. Table B.7 contains a table of three attributes for the families: wealth (net wealth,
measured in 1427, in thousands of lira), number of priorates (number of seats on the Civic Council
held between 1282 and 1344), number of ties (number of business or marital ties in the total network
of 116 families).

3

123456789101112131415161718192021Relation W & F

SNAData object

Table No.

Graphs:
business

B.5

business

marital

B.6

marital

Attributes:
attributes B.7

florentineAttrs

> data(business)
> data(marital)
> data(florentineAttrs)
> business

A graphNEL graph with undirected edges
Number of Nodes = 16
Number of Edges = 15

> marital

A graphNEL graph with undirected edges
Number of Nodes = 16
Number of Edges = 20

> florentineAttrs

Acciaiuoli
Albizzi
Barbadori
Bischeri
Castellani
Ginori
Guadagni
Lamberteschi
Medici
Pazzi
Peruzzi
Pucci
Ridolfi
Salviati
Strozzi
Tornabuoni

Wealth NumberPriorates NumberTies
2
3
14
9
18
9
14
14
54
7
32
1
4
5
29
7

10
36
55
44
20
32
8
42
103
48
49
3
27
10
146
48

53
65
NA
12
22
NA
21
0
53
NA
42
0
38
35
74
NA

> adj(business,"Bischeri")

4

$Bischeri
[1] "Guadagni"

"Lamberteschi" "Peruzzi"

> adj(marital,"Bischeri")

$Bischeri
[1] "Guadagni" "Peruzzi"

"Strozzi"

>

Freeman’s EIES Network

Tables B.8 - B.10 contain data for three directed, weighted relations between 32 of Freeman’s EIES
researchers: acquaintanceship at time 1, January 1978, the start of the study; acquaintanceship at time
2, September 1978, the end of the study; the number of messages sent. The acquaintanceship relations
are valued as follows: 4=close personal friend, 3=friend, 2=person I’ve met, 1=person I’ve heard of, but
not met, 0=unknown name or no reply. Table B.11 contains a table of four attributes for the researchers:
original ID as reported in Freeman and Freeman (1979), number of citations in 1978, discipline (coded
1,2,3), discipline itself.

Relation

W & F
Table No.

SNAData object

Graphs:
acquaintanceship B.8
at time 1

acquaintanceship B.9
at time 2

acqTime1

acqTime2

messages

B.10

messages

Attributes:
attributes

B.11

freemanAttrs

> data(acqTime1)
> data(acqTime2)
> data(messages)
> data(freemanAttrs)
> acqTime1

A graphNEL graph with directed edges
Number of Nodes = 32
Number of Edges = 650

> acqTime2

5

A graphNEL graph with directed edges
Number of Nodes = 32
Number of Edges = 759

> messages

A graphNEL graph with directed edges
Number of Nodes = 32
Number of Edges = 460

> freemanAttrs[1:5,]

OriginalID Citations DisciplineCode
Discipline
1
Sociology
Anthropology
2
4 Communication
1
Sociology
Psychology
4

19
3
170
23
16

1
2
3
6
8

1
2
3
4
5

> edgeL(acqTime1,6)

$`6`
$`6`$edges
[1] 1 8 14 16 19 21 27 29 31

> edgeL(acqTime2,6)

$`6`
$`6`$edges
1 2

[1]

8 10 11 14 15 16 19 21 24 26 27 28 29 31 32

> edgeL(messages,6)

$`6`
$`6`$edges
1 2

[1]

>

4

6

8 10 11 15 16 17 24 27 28 29 30 31

Countries Trade Data

Tables B.12 - B.16 contain data for five directed trade relations between 24 countries: basic man-
ufactured goods; food and live animals; crude materials, excluding food; minerals, fuels, and other
petroleum products; exchange of diplomats. Table B.17 contains a table of four attributes for the coun-
tries: average annual population growth between 1970 and 1981; average GNP growth rate per capita
between 1970 and 1981; secondary school enrollment ratio in 1980; energy consumption per capita in
1980, in kilo coal equivalents.

6

Relation

W & F
Table No.

SNAData object

Graphs:
basic manufactured goods B.12

food and live animals

crude materials,
excluding food

B.13

B.14

basicGoods

food

crudeMaterials

minerals, fuels, and other
petroleum products

B.15

minerals

exchange of diplomats

B.16

diplomats

Attributes:
attributes

B.17

countriesAttrs

> data(basicGoods)
> data(food)
> data(crudeMaterials)
> data(minerals)
> data(diplomats)
> data(countriesAttrs)
> basicGoods

A graphNEL graph with directed edges
Number of Nodes = 24
Number of Edges = 310

> food

A graphNEL graph with directed edges
Number of Nodes = 24
Number of Edges = 307

> crudeMaterials

A graphNEL graph with directed edges
Number of Nodes = 24
Number of Edges = 307

> minerals

7

A graphNEL graph with directed edges
Number of Nodes = 24
Number of Edges = 135

> diplomats

A graphNEL graph with directed edges
Number of Nodes = 24
Number of Edges = 369

> countriesAttrs[1:5,]

PopGrowth GNP Schools Energy
814
2161
1101
618
6847

3.3 3.0
1.6 0.3
2.1 5.3
NA
1.5
NA
0.7

33
56
32
43
44

Alg
Arg
Bra
Chi
Cze

> degree(basicGoods)

$inDegree
Alg Arg Bra Chi Cze Ecu Egy Eth Fin Hon Ind Isr Jap Lib Mad
6
10

14 10 17

13

12

15

9

9

9

13 10
Tai UK
15 16

11
15
US Yug
15
19

$outDegree
Alg Arg Bra Chi Cze Ecu Egy Eth Fin Hon Ind Isr Jap Lib Mad
1

4 13 21

21

21

14

11

23

2

9

2

1

0

Tai UK
14 22

21
US Yug
18
23

> degree(diplomats)

$inDegree
Alg Arg Bra Chi Cze Ecu Egy Eth Fin Hon Ind Isr Jap Lib Mad
4

18 13 23

19

18

12

16

7

7

6

16 19
Tai UK
13 22

19
21
US Yug
19
23

$outDegree
Alg Arg Bra Chi Cze Ecu Egy Eth Fin Hon Ind Isr Jap Lib Mad
8
14

16

18

15

13

13

23

10

9

8

15 17
Tai UK
15 21

19
20
US Yug
18
23

>

8

NZ Pak Spa Swi Syr
14 17 15 12
14

NZ Pak Spa Swi Syr
0
13 22 23
11

NZ Pak Spa Swi Syr
14 20 22 12

6

NZ Pak Spa Swi Syr
15 18 17 13
11

Galaskiewicz’s CEO and Clubs Network

Table B.18 contains information about the membership of the chief executive officers from 26 corpo-
rations in 15 clubs. SNAData contains both a graph and affiliation matrix representation of these data.
The rows of the affiliation matrix represent CEOs and the columns represent clubs. The graph is a
bipartite graph which contains two sets of nodes for the CEOs and clubs, and directed edges connect
the CEOs to the clubs of which they are members.

Relation

W & F
Table No.

SNAData object

Graph:
club membership B.18

CEOclubsBPG

Affiliation Matrix:
club membership B.18

CEOclubsAM

> data(CEOclubsBPG)
> data(CEOclubsAM)
> CEOclubsBPG

A graphNEL graph with directed edges
Number of Nodes = 41
Number of Edges = 98

> CEOclubsAM[1:5,1:5]

Club1 Club2 Club3 Club4 Club5
0
1
0
0
0

1
0
0
0
0

0
0
0
0
0

1
1
1
1
1

0
0
0
1
0

CEO1
CEO2
CEO3
CEO4
CEO5

> cc5 <- c(paste("CEO",1:5,sep=""),paste("Club",1:5,sep=""))
> subG <- subGraph(cc5,CEOclubsBPG)
> edgemode(subG) <- "directed"
> plot(subG)
>

9

10

CEO1CEO2CEO3CEO4CEO5Club1Club2Club3Club4Club5
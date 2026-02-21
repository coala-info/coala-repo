TYPE SPECIFICATION FOR YOUR FUNCTIONS

Type speciﬁcation for your functions

by MT Morgan, Seth Falcon, Robert Gentleman, and
Duncan Temple Lang

become apparent below. To test our function, we use
data from the help page for lm:

You’ve written some amazing R functions. How can
others, even non-R users, beneﬁt from your hard
work? Maybe you can make it easy for other pro-
grammers to learn about the arguments and return
values of your function? Perhaps a web-based form
or dialog box, like those provided by widgetInvoke,
would help users choose appropriate arguments?
These objectives are easier to obtain when R func-
tions provide information about themselves.

The TypeInfo package annotates functions with
information about argument and return types. Type-
Info automatically checks that your function is called
with appropriate arguments. You can then focus on
writing the code in the body of your function, rather
than checking values supplied by users. Other R pro-
grammers can ask functions about their argument
and return types. This ‘reﬂection’ opens the door to
creative possibilities, for instance automatically cre-
ating a work ﬂow (perhaps a graphical ‘wizard’?)
chaining function calls together into a complicated
overall analysis.

This article illustrate how to use TypeInfo to
specify argument and return types. We start with
straight-forward ways of applying type information.
Then we illustrate the ﬂexibility of TypeInfo for ap-
ply complicated type checks, including types satis-
fying arbitrary R expressions. The article concludes
with a brief look behind the scenes to expose limita-
tions of TypeInfo, and to highlight opportunities for
using typed functions in advanced aspects of your
own work.

The basics: applying typeInfo

Suppose your colleagues clamor for a function to
perform one-way analysis of variance on data where
the predictor is a factor. Easily done in R with
lm, but the R formula notation might be more
than needed for our simple function. To help our
colleagues, we simplify the interface to refer to
response and predictor variables. Many users ex-
pect an ANOVA table as output, so we return the re-
sult of anova rather than lm. Here is our function:

> ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
> trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
> group <- gl(2,10,20, labels=c("Ctl","Trt"))
> weight <- c(ctl, trt)
> oneWayAnova( weight, group )

Analysis of Variance Table

Response: weight

Df Sum Sq Mean Sq F value Pr(>F)
1 0.6882 0.68820 1.4191 0.249

group
Residuals 18 8.7292 0.48496

Applying type checks

We want to make sure our users enter the right kinds
of arguments. To do this, we add type information to
make sure that response is numeric, and predictor
a factor. We start by loading the TypeInfo library. . .

> library(TypeInfo)

and, after deﬁning oneWayAnova, add type informa-
tion:

SimultaneousTypeSpecification(

TypedSignature(

> typeInfo(oneWayAnova) <-
+
+
+
+
+

response = "numeric",
predictor = "factor"),

returnType = "anova")

The command SimultaneousTypeSpecification
means that we want to impose a set of conditions
that apply simultaneously to all arguments (and,
optionally, the return type). TypedSignature cor-
responds to one set of conditions. The structure of
TypedSignature is a list of argument names and
their types. Specifying returnType advertises that
our function returns an object of type anova, and
checks that it really does return this type. The rea-
son for placing returnType after TypedSignature is
clariﬁed below.

Using a typed function is exactly the same as us-

ing an untyped function:

expr <- substitute( response ~ predictor )
result <- lm( as.formula( expr ))
anova( result )

> oneWayAnova <- function( response, predictor ) {
+
+
+
+ }
> copyOfOneWayAnova <- oneWayAnova

> oneWayAnova( weight, group )

Analysis of Variance Table

Response: weight

We make a copy of the function deﬁnition to conve-
niently re-apply different type information, as will

Df Sum Sq Mean Sq F value Pr(>F)
1 0.6882 0.68820 1.4191 0.249

group
Residuals 18 8.7292 0.48496

1

THE BASICS: APPLYING TYPEINFO

TYPE SPECIFICATION FOR YOUR FUNCTIONS

> typeInfo(oneWayAnova)

An object of class "SimultaneousTypeSpecification"
[[1]]
[TypedSignature]

response: is(response, c(
predictor: is(predictor, c(

’

numeric

factor

)) [InheritsTypeTest]
’

)) [InheritsTypeTest]

’

’

Slot "returnType":
An object of class "InheritsTypeTest"
[1] "anova"

> ngroup <- as.numeric( group )
> res <-
+
+
+
+
+

tryCatch(oneWayAnova( weight, ngroup ),
error=function(err) {
cat("Error:",

})

conditionMessage(err), "\n")

Error: TypeInfo could not match signature.
Supplied arguments and their types:

response: numeric
predictor: numeric
Available signature(s):

[SimultaneousTypeSpecification]

[TypedSignature]

response: is(response, c(
predictor: is(predictor, c(
returnType: is(returnType, c(

’
’

)) [InheritsTypeTest]
’

)) [InheritsTypeTest]

)) [InheritsTypeTest]

factor
’
anova

’

numeric

’

Figure 1: Finding out about type information, and the informative consequences of supplying incorrect argu-
ments.

2

FLEXIBLE TYPEINFO

TYPE SPECIFICATION FOR YOUR FUNCTIONS

Finding out about type information

Once applied,
typeInfo.

functions can be queried with

> typeInfo(oneWayAnova)

The output, in Figure 1, illustrates how type in-
formation is stored. typeInfo returns an object of
class SimultaneousTypeSpecification. The object
contains a list of objects of class TypedSignature,
and a returnType slot. Each TypedSignature is a list
with entries for each element with type speciﬁcation.
The information returned from typeInfo pro-
vides useful information as-is. It can also be parsed
by computer code to provide information useful in
creation of graphical widgets or other interfaces.

Incorrect arguments

When the user supplies incorrect data, e.g., repre-
senting the predictor as numeric rather than factor

> ngroup <- as.numeric( group )
> res <- try( oneWayAnova( weight, ngroup ))

TypeInfo intervenes with the error show in Figure 1.
Providing TypeInfo is helpful, as our user might
otherwise have performed a linear regression rather
than ﬁxed-effects ANOVA.

Elaborating on type signatures

for our purposes,

We might decide that,
the
predictor can be either factor or numeric.
We change the SimultaneousTypeSpecification
to include another TypedSignature (re-applying
typeInfo does not automatically overwrite previous
type speciﬁcations, so we must use typeInfo on a
fresh version of oneWayAnova):

TypedSignature(

SimultaneousTypeSpecification(

> oneWayAnova <- copyOfOneWayAnova
> typeInfo(oneWayAnova) <-
+
+
+
+
+
+
+
+

response = "numeric",
predictor = "numeric"),

response = "numeric",
predictor = "factor"),

returnType = "anova")

TypedSignature(

This starts to show the ﬂexibility of Type-
SimultaneousTypeSpecification allows
Info.
for more than one TypedSignature.
least
one of the TypedSignatures must be correct for
the function to be evaluated.
Conceptually,
SimultaneousTypeSpecification performs a logi-
cal OR operation across the TypedSignatures. On

At

3

the other hand, each TypedSignature speciﬁes con-
ditions that must all apply. TypedSignature per-
forms a logical AND on its elements. In the exam-
ple here, regardless of argument type, the function
returns an object of class anova.

Flexible TypeInfo

The presentation so far emphasizes the sort of ba-
sic type speciﬁcation that is likely to be most use-
ful when making R functions available to other pro-
gramming languages. TypeInfo offers a range of
methods for validating type that can be very use-
ful for R programmers, but that employ concepts not
readily translated into other languages. A sampling
of these are presented here, along with additional de-
tail about the application of type speciﬁcation .

InheritsTypeTest

Notice in the example above that arguments are la-
beled with character strings of type names. A type
speciﬁcation of class character corresponds to an
InheritsTypeTest, as indicated explicitly for the
returnType speciﬁcation. An InheritsTypeTest re-
quires that the object belong to, or extends, the speci-
ﬁed class. For instance, the values passed to the func-
tion in the response variable must return TRUE from
the test is(response, "numeric"). Because of this,
oneWayAnova works with response as either numeric
or integer.

> iweight <- as.integer( weight )
> oneWayAnova( iweight, group )

Analysis of Variance Table

Response: iweight

Df Sum Sq Mean Sq F value Pr(>F)
1.8 1.80000 2.9455 0.1033

group
1
Residuals 18

11.0 0.61111

StrictIsTypeTest and DynamicTypeTest

What other ways does TypeInfo offer to spec-
StrictIsTypeTest requires an exact
ify type?
match between the class of an object and the spec-
iﬁed class(es).
To specifying a strict match for
response and returnValue, but an inherited match
for predictor, write

TypedSignature(

SimultaneousTypeSpecification(

> oneWayAnova <- copyOfOneWayAnova
> typeInfo(oneWayAnova) <-
+
+
+
+
+
> oneWayAnova(iweight, group) # ERROR

response = StrictIsTypeTest("numeric"),
predictor = InheritsTypeTest("factor")),

returnType = StrictIsTypeTest("anova"))

BEHIND THE SCENES

TYPE SPECIFICATION FOR YOUR FUNCTIONS

Both StrictIsTypeTestand InheritsTypeTest ac-
cept a vector of class names.

The DynamicTypeTest allows evaluation of arbi-
trary expressions during type checking. For instance,
the ANOVA anticipates that the length of predictor
is the same as the length of response:

SimultaneousTypeSpecification(

TypedSignature(

response = "numeric",
predictor = quote(

> typeInfo(oneWayAnova) <-
+
+
+
+
+
+
+
+
> short <- weight[-1]
> oneWayAnova(short, group)

length(predictor) ==

length(response) &&
is(predictor, "factor"))),

# ERROR

returnType = StrictIsTypeTest("anova"))

Note that the expression in DynamicTypeTest has ac-
cess to argument names, and uses quote to protect
premature evaluation. DynamicTypeTest can also be
used in the return statement.

Return types

the returnType applies to all
As written here,
TypedSignature’s. That is, the function always re-
turns an anova object, regardless of argument type.
Actually, each TypedSignature can have its own
returnType, allowing for a return type that depends
on argument type.

IndependentTypeSpecification

saw how several TypedSignature state-
We
predictor.
ments
IndependentTypeSpecification provides another
mechanism to specifying alternative types:

allow different

types

for

> oneWayAnova <- copyOfOneWayAnova
> typeInfo(oneWayAnova) <-
+
+
+

response = "numeric",
predictor = c( "factor", "numeric" ))

IndependentTypeSpecification(

IndependentTypeSpecification expects a list of
argument names, each with a character vector of pos-
sible types. While SimultaneousTypeSpecification
performs a logical OR across each TypedSignature,
IndependentTypeSpecification performs logical
OR within arguments.

Behind the scenes: TypeInfo limita-
tions and opportunities

Several aspects of TypeInfo provide opportunities
for creative application. Type tests in TypeInfo form
a hierarchy of S4 classes. This makes it easy to

4

transform typeInfo output to structures or text rep-
resentations that interface with other packages or
programming languages. The approach is to spec-
ify methods that traverse the TypeInfo hierarchy,
transforming TypeInfo objects into the desired for-
mat. InheritsTypeTest and StrictIsTypeTest rely
on named classes, including user-deﬁned S4 classes.
Coupled with methods for parsing S4 objects (e.g., in
the XML package), this provides one route to auto-
matically generating widgetInvoke graphical inter-
faces or bindings for web-based services.

TypeInfo is not a universal solution. Perhaps
the biggest limitation is that TypeInfo does not
deal with S4 methods. The rationale is that argu-
ments used for method dispatch must already sat-
isfy type criteria. However, S4 methods may con-
tain arguments that are not used for method dis-
patch, and the type of these arguments cannot be
typed. S4 method dispatch imposes a test equiv-
alent only to SimultaneousTypeSpecification in
conjunction with InheritsTypeTest, rather than al-
lowing the ﬂexibility of TypeInfo. In addition, the
valueClass argument of setMethod allows speciﬁ-
cation but not checking of the return type. A useful
extension would enable typeInfo to query S4 gener-
ics, providing a uniform interface to retrieving type
information.

Conceptually, TypeInfo works by inserting type-
checking code at the ﬁrst line of the function, and af-
ter (implicit or explicit) return statements. The ex-
tra code requires evaluation, slowing execution and
making TypeInfo inappropriate in situations where
speed is of the essence. In such situation, present a
public type-checked ‘wrapper’ to help ensures only
correct argument types reach the speed-critical func-
tions. TypeInfo does not usually have side-effects,
but a poorly written DynamicTypeTest could alter ar-
gument or return values unexpectedly.

Final hints and tips

We have seen how TypeInfo provides reﬂection,
annotating function deﬁnitions with information to
check argument types. The reﬂection provided by
TypeInfo has several advantages. The user is in-
formed of incorrect arguments, avoiding possibly
subtle errors during function execution. The pro-
grammer is free to focus on the body of the func-
tion, rather than argument type checking. Other pro-
grammers can determine argument requirements or
return values without detailed inspection of code or
documentation. These and other advantages suggest
application of TypeInfo as a way to enhance the ef-
fectiveness of your R programming.

For many purposes,

combination of
SimultaneousTypeSpecification, TypedSignature,
and a single returnType is the best way to use Type-
Info. This results in type signatures that trans-

the

FINAL HINTS AND TIPS

TYPE SPECIFICATION FOR YOUR FUNCTIONS

late readily into prototype concepts in other pro-
gramming languages, making it easier for both R
and non-R users to beneﬁt from the functions you
create. More elaborate formulations, especially
DynamicTypeTest, are unlikely to be useful outside
the R community, and may unnecessarily blur the
distinction between type information, argument val-
idation, and function execution. On the other hand,

clearly speciﬁed argument types may aid rigorous
formal testing (e.g., unit and regression tests) of re-
turn values prior to package release.

TypeInfo can be useful for all functions, but is es-
pecially beneﬁcial for functions exported in a pack-
age NAMESPACE. Don’t forget to add TypeInfo to
the ‘Depends’ ﬁeld of your package DESCRIPTION
ﬁle!

5


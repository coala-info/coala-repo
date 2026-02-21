# Code example from 'sojourner-vignette' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
  BiocStyle::markdown()

## ---- eval = FALSE------------------------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("sojourner")

## ---- eval = FALSE------------------------------------------------------------
#  devtools::install_github("sheng-liu/sojourner", build_vignettes = TRUE)

## ---- eval=TRUE, messsage = FALSE, warning=FALSE, results = 'hide'------------
library(sojourner)

## ---- eval = TRUE, results = 'hide'-------------------------------------------
folder=system.file("extdata","SWR1_2",package="sojourner")
trackll = createTrackll(folder=folder, input=3)

## ---- eval = TRUE-------------------------------------------------------------
str(trackll,max.level=2, list.len=2)

## ---- eval = FALSE------------------------------------------------------------
#  trackll=list(FOLDER=list(track=track))

## ---- eval = FALSE------------------------------------------------------------
#  # Construct trackll from data.frame
#  trackl=list(track_1=dataframe_1,
#              track_2=dataframe_2,
#              track_3=dataframe_3,
#              ...
#              track_n=dataframe_n)
#  
#  trackll=list(FOLDER_1=trackl_1,
#               FOLDER_2=trackl_2,
#               FOLDER_3=trackl_3,
#               ...
#               FOLDER_n=trackl_n,)

## ---- eval = TRUE, results = 'hide'-------------------------------------------
folder=system.file("extdata","SWR1_2",package="sojourner")
trackll = createTrackll(folder=folder, input=3)
trackll <- mergeTracks(folder=folder, trackll=trackll)

## ---- eval = TRUE-------------------------------------------------------------
str(trackll,max.level=2, list.len=2)

## ---- eval = TRUE, warning=FALSE, echo = TRUE, results = 'hold'---------------
# Specify the folder name and the track name
trackll[["SWR1_2"]]["mage6.1.4.1.1"]
# Alternatively, specify the index of the folder and the track
# trackll[[1]][1]

## ---- eval=TRUE, warning=FALSE, echo=TRUE, results = 'hold'-------------------
# Designate a folder and then create trackll from ImageJ .csv data
folder=system.file("extdata","SWR1_2",package="sojourner")
trackll = createTrackll(folder=folder, input=3)

# Alternatively, use interact to open file browser and select input data type
# trackll = createTrackll(interact = TRUE)

## ---- eval=TRUE, warning=FALSE, echo = TRUE-----------------------------------
# Basic function call of linkSkippedFrames
trackll.linked <- linkSkippedFrames(trackll, tolerance = 5, maxSkip = 10)

## ---- eval=TRUE, warning=FALSE, echo = TRUE-----------------------------------
trackll.filter=filterTrack(trackll ,filter=c(7,Inf))

# See the min and max length of the trackll
# trackLength() is a helper function output track length of trackll
lapply(trackLength(trackll),min)
lapply(trackLength(trackll.filter),min)

## ---- eval=TRUE, warning=FALSE, echo = TRUE-----------------------------------
trackll.trim=trimTrack(trackll,trimmer=c(1,20))

# See the min and max length of the trackll
# trackLength() is a helper function output track length of trackll
lapply(trackLength(trackll),max)
lapply(trackLength(trackll.trim),max)

## ---- eval=TRUE, warning=FALSE, echo=TRUE, results = 'hide'-------------------
# Basic masking with folder path with image masks
folder = system.file("extdata","ImageJ",package="sojourner")
trackll = createTrackll(folder, input = 3)
trackll.filter=filterTrack(trackll ,filter=c(7,Inf))
trackll.masked <- maskTracks(folder = folder, trackll = trackll.filter)

## ---- eval=TRUE, warning=FALSE, echo=TRUE, results = 'hide',fig.show="hide"----
# Plot mask
plotMask(folder)

## ---- eval=TRUE, warning=FALSE, echo=TRUE, results = 'hide',fig.show="hide"----
# If nuclear image is available
plotNucTrackOverlay(folder=folder,trackll=trackll)

## ---- eval=TRUE, warning=FALSE, echo=TRUE, results = 'hide',fig.show="hide"----
# If nuclear image is available
plotNucTrackOverlay(folder=folder,trackll=trackll.masked)

## ---- eval=FALSE--------------------------------------------------------------
#  # Basic function call to exportTrackll into working directory
#  exportTrackll(trackll)
#  
#  # Read exported trackll saved in working directory
#  trackll.2 <- createTrackll(folder = getwd(), input = 3)

## ---- eval = FALSE------------------------------------------------------------
#  # specify the path of the file containing trajectory index names, index file
#  index.file2=system.file("extdata","INDEX","indexFile2.csv",
#  package="sojourner")
#  # specify the folders containing the output files
#  folder1=system.file("extdata","SWR1",package="sojourner")
#  folder2=system.file("extdata","HTZ1",package="sojourner")
#  # plot trajectories specified in the trajectory index file
#  plotTrackFromIndex(index.file=index.file2,
#                     movie.folder=c(folder1,folder2),input=3)

## ---- eval = TRUE, warning=FALSE----------------------------------------------
dwellTime(trackll,plot=TRUE) # default t.interval=10, x.scale=c(0,250)

## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide'-----------------

# Specify folder with data
folder=system.file("extdata","HSF",package="sojourner")

# Create track list
trackll<-createTrackll(folder=folder, interact=FALSE, input=3, ab.track=FALSE, cores=1, frameRecord=TRUE)

# Take a look at the list by 
str(trackll,1)


## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide'-----------------
# Filter/choose tracks 3 frames or longer for all analysis
trackll.fi<-filterTrack(trackll=trackll, filter=c(min=3,max=Inf))

# Apply mask and remove tracks outside nuclei
trackll.fi.ma<-maskTracks(folder,trackll.fi)


## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide',fig.show="hide"----

# Overlay all tracks on nuclei
plotNucTrackOverlay(folder=folder,trackll=trackll.fi,cores=1, max.pixel=128,nrow=2,ncol=2,width=16,height=16)

# Overlay tracks after nuclear mask
plotNucTrackOverlay(folder=folder,trackll=trackll.fi.ma,cores=1, max.pixel=128,nrow=2,ncol=2,width=16,height=16)

## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide'-----------------
# Overlay tracks color coded for diffusion coefficient
plotTrackOverlay_Dcoef(trackll=trackll.fi.ma, Dcoef.range=c(-2,1), rsquare=0.8, t.interval=0.01, dt=6, resolution=0.107)


## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide'-----------------

# Merge tracks from different image files in the folder
trackll.fi.ma.me=c(mergeTracks(folder, trackll.fi.ma))



## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide'-----------------
folder2=system.file('extdata','HSF_2',package='sojourner')
trackll2=createTrackll(folder2,input=2, cores = 1)
trackll2=maskTracks(folder2,trackll2)
trackll2=mergeTracks(folder2,trackll2)

# Combine the tracklls together
Trackll.combine=combineTrackll(trackll=c(trackll,trackll2),merged=TRUE)

## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide'-----------------
# calculate MSD for all tracks longer than 3 frames
msd(Trackll.combine,dt=20,resolution=0.107,summarize=TRUE,cores=1,plot=TRUE,output=TRUE)


## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide',fig.show="hide"----
trackll.combine.trim=trimTrack(Trackll.combine,trimmer=c(1,11))

msd(trackll.combine.trim,dt=10,resolution=0.107,summarize=TRUE,cores=1,plot=TRUE,output=TRUE)

## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide'-----------------

Dcoef(trackll=trackll.combine.trim,dt=5, filter=c(min=6,max=Inf), method="static", plot=TRUE, output=TRUE)


## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide',fig.show="hide"----
## calculating displacement CDF

# Calculate all dislacement frequency and displacement CDF for all tracks longer than 3 frames
displacementCDF(trackll.combine.trim, dt=1, plot=TRUE, output=TRUE)


## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide',fig.show="hide"----
## Analysis for Residence time. 

# Calculate 1-CDF (survival probability) of the dwell time/residence time of all tracks (not trimmed) longer than 3 frames
compare_RT_CDF(trackll= Trackll.combine, x.max=100, filter=c(min=3,max=Inf), t.interval=0.5, output=FALSE)

## ---- eval = TRUE, warning=FALSE, echo=TRUE, results = 'hide'-----------------
# Calculate residence time of tracks by 2-component exponential decay fitting of the 1-CDF curve
fitRT(trackll= trackll.fi.ma.me, x.max=100, N.min=1.5, t.interval=0.5)


## ---- eval=FALSE, echo=TRUE, results='hide', warning=FALSE--------------------
#  sojournerGUI()

## ---- eval = TRUE-------------------------------------------------------------
sessionInfo()


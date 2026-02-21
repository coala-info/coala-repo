# Code example from 'flowcatchr_vignette' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, warning=FALSE-----------------------------------------
set.seed(42)
knitr::opts_chunk$set(
  comment='##'
)
# knitr::opts_chunk$set(comment=NA,
#                fig.align="center",
#                fig.width = 7,
#                fig.height = 7,
#                warning=FALSE)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("flowcatchR")

## ----install-devel, eval=FALSE------------------------------------------------
# install.packages("devtools") # if needed
# devtools::install_github("federicomarini/flowcatchR")

## ----helpmaintainer-----------------------------------------------------------
maintainer("flowcatchR")

## ----citationPkg--------------------------------------------------------------
citation("flowcatchR")

## ----loadData,results='hide',message=TRUE-------------------------------------
library("flowcatchR")
data("MesenteriumSubset")

## ----meseLoaded---------------------------------------------------------------
# printing summary information for the MesenteriumSubset object
MesenteriumSubset

## ----workflowCompact,eval=FALSE,results='hide'--------------------------------
# # one command to seize them all :)
# fullResults <- kinematics(trajectories(particles(channel.Frames(MesenteriumSubset,"red"))))

## ----newFrames,eval=FALSE-----------------------------------------------------
# # initialization
# fullData <- read.Frames(image.files="/path/to/folder/containing/images/", nframes=100)
# # printing summary information for the Frames object
# fullData

## ----inspectRaw,fig.height=4,fig.width=7.5,fig.cap="The first 9 frames of the MesenteriumSubset dataset. The red channel stores information about platelets, while the green channel is dedicated to leukocytes"----
inspect.Frames(MesenteriumSubset, nframes=9, display.method="raster")

## ----selectRed----------------------------------------------------------------
plateletsMesenterium <- channel.Frames(MesenteriumSubset, mode="red")
plateletsMesenterium

## ----inspectPlatelets,fig.height=4,fig.width=7.5,fig.cap="The first 9 frames for the red channel of the MesenteriumSubset dataset. This is just displaying the GrayScale signal for the red channel stored in `plateletsMesenterium` (for the thrombocytes)"----
inspect.Frames(plateletsMesenterium, nframes=9, display.method="raster")

## ----segmentPreprocess--------------------------------------------------------
preprocessedPlatelets <- preprocess.Frames(plateletsMesenterium,
                                    brush.size=3, brush.shape="disc",
                                    at.offset=0.15, at.wwidth=10, at.wheight=10,
                                    kern.size=3, kern.shape="disc",
                                    ws.tolerance=1, ws.radius=1)
preprocessedPlatelets

## ----inspectSegm,fig.height=4,fig.width=7.5,fig.cap="The first 9 frames after preprocessing of the MesenteriumSubset dataset. The binarized image shows the detected objects after thresholding."----
inspect.Frames(preprocessedPlatelets, nframes=9, display.method="raster")

## ----cropFrames---------------------------------------------------------------
croppedFrames <- crop.Frames(plateletsMesenterium,
                     cutLeft=6, cutRight=6,
                     cutUp=3, cutDown=3,
                     testing=FALSE)
croppedFrames

## ----rotateFrames-------------------------------------------------------------
rotatedFrames <- rotate.Frames(plateletsMesenterium, angle=30)
rotatedFrames

## ----selectFrames-------------------------------------------------------------
subsetFrames <- select.Frames(plateletsMesenterium,
                       framesToKeep=c(1:10,14:20))
subsetFrames

## ----normalizeFrames----------------------------------------------------------
normFrames <- normalizeFrames(plateletsMesenterium,normFun = "median")

## ----particleSet--------------------------------------------------------------
platelets <- particles(plateletsMesenterium, preprocessedPlatelets)
platelets

## ----selectParticles----------------------------------------------------------
selectedPlatelets <- select.particles(platelets, min.area=3)
selectedPlatelets

## ----checkSelection,fig.height=4,fig.width=7.5,fig.cap="Particles detected in the first 9 frames. Particles detected in the first 9 frames are shown in yellow, with their contours defined by the segmentation procedure."----
paintedPlatelets <- add.contours(raw.frames=MesenteriumSubset,
                                 binary.frames=preprocessedPlatelets,
                                 mode="particles")
inspect.Frames(paintedPlatelets, nframes=9, display.method="raster")

## ----penFunc------------------------------------------------------------------
defaultPenalty <- penaltyFunctionGenerator()
print(defaultPenalty)

## ----linkParticles------------------------------------------------------------
linkedPlatelets <- link.particles(platelets,  
                                  L=26, R=3,
                                  epsilon1=0, epsilon2=0,
                                  lambda1=1, lambda2=0,
                                  penaltyFunction=penaltyFunctionGenerator(),
                                  include.area=FALSE)
linkedPlatelets

## ----expo-impo,eval=FALSE-----------------------------------------------------
# # export to csv format
# export.particles(platelets, dir="/path/to/export/folder/exportParticleSet/")
# # re-import the previously exported, in this case
# importedPlatelets <- read.particles(particle.files="/path/to/export/folder/exportParticleSet/")

## ----generateTrajs------------------------------------------------------------
trajPlatelets <- trajectories(linkedPlatelets)
trajPlatelets

## ----cubeTrajs,fig.cap="A 2D+time representation of the trajectories. This is produced by plotting a `TrajectoryList` object",eval=TRUE----
plot(trajPlatelets, MesenteriumSubset)

## ----overviewTrajs,fig.height=4,fig.width=7.5,fig.cap='A 2D "flat" representation of the trajectories. This is more suitable to give an indication of the global movement'----
plot2D.TrajectorySet(trajPlatelets, MesenteriumSubset)

## ----contourTrajs-------------------------------------------------------------
paintedTrajectories <- add.contours(raw.frames=MesenteriumSubset,
                                    binary.frames=preprocessedPlatelets,  
                                    trajectoryset=trajPlatelets,
                                    mode="trajectories")
paintedTrajectories

## ----inspectTrajs,fig.height=4,fig.width=7.5,fig.cap="Particles detected in the first 9 frames. These are shown this time in colours corresponding to the identified trajectories, again with their contours defined by the segmentation procedure."----
inspect.Frames(paintedTrajectories,nframes=9,display.method="raster")

## ----traj11,fig.height=4,fig.width=7.5,fig.cap="First 9 frames for trajectory with ID 11. This is supplied to the `trajIds` argument of `add.contours`"----
traj11 <- add.contours(raw.frames=MesenteriumSubset,
                       binary.frames=preprocessedPlatelets,
                       trajectoryset=trajPlatelets,
                       mode="trajectories",
                       trajIDs=11)
traj11
inspect.Frames(traj11, nframes=9, display.method="raster")

## ----viewTraj11---------------------------------------------------------------
trajPlatelets[[11]]

## ----exportTraj11,eval=FALSE--------------------------------------------------
# export.Frames(traj11, dir=tempdir(), nameStub="vignetteTest_traj11",
#               createGif=TRUE, removeAfterCreatingGif=FALSE)

## ----loopExport,eval=FALSE----------------------------------------------------
# evaluatedTrajectories <- trajPlatelets
# 
# for(i in 1:length(trajPlatelets))
# {
#   paintedTraj <- add.contours(raw.frames=MesenteriumSubset,
#                               binary.frames=preprocessedPlatelets,
#                               trajectoryset=trajPlatelets,
#                               mode="trajectories",
#                               col="yellow",
#                               trajIDs=i)
#   export.Frames(paintedTraj,
#                 nameStub=paste0("vignetteTest_evaluation_traj_oneByOne_",i),
#                 createGif=TRUE, removeAfterCreatingGif=TRUE)
#   ### uncomment the code below to perform the interactive evaluation of the single trajectories
# 
#   #   cat("Should I keep this trajectory? --- 0: NO, 1:YES --- no other values allowed")
#   #   userInput <- readLines(n=1L)
#   #   ## if neither 0 nor 1, do not update
#   #   ## otherwise, this becomes the value for the field keep in the new TrajectoryList
#   #   evaluatedTrajectories@.Data[[i]]$keep <- as.logical(as.numeric(userInput))
# }

## ----kinemFeats---------------------------------------------------------------
allKinematicFeats.allPlatelets <- kinematics(trajPlatelets,
                                             trajectoryIDs=NULL, # will select all trajectory IDs 
                                             acquisitionFrequency=30, # value in milliseconds
                                             scala=50, # 1 pixel is equivalent to ... micrometer
                                             feature=NULL) # all kinematic features available

## ----kinemInspect-------------------------------------------------------------
allKinematicFeats.allPlatelets

## ----kinemFeatsAvailable------------------------------------------------------
allKinematicFeats.allPlatelets <- kinematics(trajPlatelets, feature="?")

## ----allVelos,fig.cap="Histogram of the curvilinear velocities for all trajectories identified in the MesenteriumSubset dataset",warning=FALSE----
allVelocities <- kinematics(trajPlatelets, feature="curvilinearVelocity")

hist(allVelocities, breaks=10, probability=TRUE, col="cadetblue",
     xlab="Curvilinear Velocities Distribution",
     main="Trajectory Analysis: Curvilinear Velocities")
lines(density(allVelocities, na.rm=TRUE), col="steelblue", lwd=2)

## ----snapFrames,eval=FALSE----------------------------------------------------
# snap(MesenteriumSubset,preprocessedPlatelets,
#      platelets,trajPlatelets,
#      frameID = 1,showVelocity = T)

## ----snapExample,echo=FALSE,fig.width=7,fig.cap="Output generated by the snap function. The user wanted to identify the particle and additionally display the trajectory information (ID, instantaneous velocity) on it."----
display(readImage(system.file("extdata/snapExp.jpg",package="flowcatchR")),
        method = "raster")

## ----launchShiny,eval=FALSE---------------------------------------------------
# shinyFlow()

## ----notebooksLocation--------------------------------------------------------
list.files(system.file("extdata",package = "flowcatchR"),pattern = "*.ipynb")

## ----ipynb,eval=FALSE---------------------------------------------------------
# $ ipython notebook

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()


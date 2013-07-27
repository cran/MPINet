\name{getPSS}
\alias{getPSS}
\title{Evaluate the CGNB score of metabolites}
\description{
  Integrate the non-equivalence scores and the initial bias scores of metabolites by the monotonic spline model.
}
\usage{

getPSS(riskmeta,plot=TRUE,binsize=400)
}

\arguments{
  \item{riskmeta}{A character vector of interesting metabolites, for each element is a pubchem CID.}
  \item{plot}{A logical. If TRUE the fit line obtained by the monotonic spline model will be plotted.}
  \item{binsize}{plot the fraction of differential metabolites in bins of this size.}
  }
\details{
This function is used to integrate the non-equivalence of metabolites and the character of differential metabolites.The binsize can be assigned according to the best visualization. 

}

\value{
A data frame with 4 columns including "riskmeta", "meanstrvalue", "pss" and "CGNB". Each row correspond a metabolite pubchem CID. "riskmeta" indicates whether the metabolite is in the interesting set (with "1" is in and "0" is not in)."meanstrvalue" is the mean SOC value of the metabolite. "pss" is the score value obtained by the monotonic spline model. "CGNB" is the CGNB score of metabolite which is calculated as 1 substract the score value obtained by monotonic spline model. This score is used to calculate pathway weight in the subsequent pathway analysis.

}

\references{
 Young, M.D., Wakefield, M.J., Smyth, G.K. and Oshlack, A. (2010) Gene ontology analysis for RNA-seq: accounting for selection bias. Genome Biol, 11, R14.
}

\author{Yanjun Xu <tonghua605@163.com>, Chunquan Li <lcqbio@aliyun.com.cn> and Xia Li <lixia@hrbmu.edu.cn>}

\examples{
\dontrun{

#######################################


##########get example data
risk<-GetExampleData(dataset="prostate")

###########calculate the CGNB score
pss<-getPSS(risk ,plot=F)
CGNBscore<-pss[,"CGNB"]
names(CGNBscore)<-rownames(pss)
##########print the CGNB score of some metabolites to screen
head(CGNBscore)
#identify dysregulated pathways
anncpdpre<-identifypathway(risk,pss,pathType="KEGG",method="MPINet",annlim=1,bglim=6)
#convert ann to data.frame
result<-printGraph(anncpdpre,pathType="KEGG",method="MPINet")
head(result)






}
}
\keyword{ file }
\name{printGraph}
\alias{printGraph}
\title{Print the results of identification}
\description{
  Print the identification results of MPINet.
}
\usage{

     printGraph(ann,detail=FALSE,method="MPINet",pathType="KEGG")
}

\arguments{
  \item{ann}{ A list. The results returned from the function \code{\link{identifypathway}}.}
  \item{detail}{ A logical. If true, metabolite lists from the function \code{\link{identifypathway}}
                         are converted into strings, which are used to display and write results with metabolites. }
  \item{method}{ A character string. which is the argument \code{method} used in the function \code{\link{identifypathway}}.}
  \item{pathType}{ A character string vector. which is the argument \code{pathType} used in the function \code{\link{identifypathway}}.}
}

\details{

The function can convert the results of identification to \code{data.frame}.

Note that the argument \code{method} and \code{pathType} should be assigned the same as the function \code{\link{identifypathway}}.
}

\value{
A \code{data.frame} of the identification results. (i)If the argument \code{method} is "MPINet", it includes the following elements: 'pathwayName', 'annComponentRatio', 'annBgRatio', 'weight', 'pvalue', 'fdr', 'annComponentList', 'annBgComponentList', 'annComponentinNetRatio', 'anncompinNetworkList', 'riskcompinNetworkList'. The 'annComponentRatio' is the ratio of the annotated metabolites. For example, 30/1000 means that 30 metabolites in 1000 interesting metabolites are annotated in this pathway. The 'annBgRatio' is the ratio of background metabolites, for example, 10/4994 means that 10 of the 4994 human metabolites in the background are annotated in this pathway. The 'annComponentinNetRatio' indicates the ratio of annotated metabolites in the global human metabolite network. The 'annComponentList' and 'annBgComponentList' are the annotated metabolites and the annotated background metabolites. The 'anncompinNetworkList' and 'riskcompinNetworkList' are the annotated metabolites in network and the interesting metabolites in network.
(ii)If the argument \code{method} is "Hyper", it includes the following elements: 'pathwayName', 'annComponentRatio', 'annBgRatio', 'pvalue', 'fdr', 'annComponentList', 'annBgComponentList'. When the argument \code{pathType} is "KEGG", the 'pathwayID' is included. When the  the argument \code{pathType} is not "KEGG", the 'pathsource' is included. Detailed information is provided in the function \code{\link{identifypathway}}.

}
\author{Yanjun Xu <tonghua605@163.com>, Chunquan Li <lcqbio@aliyun.com.cn> and Xia Li <lixia@hrbmu.edu.cn>}
\seealso{\code{\link{identifypathway}}}

\examples{
\dontrun{

#######################################

#get example data
#### get the type 2 diabetes data set 1
risk<-GetExampleData(dataset="diabetes1") 
#### integrate the non-equivalence of metabolites and the character of
#### differential metabolites by the monotonic spline model 
pss<-getPSS(risk,plot=TRUE)         
#identify dysregulated pathways
anncpdpre<-identifypathway(risk,pss,pathType="KEGG",method="MPINet",annlim=1,bglim=6)
#convert ann to data.frame
result<-printGraph(anncpdpre,pathType="KEGG",method="MPINet")
#print part of the results to screen
head(result)

result1<-printGraph(anncpdpre,pathType="KEGG",method="MPINet",detail=TRUE)
#print part of the results to screen
head(result1)






}
}
\keyword{ file }
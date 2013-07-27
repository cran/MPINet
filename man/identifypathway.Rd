\name{identifypathway}
\alias{identifypathway}
\title{A novel pathway identification approach based on metabolite set}
\description{
  Identify pathways via global weighted human metabolite network, which considering both the global non-equivalence of metabolites in pathway and the bias existing in metabonomic experiment technology.
}
\usage{

identifypathway(componentList,PSS,pathType="KEGG",method="MPINet",weightnum=6,
               backgroundcid=Getenvir("getBackground"),annlim=1,bglim=6,
               order="pvalue",decreasing=FALSE)
}
\arguments{
  \item{componentList}{A character vector of interesting metabolites, for each element is a pubchem CID.}
  \item{PSS}{A data frame, which is obtained by the function \code{\link{getPSS}}. }  
  \item{pathType}{A character string vector specifying the pathway source,must be some of the elements in the vector c("KEGG", "consensusPath", "PharmGKB", "SMPDB", 
                  "Wikipathways", "PID", "Reactome", "INOH", "BioCarta", "HumanCyc", "EHMN"). The default is KEGG.}
  \item{method}{A character string specifying the pathway identification method, must be one of "MPINet"(default) and "Hyper".}
  \item{weightnum}{A value. The power of the relative weight of pathway. The default value is 6.}
  \item{backgroundcid}{A character vector of the background metabolites, which is used to identify the statistically significant pathways.}  
  \item{annlim}{An integer. Only use pathways annotated at least this number of metabolites. The default value is 1.} 
  \item{bglim}{An integer. Only use pathways containing at least this number of metabolites. The default value is 6.}
  \item{order}{A character string. Should be one of "pvalue" and "fdr".}
  \item{decreasing}{A logical. Should the sort order be increasing or decreasing?} 
}
\details{

The function can annotate a set of metabolites to pathways and identify the statistically significantly enriched pathways. The argument \code{method} should be one of "MPINet" and "Hyper".When the "MPINet" is specified, MPINet method which is considers both the global non-equivalence of metabolites in pathway and bias existing in metabonomic experiment technology is used. When the "Hyper" method is selected, the Hypergeometric test is used.
If users don't set the values of the argument \code{backgroundcid}, the human background metabolites will be obtained from our default data set which contains 4994 metabolites and selected from five databases including MSEA, HMDB, SMPDB, KEGG and Reactome.
Note that the argument \code{weightnum} can be assigned according to the bias level, which can be evaluated through the \code{\link{getPSS}} function by set the \code{plot} argument as "TRUE". If the plot line is more closer to right up, the \code{weightnum} should be assigned a higher value.
}
\value{

A list. Each element of the list is another list.  (i)If the argument \code{method} is "MPINet", it includes the following elements: 'pathwayName', 'annComponentList', 'annComponentNumber', 'annBgComponentList', 'annBgNumber', 'componentNumber', 'bgNumber', 'pvalue', 'fdr', 'InWeight', 'weight', 'anncompinNetworkNum', 'anncompinNetworkList', 'riskcompinNetworkNum', 'riskcompinNetworkList'. They correspond to pathway name, the submitted metabolites annotated to a pathway, numbers of submitted metabolites annotated to a pathway, the background metabolites annotated to a pathway, numbers of background metabolites annotated to a pathway, numbers of submitted metabolites, numbers of background metabolitess, p-value of the Wallenius' noncentral hypergeometric test, Benjamini-Hochberg fdr values, the mean score value of metabolites in pathway, the final weight of pathway, numbers of the submitted metabolites annotated to a pathway and in the global human metabolite network, the submitted metabolites annotated to a pathway and in the global human metabolite network, numbers of submitted metabolites in the global human metabolite network, submitted metabolites in the global human metabolite network.
When the argument \code{pathType} is "KEGG", the 'pathwayId' element is also included, which is the pathway identifier in KEGG. When the argument \code{pathType} is not "KEGG", the 'pathsource' element is also included, which stands for the source of pathway.
(ii)If the argument \code{method} is "Hyper", it includes the same elements as (i), but not includes the following elements: 'InWeight', 'weight', 'anncompinNetworkNum', 'anncompinNetworkList', 'riskcompinNetworkNum', 'riskcompinNetworkList'. To save the results, the \code{list} can be converted to the \code{data.frame} by the function \code{\link{printGraph}}. 

Note that \code{componentList} submitted by users must be a 'character' vector.
}

\references{

Subramanian, A., Tamayo, P., Mootha, V.K., Mukherjee, S., Ebert, B.L., Gillette, M.A., Paulovich, A., Pomeroy, S.L., Golub, T.R., Lander, E.S. et al. (2005) Gene set enrichment analysis: a knowledge-based approach for interpreting genome-wide expression profiles. Proc Natl Acad Sci U S A, 102, 15545-15550.

Li, C., Li, X., Miao, Y., Wang, Q., Jiang, W., Xu, C., Li, J., Han, J., Zhang, F., Gong, B. et al. (2009) SubpathwayMiner: a software package for flexible identification of pathways. Nucleic Acids Res, 37, e131.

}

\author{Yanjun Xu <tonghua605@163.com>, Chunquan Li <lcqbio@aliyun.com.cn> and Xia Li <lixia@hrbmu.edu.cn>}


\examples{
\dontrun{

#####identify pathways related with metastatic prostate cancer###########
#example 1
#get example data
#### get the metastatic prostate cancer interesting metabolite data set
risk<-GetExampleData(dataset="prostate") 
#### integrate the global non-equivalence of metabolites and the character of 
#### differential metabolites by the monotonic spline model
pss<-getPSS(risk)         

#identify pathways
anncpdpre<-identifypathway(risk,pss,pathType="KEGG",method="MPINet",annlim=1,bglim=6)
#convert ann to data.frame
result<-printGraph(anncpdpre,pathType="KEGG",method="MPINet")
#print part of the results to screen
head(result)

##write the results to tab delimited file. 
write.table(result,file="result.txt",row.names=FALSE,sep="\t")

result1<-printGraph(anncpdpre,pathType="KEGG",method="MPINet",detail=TRUE)
##write the results to tab delimited file. 
write.table(result1,file="result1.txt",row.names=FALSE,sep="\t")


#example 2
#get example data from file
risk<-read.table(paste(system.file(package="MPINet"),"/localdata/prostate.txt",sep=""),
header=F,sep="\t","\"")

####convert the data to a character vector
risk<-as.character(risk[[1]])

pss<-getPSS(risk)  

#identify pathways
anncpdpre<-identifypathway(risk,pss,pathType="KEGG",method="MPINet",annlim=1,bglim=6)
#convert ann to data.frame
result<-printGraph(anncpdpre,pathType="KEGG",method="MPINet")
#print part of the results to screen
head(result)

#example 3
#get example data
#### get the metastatic prostate cancer interesting metabolite data set
risk<-GetExampleData(dataset="prostate") 
pss<-getPSS(risk)  

#identify dysregulated Reactome and KEGG pathways
anncpdpre<-identifypathway(risk,pss,pathType=c("KEGG","Reactome"),
method="MPINet",annlim=1,bglim=6)
#convert ann to data.frame
result<-printGraph(anncpdpre,pathType=c("KEGG","Reactome"),method="MPINet")
#print part of the results to screen
head(result)



}
}
\keyword{ file }


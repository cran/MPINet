\name{GetExampleData}
\alias{GetExampleData}
\title{Get the example data set }
\description{
  Get the example data set.
}
\usage{
     GetExampleData(dataset)

}

\arguments{
  \item{dataset}{A character string, must be one of "prostate" (default), "diabetes1" and "diabetes2".}
  
  
}





\details{
The example data  are obtained from the environment variable \code{\link{MPINetData}}.
}
\value{
   A character vector of interesting metabolites, for each element is a pubchem CID
}
\author{Yanjun Xu <tonghua605@163.com>, Chunquan Li <lcqbio@aliyun.com.cn> and Xia Li <lixia@hrbmu.edu.cn>}
\references{
Sreekumar, A., Poisson, L.M., Rajendiran, T.M., Khan, A.P., Cao, Q., Yu, J., Laxman, B., Mehra, R., Lonigro, R.J., Li, Y. et al. (2009) Metabolomic profiles delineate potential role for sarcosine in prostate cancer progression. Nature, 457, 910-914.

Suhre, K., Meisinger, C., Doring, A., Altmaier, E., Belcredi, P., Gieger, C., Chang, D., Milburn, M.V., Gall, W.E., Weinberger, K.M. et al. (2010) Metabolic footprint of diabetes: a multiplatform metabolomics study in an epidemiological setting. PLoS ONE, 5, e13953.
}


\examples{
\dontrun{

#obtain the metastatic prosate cancer data set
Exampledata<-GetExampleData(dataset="prostate")
head(Exampledata)

}
}
\keyword{ file }

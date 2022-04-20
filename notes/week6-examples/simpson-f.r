simpson1<-function(data,type="complement"){
  simpson.diversity<-numeric(ncol(data))
  for(j in 1:ncol(data)){
    soma<-sum(data[,j])
    prop<-data[,j]/soma
    prop2<-prop^2
    D<-sum(prop2)
    if(type=="inverse") (simp<-1/D)
    if(type=="complement") (simp<-1-D)
    simpson.diversity[j]<-simp
  }
  plot.number<-1:ncol(data)
  return(rbind(plot.number,simpson.diversity))
}


###this is a simple example of function in R








####

simpson2<-function(data,type="complement"){
  simpson.diversity<-numeric(ncol(data))
  for(j in 1:ncol(data)){
    soma<-sum(data[,j])
    prop<-data[,j]*(data[,j]-1)
    prop2<-sum(prop)
    D<-prop2/(soma*(soma-1))
    if(type=="inverse") (simp<-1/D)
    if(type=="complement") (simp<-1-D)
    simpson.diversity[j]<-simp
  }
  plot.number<-1:ncol(data)
  return(rbind(plot.number,simpson.diversity))
}

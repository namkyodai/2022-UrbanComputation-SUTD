shannon.h<-function(data){
  H<-numeric(nrow(data))
  mult<-numeric(length(data[1,]))
  
  for(i in 1:nrow(data)){
    prop<-data[i,]/sum(data[i,])
    
    for(j in 1:ncol(data)){
      mult[j]<-prop[j]*log(prop[j])
    }
    
    H[i]<- -sum(mult, na.rm=T)
  }
  plot.number<-1:nrow(data)
  return(rbind(plot.number,H))
}
####

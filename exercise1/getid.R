
getid <- function(m){
  prefix <- unique(do.call(rbind,strsplit(idspl[,1],split = ''))[,1])
  infix <- unique(do.call(rbind,strsplit(idspl[,2],split = ''))[,1])
  if(m==3){
    str <- strsplit(idspl[,3],split = '')
    t <- NULL  
    for(i in 1:(nrow(idspl)-1)){
      t <- paste(t,str[[i]][1])
    }
   postfix <-unique(unlist(strsplit(t,split = '')))[-1]
  }
  switch(m,
         '1'=prefix,
         '2'=infix,
         '3'=postfix
  )
}
getid(3)

